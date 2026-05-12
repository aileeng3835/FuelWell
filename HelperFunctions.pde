float calculateBMR(User user) {
    float bmr;
        if (user.sex.equals("male")){
            bmr = (10 * user.weight) + (6.25 * user.userHeight) - (5 * user.age) + 5;
            return bmr;
        }
        else if (user.sex.equals("female")){
            bmr = (10 * user.weight) + (6.25 * user.userHeight) - (5 * user.age) - 161;
            return bmr;
        }
    }

float calcTargetCals(float bmr, int goal){
        float tdee = 1.2;
        
        if(goal==2 || goal==3){
            return tdee-=500;
        }
        else if(goal==1){
            return tdee+=500;
        }
        else{
            return tdee;
        }
    }
    
HashMap<String, Float> calcMacros(float cals, int goal) {
    HashMap<String, Float> macros = new HashMap<String, Float>();
    
    if (goal == 1) {
        macros.put("protein", 0.30f);
        macros.put("carbs", 0.50f);
        macros.put("fat", 0.20f);
    } else if (goal == 2 || goal == 3) {
        macros.put("protein", 0.40f);
        macros.put("carbs", 0.30f);
        macros.put("fat", 0.30f);
    } else {
        macros.put("protein", 0.30f);
        macros.put("carbs", 0.40f);
        macros.put("fat", 0.30f);
    }
    
    return macros;
    }

    /*
Boolean isPlanSafe(User user, Float cals){ 
If user.sex:female AND cals < 1200{False} 
Else if user.sex:male AND cals < 1500{False} 
Else{True} }
        

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
        