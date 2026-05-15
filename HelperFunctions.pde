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
    float weightDif = user.weight - user.diet.targetWeight;
    float weightPerDay = weightDif / daysRemaining;
    float additionalCals = 0;
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
    user.sex = null;
    user.userHeight = 0;
    user.weight = 0;
    user.dietaryRestrictions = null;
    user.diet = null;
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