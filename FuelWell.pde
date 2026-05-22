import g4p_controls.*;

User user;
ArrayList<Diet> dietList = new ArrayList<Diet>();
ArrayList<Food> foodDB;
HashMap<String, Float> recommendations;
ArrayList<String> recommendationsKeys;

boolean SubmitClicked = false; 

void setup() {
  size(700, 600);
  
  dietList = createDietsFromJson();
  user = createUserFromJson(dietList);
  
  if(user.diet != null) {
      if(user.diet.targetWeight == 0) user.diet.targetWeight = user.weight; 
      if(user.diet.numDays == 0) user.diet.numDays = 30; 
  }
  
  foodDB = loadFoods();
  recommendations = new HashMap<String, Float>();
  recommendationsKeys = new ArrayList<String>();
  
  createGUI();
  
  dashboard.setVisible(true);
  userInfoTab.setVisible(false);
  deletePlanTab.setVisible(false);
  customPlanTab.setVisible(false);
}

void draw() {
  background(20);
  fill(57, 255, 94);

  textSize(42);
  text("FuelWell Results", 58, 60);

  fill(255);
  line(30, 500, 670, 500);

  fill(255, 80, 80);
  textSize(12);
  text("Disclaimer:", 30, 520);

  fill(220);
  textSize(10);
  text(
    "FuelWell provides estimated dietary, caloric and macronutrient recommendations based on general formulas and should not replace professional medical\n" + 
    "or nutritional advice. Individual dietary needs may vary.",
    30, 540);

  fill(255);
  line(30, 90, 670, 90);

  if (SubmitClicked && user.diet != null) {
    textSize(28);
    text("Daily Calories: ", 70, 150);

    textSize(36);
    fill(57, 255, 94);
    text(round(user.diet.calsPerDay), 250, 153);

    fill(255);
    textSize(24);
    text("Protein: " + round(user.diet.proteinPerDay) + " g", 70, 220);
    text("Carbohydrates: " + round(user.diet.carbsPerDay) + " g", 70, 280);
    text("Fats: " + round(user.diet.fatPerDay) + " g", 70, 340);

    textSize(22);
    text("Food Recommendations:", 380, 140);

    textSize(16);
    if(recommendationsKeys.size() > 0) {
        for (int i = 0; i < recommendationsKeys.size(); i++) {
          String foodName = recommendationsKeys.get(i);
          text("- " + foodName, 380, 180 + (i * 30));
          
          textSize(12);
          fill(180);
          text("   Suggest: " + round(recommendations.get(recommendationsKeys.get(i))) + " grams per day", 380, 195 + (i * 30));
          fill(255);
          textSize(16);
        }
    } else {
        fill(255, 100, 100);
        text("No foods match your restrictions.", 380, 180);
    }
  }
}