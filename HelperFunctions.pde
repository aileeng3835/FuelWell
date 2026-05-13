float calculateBMR(User user) {
    if (user.sex.equals("male")) {
        return (10 * user.weight) + (6.25 * user.userHeight) - (5 * user.age) + 5;
    }
    else if (user.sex.equals("female")) {
        return (10 * user.weight) + (6.25 * user.userHeight) - (5 * user.age) - 161;
    }
    return 0;
    }

float calcTargetCals(float bmr, int goal){
        float tdee = bmr * 1.2;
        
        if(goal==2 || goal==3){
            return tdee - 500;
        }
        else if(goal==1){
            return tdee + 500;
        }
        else{
            return tdee;
        }
    }
    
HashMap<String, Float> calcMacros(float cals, int goal) {
        HashMap<String, Float> macros = new HashMap<String, Float>();
    
    float proteinPercent;
    float carbsPercent;
    float fatPercent;

    if (goal == 1) {
        proteinPercent = 0.30f;
        carbsPercent = 0.50f;
        fatPercent = 0.20f;
    } else if (goal == 2 || goal == 3) {
        proteinPercent = 0.40f;
        carbsPercent = 0.30f;
        fatPercent = 0.30f;
    } else {
        proteinPercent = 0.30f;
        carbsPercent = 0.40f;
        fatPercent = 0.30f;
    }
    
    macros.put("protein", (cals * proteinPercent) / 4);
    macros.put("carbs", (cals * carbsPercent) / 4);
    macros.put("fat", (cals * fatPercent) / 9);

    return macros;
    }

boolean isPlanSafe(User user, float cals){
    if(user.sex.equals("female") && cals <= 1400){
        return false;
    }
    else if(user.sex.equals("male") && cals <= 1600){
        return false;
    }
    else{
        return true;
    }
}

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
        