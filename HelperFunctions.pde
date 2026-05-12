int calculateBMR(User user) {
        if (user.sex.equals(male)){
            return (10 * user.weight) + (6.25 * user.userHeight) - (5 * user.age) + 5;
        }
        else if (user.sex.equals(female)){
            return (10 * user.weight) + (6.25 * user.userHeight) - (5 * user.age) - 161;
        }
    }

float calcTargetCals(int bmr, int goal){
        float tdee = 1.2;
        
        if(user.goal==2 || user.goal==3){
            return tdee-=500;
        }
        else if(user.goal==1){
            return tdee+=500;
        }
        else{
            return tdee;
        }
    }
    /*
    calcMacros(Float cals, String goal){ 
        If goal:bulk{protein:0.30, carbs:0.50, fat:0.20} 
        else if goal:cut OR goal:”lose weight”{protein:0.40, carbs:0.30, fat:0.30} Else{protein:0.30, carbs:0.40, fat:0.30} 
        }
        
        isPlanSafe(User user, Float cals){ 
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
        