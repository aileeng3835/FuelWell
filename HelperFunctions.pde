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


HashMap<String, Float> recommendFoods(User user, ArrayList<Food> foodData) {
    // ArrayList<Food> finalRecommentations = new ArrayList<Food>(); // final recs food list
    float totalFoodGrams = 0;
    HashMap<String, Float> recommendedFoodGrams = new HashMap<String, Float>();

    ArrayList<Food> safeToEatFoods = new ArrayList<Food>();
    for(Food food : foodData) { // i'm yoinking raama's way of doing for loops here
        if(foodMatchesRestrictions(food, user)) {
            safeToEatFoods.add(food);
        }
    }

    float proteinStillNeeded = user.diet.proteinPerDay;
    float carbsStillNeeded = user.diet.carbsPerDay;
    float fatStillNeeded = user.diet.fatPerDay;

    HashMap<String, Integer> howOftenFoodHasAppeared = new HashMap<String, Integer>(); // tracks how often a specfic food appears
    int percentErrorTolerance = 3; // how much error we tolerate within our plan

    for (int i = 0; i < 20; i++) { // goes for as many iterations as is specficed


        if ((((proteinStillNeeded / user.diet.proteinPerDay) * 100 < percentErrorTolerance) && ((carbsStillNeeded / user.diet.carbsPerDay) * 100 < percentErrorTolerance) && ((fatStillNeeded / user.diet.fatPerDay) * 100 < percentErrorTolerance)) || totalFoodGrams > 1500) {
            break;
        }
        Food bestFoodToAdd = null;
        float bestFoodScore = -99999999.9; // we set it really negative initially because scores can go into the negatives

        for (Food food : safeToEatFoods) { 
            float currentFoodScore = (food.gramsProtein * proteinStillNeeded) + (food.gramsCarbs * carbsStillNeeded) + (food.gramsFat * fatStillNeeded); // the base score for the current food
            
            // a lot of the food score numbers here are completely arbitrary, so play around with them if you wish

            // if we've already hit the amount of a macro needed, and the food we're currently looking at has that macro, then subtract from the current food's score
            // we don't do one if statement because we want it to be even more negative if the food exceeds two or more already met macro categories
            if (proteinStillNeeded <= 0 && food.gramsProtein > 0) {
                currentFoodScore -= 40;
            }
            if (carbsStillNeeded <= 0 && food.gramsCarbs > 0) {
                currentFoodScore -= 40;
            }
            if (fatStillNeeded <= 0 && food.gramsFat > 0) {
                currentFoodScore -= 40;
            }

            float densityOfCurrentFood = food.gramsProtein + food.gramsCarbs + food.gramsFat;
            float bonusPointsForLowDensity = (100 - densityOfCurrentFood) * 0.15; // this makes sure that we still get foods that aren't super macro-packed, for some variety (without this something like lettuce would never be picked)
            currentFoodScore += bonusPointsForLowDensity;

            // an additional penalty for having a food recomended too often
            float timesUsedPenalty = howOftenFoodHasAppeared.getOrDefault(food.name, 0) * 30.0;
            currentFoodScore -= timesUsedPenalty;

            if (currentFoodScore > bestFoodScore) {
                bestFoodScore = currentFoodScore;
                bestFoodToAdd = food;
            }

        }

        if (bestFoodToAdd == null) { // may not be required, idk i'll keep it in for now
            break;
        }

        float maxGramsPerServing;
        if (bestFoodToAdd.gramsProtein + bestFoodToAdd.gramsCarbs + bestFoodToAdd.gramsFat > 30) {
            maxGramsPerServing = 150.0;
        }
        else {
            maxGramsPerServing = 250.0;
        }

        // this chunck of code basically checks if a certain amount of grams would go over the required grams (if we still need more grams that is), and if it does, it sets the maxServingGrams to a value that won't be in excess of what is stated
        // yeah this code could be more compact but my like 2am brain can't handle reading it so unessesarily long code it is
        if (bestFoodToAdd.gramsProtein > 0 && proteinStillNeeded > 0) {
            if (maxGramsPerServing > (proteinStillNeeded / bestFoodToAdd.gramsProtein) * 100) {
                maxGramsPerServing = (proteinStillNeeded / bestFoodToAdd.gramsProtein) * 100;
            }
        }
        if (bestFoodToAdd.gramsCarbs > 0 && carbsStillNeeded > 0) {
            if (maxGramsPerServing > (carbsStillNeeded / bestFoodToAdd.gramsCarbs) * 100) {
                maxGramsPerServing = (carbsStillNeeded / bestFoodToAdd.gramsCarbs) * 100;
            }
        }
        if (bestFoodToAdd.gramsFat > 0 && fatStillNeeded > 0) {
            if (maxGramsPerServing > (fatStillNeeded / bestFoodToAdd.gramsFat) * 100) {
                maxGramsPerServing = (fatStillNeeded / bestFoodToAdd.gramsFat) * 100;
            }
        }

        if (maxGramsPerServing < 20.0) { // if the serving size is really small, don't bother
            safeToEatFoods.remove(bestFoodToAdd); // removes it from consideration
            continue;
        }

        

        howOftenFoodHasAppeared.put(bestFoodToAdd.name, howOftenFoodHasAppeared.getOrDefault(bestFoodToAdd.name, 0) + 1); // increments how often the food has been selected by one (it starts at 0 and adds one if its never been selected before)
        
        float absoluteFoodGramCap = 250.0;

        if (recommendedFoodGrams.containsKey(bestFoodToAdd.name)) { // if we have already added the food previously, then just increment its entry in the hashmap by the appropriate amount
            float currentGrams = recommendedFoodGrams.get(bestFoodToAdd.name);
            if (currentGrams + maxGramsPerServing >= absoluteFoodGramCap) {
                maxGramsPerServing = absoluteFoodGramCap - currentGrams; // if the cap is exceeded this turn, then to find out how many grams we need to add in order to hit the cap we just subtract the already existing amount of grams from the cap on the grams
                totalFoodGrams += absoluteFoodGramCap - currentGrams;
                recommendedFoodGrams.put(bestFoodToAdd.name, absoluteFoodGramCap);
                safeToEatFoods.remove(bestFoodToAdd);
            }
            else {
                recommendedFoodGrams.put(bestFoodToAdd.name, currentGrams + maxGramsPerServing);
                totalFoodGrams += maxGramsPerServing;
            }
        }
        else {
            // finalRecommentations.add(bestFoodToAdd);
            
            recommendedFoodGrams.put(bestFoodToAdd.name, maxGramsPerServing);
            totalFoodGrams += maxGramsPerServing;
        }

        // this chunck of code is down here so that if there is calculate to be extra food there isn't any phantom food counting where it shouldn't
        float servingGramMultiplier = maxGramsPerServing / 100.0;
        proteinStillNeeded -= bestFoodToAdd.gramsProtein * servingGramMultiplier;
        carbsStillNeeded -= bestFoodToAdd.gramsCarbs * servingGramMultiplier;
        fatStillNeeded -= bestFoodToAdd.gramsFat * servingGramMultiplier;

        println(proteinStillNeeded, "proteinStillNeeded");
        println(carbsStillNeeded, "carbsStillNeeded");
        println(fatStillNeeded, "fatStillNeeded");
        println("");
    }
    return recommendedFoodGrams;

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