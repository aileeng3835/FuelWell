float calculateBMR(User user) {
    if (user.sex.equalsIgnoreCase("male")) {
        return (10 * user.weight) + (6.25 * user.userHeight) - (5 * user.age) + 5;
    } else if (user.sex.equalsIgnoreCase("female")) {
        return (10 * user.weight) + (6.25 * user.userHeight) - (5 * user.age) - 161;
    }
    return 0;
}

int calculateCaloriesPerDay(User user) {
    float bmr = calculateBMR(user);
    float maintenance = bmr * 1.4;
    
    if (user.diet == null) {
        return round(maintenance);
    }

    if (user.diet.isMaintain || user.diet.dietName.equalsIgnoreCase("MaintainHealth") || user.diet.dietName.equalsIgnoreCase("dietTemplate")) {
        return round(maintenance);
    }

    int daysRemaining = user.diet.numDays - user.diet.daysPassed;
    if (daysRemaining <= 0) daysRemaining = 30;

    if (user.diet.targetWeight <= 10) {
        if (user.diet.isLoseWeight || user.diet.dietName.equalsIgnoreCase("Cut") || user.diet.dietName.equalsIgnoreCase("Lose Weight")) {
            user.diet.targetWeight = user.weight - 4.0;
        } else if (user.diet.dietName.equalsIgnoreCase("Bulk")) {
            user.diet.targetWeight = user.weight + 4.0;
        } else {
            user.diet.targetWeight = user.weight;
        }
    }

    float weightDif = user.diet.targetWeight - user.weight;
    float weightPerDay = weightDif / daysRemaining;
    float additionalCals = 0;

    if (weightDif > 0) {
        additionalCals = weightPerDay * 6160; 
    } else {
        additionalCals = weightPerDay * 7700;
    }

    float dailyCals = maintenance + additionalCals;
    
    if (user.sex.equalsIgnoreCase("female") && dailyCals < 1200) dailyCals = 1200;
    if (user.sex.equalsIgnoreCase("male") && dailyCals < 1500) dailyCals = 1500;
    
    if (dailyCals > 5000) dailyCals = 5000;
    
    return round(dailyCals);
}
    
HashMap<String, Float> calcMacros(User user, float calories) {
    HashMap<String, Float> macros = new HashMap<String, Float>();
    macros.put("protein", (calories * user.diet.proteinPercent) / 4);
    macros.put("carbs", (calories * user.diet.carbsPercent) / 4);
    macros.put("fat", (calories * user.diet.fatPercent) / 9);
    return macros;
}

void resetUser(User user) {
    user.name = "Guest";
    user.age = 0;
    user.sex = "male";
    user.userHeight = 0;
    user.weight = 0;
    user.dietaryRestrictions.clear();
    if(dietList.size() > 0) {
        user.diet = dietList.get(0);
        user.diet.targetWeight = 0;
    }
}

ArrayList<Food> loadFoods(){
    ArrayList<Food> foods = new ArrayList<Food>();

    JSONObject json = loadJSONObject("FoodData.json");
    JSONArray foodList = json.getJSONArray("FoodList");

    for (int i = 0; i < foodList.size(); i++){
        JSONObject foodObj = foodList.getJSONObject(i);
        String name = foodObj.getString("name");

        if (name.equals("foodTemplate")) continue;

        float fat = foodObj.getFloat("gramsFat");
        float carbs = foodObj.getFloat("gramsCarbs");
        float protein = foodObj.getFloat("gramsProtein");
        float sugar = foodObj.getFloat("gramsSugar");

        JSONArray restrictionsJSON = foodObj.getJSONArray("restrictions");
        JSONArray categoriesJSON = foodObj.getJSONArray("otherCategories");

        String[] restrictions = new String[restrictionsJSON.size()];
        String[] categories = new String[categoriesJSON.size()];

        for (int j = 0; j < restrictions.length; j++) {
            restrictions[j] = restrictionsJSON.getString(j);
        }

        for (int j = 0; j < categories.length; j++) {
            categories[j] = categoriesJSON.getString(j);
        }

        foods.add(new Food(name, fat, carbs, protein, sugar, restrictions, categories));
    }
    return foods;
}

boolean foodMatchesRestrictions(Food food, User user) {
    if(user.dietaryRestrictions.size() == 0) return true;
    
    for (String restriction : user.dietaryRestrictions) {
        boolean found = false;
        for (String category : food.restrictionCategories) {
            if (restriction.equalsIgnoreCase(category)) {
                found = true;
                break;
            }
        }
        if (found) return false;
    }
    return true;
}


ArrayList<Food> recommendFoods(User user) {
    ArrayList<Food> recs = new ArrayList<Food>();
    if(user.diet == null) return recs;

    float proteinNeeded = user.diet.proteinPerDay;
    float carbsNeeded = user.diet.carbsPerDay;
    float fatNeeded = user.diet.fatPerDay;

    for (Food food : foodDB) {
        if (!foodMatchesRestrictions(food, user)) continue;
        
        boolean goodProtein = food.gramsProtein >= 15;
        boolean goodCarbs = food.gramsCarbs >= 15;
        boolean goodFat = food.gramsFat >= 10;

        if (proteinNeeded > carbsNeeded && proteinNeeded > fatNeeded && goodProtein) {
            recs.add(food);
        } else if (carbsNeeded > fatNeeded && goodCarbs) {
            recs.add(food);
        } else if (goodFat) {
            recs.add(food);
        } else if (recs.size() < 3) {
            recs.add(food); 
        }

        if (recs.size() >= 6) break;
    }
    return recs;
}

String getServingSuggestion(Food food, String macroType, float targetAmount) {
    float gramsPer100 = 0;
    if (macroType.equalsIgnoreCase("protein")) gramsPer100 = food.gramsProtein;
    else if (macroType.equalsIgnoreCase("carbs")) gramsPer100 = food.gramsCarbs;
    else if (macroType.equalsIgnoreCase("fat")) gramsPer100 = food.gramsFat;
    
    if (gramsPer100 <= 0) return "100g";

    float gramsNeeded = (targetAmount / gramsPer100) * 100;
    return round(gramsNeeded) + "g";
}

ArrayList<Diet> createDietsFromJson() {
    JSONObject jsonData = loadJSONObject("Diets.json");
    JSONArray jsonDietList = jsonData.getJSONArray("DietsList");
    ArrayList<Diet> list = new ArrayList<Diet>();
    for(int i=0; i<jsonDietList.size(); i++) {
        JSONObject currentDiet = jsonDietList.getJSONObject(i);
        String name = currentDiet.getString("name");
        if(name.equals("dietTemplate")) continue;
        
        float proteinPercent = currentDiet.getFloat("proteinPercent");
        float carbsPercent = currentDiet.getFloat("carbsPercent");
        float fatPercent = currentDiet.getFloat("fatPercent");
        int totalDays = currentDiet.getInt("totalDays");
        int daysPassed = currentDiet.getInt("daysPassed");
        boolean isMaintain = currentDiet.getBoolean("isMaintain");
        boolean isLoseWeight = currentDiet.getBoolean("isLoseWeight");
        float targetWeight = currentDiet.getFloat("targetWeight");
        list.add(new Diet(name, proteinPercent, carbsPercent, fatPercent, totalDays, daysPassed, isMaintain, isLoseWeight, targetWeight));
    }
    return list;
}

User createUserFromJson(ArrayList<Diet> dietList) {
    JSONObject jsonUser = loadJSONObject("User.json");
    String name = jsonUser.getString("name");
    int age = jsonUser.getInt("age");
    String sex = jsonUser.getString("sex");
    float userHeight = jsonUser.getFloat("height");
    float weight = jsonUser.getFloat("weight");
    
    JSONArray tempDietRestrictions = jsonUser.getJSONArray("dietaryRestrictions");
    ArrayList<String> dietaryRestrictions = new ArrayList<String>();
    if(tempDietRestrictions != null) {
        for(int i=0; i<tempDietRestrictions.size(); i++) {
            dietaryRestrictions.add(tempDietRestrictions.getString(i));
        }
    }
    String dietname = jsonUser.getString("dietname");
    return new User(name, age, sex, userHeight, weight, dietaryRestrictions, dietname, dietList);  
}

void saveUserToJson(User user) {
    JSONObject json = new JSONObject();
    json.setString("name", user.name);
    json.setInt("age", user.age);
    json.setString("sex", user.sex);
    json.setFloat("height", user.userHeight);
    json.setFloat("weight", user.weight);

    JSONArray restrictions = new JSONArray();
    for(int i = 0; i < user.dietaryRestrictions.size(); i++) {
        restrictions.setString(i, user.dietaryRestrictions.get(i));
    }
    json.setJSONArray("dietaryRestrictions", restrictions);

    if(user.diet != null) {
        json.setString("dietname", user.diet.dietName);
    }
    saveJSONObject(json, "data/User.json");
}

void saveAllDiets(ArrayList<Diet> dietsList) {
    JSONObject root = new JSONObject();
    JSONArray diets = new JSONArray();
    for(int i = 0; i < dietsList.size(); i++) {
        Diet d = dietsList.get(i);
        JSONObject obj = new JSONObject();
        obj.setString("name", d.dietName);
        obj.setFloat("proteinPercent", d.proteinPercent);
        obj.setFloat("carbsPercent", d.carbsPercent);
        obj.setFloat("fatPercent", d.fatPercent);
        obj.setBoolean("isMaintain", d.isMaintain);
        obj.setBoolean("isLoseWeight", d.isLoseWeight);
        obj.setInt("totalDays", d.numDays);
        obj.setInt("daysPassed", d.daysPassed);
        obj.setFloat("targetWeight", d.targetWeight);
        diets.setJSONObject(i, obj);
    }
    root.setJSONArray("DietsList", diets);
    saveJSONObject(root, "data/Diets.json");
}

Diet fetchDietWithDietName(String dietName, ArrayList<Diet> dietsList) {
    for(int i = 0; i<dietsList.size(); i++) {
        if (dietsList.get(i).dietName.equals(dietName)) {
            return dietsList.get(i);
        }
    }
    return null;
}

String[] fetchAllDietNames(ArrayList<Diet> dietsList) {
    String[] dietNames = new String[dietsList.size()];
    for(int i = 0; i<dietsList.size(); i++) {
        dietNames[i] = dietsList.get(i).dietName;
    }
    return dietNames;
}

void addDiet(String name, float protein, float carbs, float fat, int days, int totalDays, boolean maintain, boolean loseWeight, float targetWeight) {
    Diet newDiet = new Diet(name, protein, carbs, fat, totalDays, days, maintain, loseWeight, targetWeight);
    dietList.add(newDiet);
    saveAllDiets(dietList);
}

void editDiet(String dietName, float protein, float carbs, float fat) {
    Diet d = fetchDietWithDietName(dietName, dietList);
    if(d != null) {
        d.proteinPercent = protein;
        d.carbsPercent = carbs;
        d.fatPercent = fat;
        saveAllDiets(dietList);
    }
}