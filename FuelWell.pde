/*
InputCals=
InputSex=
InputAge=
InputWeight=
RecommendedCals=

Mifflin-St. Jeor's equation for Basal Metabolic Rate

Cals(men) = (10 × weight(kg) + 6.25 × height(cm) - 5 × age(year) + 5) kcal / day
Cals(women) = (10 × weight(kg) + 6.25 × height(cm) - 5 × age(year) - 161) kcal / day



calcBMR(User user){
If userSex:male{(10 × weight(kg)) + (6.25 × height(cm)) - (5 × age(year)) + 5}
Else if userSex:female{(10 × weight(kg)) + (6.25 × height(cm)) - (5 × age(year)) - 161}
}

calcTargetCals(bmr, string goal){
Float tdee = 1.2

If goal:cut{tdee-500}
Else if goal:bulk{tdee+500}
Else{tdee}
}

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
