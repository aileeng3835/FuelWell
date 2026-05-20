import g4p_controls.*;
// User mainUser = new User(); //isn't used anywhere
User user;
ArrayList<Diet> dietList = new ArrayList<Diet>();
// Diet diet = new Diet();

boolean SubmitClicked = false;

ArrayList<Food> foodDB;
ArrayList<Food> recommendations;

void setup() {
  size(700, 600);
  
  dietList = createDietsFromJson();
  user = createUserFromJson(dietList);
  // user.diet = dietList.get(1); // hardcoded for testing (bulk)
  user.diet.storeInfoPerDay(user);

  createGUI();

  foodDB = loadFoods();
  recommendations = new ArrayList<Food>();
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
    "FuelWell provides estimated dietary, caloric and macronutrient recommendations based on general formulas and should not replace professional medical\n" + "or nutritional advice. Individual dietary needs may vary.",
    30,540);

    fill(255);
    line(30, 90, 670, 90);

  if (SubmitClicked) {
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
    for (int i = 0; i < recommendations.size(); i++) {
      Food food = recommendations.get(i);

      //text(food.name + " - " + getServingSuggestion(food, 25), 380, 190 + (i * 30));
    }
  }
}
