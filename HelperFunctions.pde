float calculateBMR(User user) {
    if (user.sex.equalsIgnoreCase("male")) {
        return (10 * user.weight) + (6.25 * user.userHeight) - (5 * user.age) + 5;
    }
    else if (user.sex.equalsIgnoreCase("female")) {
        return (10 * user.weight) + (6.25 * user.userHeight) - (5 * user.age) - 161;
    }
    return 0;
    }



int calculateCaloriesPerDay(User user) {
    
    int daysRemaining = user.diet.numDays - user.diet.daysPassed;
    float weightDif = user.diet.targetWeight - user.weight;
    float weightPerDay = weightDif / daysRemaining;
    float additionalCals = 0;
    println(daysRemaining, "daysRemaining");
    println(weightDif, "weightDif");
    println(weightPerDay, "weightPerDay");
    if (weightDif > 0) {
        // muscle is ~2800 cals gained for 1 lbs which is ~6160 cals for 1 kg
        additionalCals = weightPerDay * 6160;
    }
    else {
        // fat is ~3500 cals per 1 lbs which is ~7700 cals for 1 kg
        additionalCals = weightPerDay * 7700;
    }

    int dailyCals = int(calculateBMR(user) + additionalCals);
    return dailyCals;
}
    
HashMap<String, Float> calcMacros(User user) {
        HashMap<String, Float> macros = new HashMap<String, Float>();
    
    macros.put("protein", (calculateCaloriesPerDay(user) * user.diet.proteinPercent) / 4);
    macros.put("carbs", (calculateCaloriesPerDay(user) * user.diet.carbsPercent) / 4);
    macros.put("fat", (calculateCaloriesPerDay(user) * user.diet.fatPercent) / 9);

    return macros;
    }

boolean isPlanSafe(User user, float cals){
    if(user.sex == null){
        return true;
    }

    if(user.sex.equalsIgnoreCase("female") && cals <= 1400){
        return false;
    }
    else if(user.sex.equalsIgnoreCase("male") && cals <= 1600){
        return false;
    }
    else{
        return true;
    }
}
void resetDiet(Diet diet) { 
    diet.targetWeight = 0;
    diet.numDays = 0;
    diet.daysPassed = 0;
}

void resetUser(User user) {
    user.name = "name";
    user.age = 0;
    user.sex = "";
    user.userHeight = 0;
    user.weight = 0;
    user.dietaryRestrictions = new ArrayList<String>();
    user.diet = null;
}

ArrayList<Food> loadFoods(){
    ArrayList<Food> foods = new ArrayList<Food>();

    JSONObject json = loadJSONObject("FoodData.json");
    JSONArray foodList = json.getJSONArray("FoodList");

    for (int i = 0; i < foodList.size(); i++){
        JSONObject foodObj = foodList.getJSONObject(i);

        String name = foodObj.getString("name");

        if (name.equals("foodTemplate")) {
            continue;
        }

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

        Food food = new Food(name, fat, carbs, protein, sugar, restrictions, categories);
        foods.add(food);
    }
    return foods;
}

ArrayList<Food> recommendFoods(User user) {
    ArrayList<Food> recs = new ArrayList<Food>();

    float proteinNeeded = user.diet.proteinPerDay;
    float carbsNeeded = user.diet.carbsPerDay;
    float fatNeeded = user.diet.fatPerDay;

    for (Food food : foodDB) {
        boolean goodProtein = food.gramsProtein >= 15;
        boolean goodCarbs = food.gramsCarbs >= 15;
        boolean goodFat = food.gramsFat >= 10;

        if (proteinNeeded > carbsNeeded && proteinNeeded > fatNeeded && goodProtein) {
            recs.add(food);
        }
        else if (carbsNeeded > fatNeeded && goodCarbs) {
            recs.add(food);
        }
        else if (goodFat) {
            recs.add(food);
        }

        if (recs.size() >= 6) {
            break;
        }
    }
    return recs;
}


// Just testing for later ignore for now.
// String getServingSuggestion(Food food, float targetProtein){
//     if (food.gramsProtein <= 0) {
//         return "100g";
//     }

//     float gramsNeeded = (targetProtein / food.gramsProtein) * 100;

//     gramsNeeded = round(gramsNeeded);
//     return gramsNeeded + "g";
// }

ArrayList<Diet> createDietsFromJson() {
    JSONObject jsonData = loadJSONObject("Diets.json");
    JSONArray jsonDietList = jsonData.getJSONArray("DietsList");
    ArrayList<Diet> dietList = new ArrayList<Diet>();
    for(int i=0; i<jsonDietList.size(); i++) {
        JSONObject currentDiet = jsonDietList.getJSONObject(i);
        String name = currentDiet.getString("name");
        float proteinPercent = currentDiet.getFloat("proteinPercent");
        float carbsPercent = currentDiet.getFloat("carbsPercent");
        float fatPercent = currentDiet.getFloat("fatPercent");
        boolean isMaintain = currentDiet.getBoolean("isMaintain");
        boolean isLoseWeight = currentDiet.getBoolean("isLoseWeight");
        dietList.add(new Diet(name, proteinPercent, carbsPercent, fatPercent, isMaintain, isLoseWeight));
    }
    return dietList;
}

User createUserFromJson(ArrayList<Diet> dietList) {
    JSONObject jsonUser = loadJSONObject("User.json");
    String name = jsonUser.getString("name");
    int age = jsonUser.getInt("age");
    String sex = jsonUser.getString("sex");
    float userHeight = jsonUser.getFloat("height");
    float weight = jsonUser.getFloat("weight");
    String[] tempDietRestrictions = jsonUser.getStringList("dietaryRestrictions").array();
    ArrayList<String> dietaryRestrictions = new ArrayList<String>();
    for(int i=0; i<tempDietRestrictions.length; i++) {
        dietaryRestrictions.add(tempDietRestrictions[i]);
    }
    String dietname = jsonUser.getString("dietname");
    return new User(name, age, sex, userHeight, weight, dietaryRestrictions, dietname, dietList);  
}

Diet fetchDietWithDietName(String dietName, ArrayList<Diet> dietsList) {
    for(int i = 0; i<dietList.size(); i++) {
        if (dietList.get(i).dietName.equals(dietName)) {
            return dietList.get(i);
        }
        
    }
    return null;
    
}

// have a function to save current user and diet info to their respective jsons



    /*  

        filterDB(Array[Food] db, Array[String] restrictions){
        Array[Food] allowedFoods = [] 
        For food in db{ 
        Boolean safe = True 
        For req in restrictions{ If req NOT IN food.tags{safe = False; Break} }
        If safe:True{allowedFoods.add(food)} 
        }
        allowedFoods }
        }
        */



// Food[] dailyFoodRecommendation(User user, ) {
//     //general sudocode for what we want to happen
    
//     // int planLength = user.plan.length
//     // int daysPassed = user..plan.daysPassed
//     // int daysRemaining = planLength - daysPassed

// }





// old formulas
// float calcTargetCals(float bmr, int goal){
//         float calsBurnedDaily = bmr * 1.4; // basal rate + some activity
        
//         if(goal==2 || goal==3){
//             return calsBurnedDaily - 300;
//         }
//         else if(goal==1){
//             return calsBurnedDaily + 300;
//         }
//         else{
//             return calsBurnedDaily;
//         }
//     }
