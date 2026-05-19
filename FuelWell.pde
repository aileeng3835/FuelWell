import g4p_controls.*;
User mainUser = new User();
User user = new User();
Diet diet = new Diet();

boolean SubmitClicked = true;

// void setup() {
//   size(400, 600);
//   createGUI();
// }

void draw() {
  background(20);
  fill(57, 255, 94);

  textSize(42);
  text("FuelWell Results", 58, 60);

//   fill(255);
//   line(30, 500, 370, 500);

//   fill(255, 80, 80);
//   textSize(12);
//   text("Disclaimer:", 30, 520);

//   fill(220);
//   textSize(10);
//   text(
//     "FuelWell provides estimated calorie and macronutrient\n" + "recommendations based on general formulas and should\n" + "not replace professional medical or nutritional advice.\n" + "Individual dietary needs may vary.",
//     30,540);

//   if (SubmitClicked) {
//     fill(255);
//     line(30, 90, 370, 90);

//     textSize(28);
//     text("Daily Calories: ", 70, 150);

//     textSize(36);
//     fill(57, 255, 94);
//     text(round(diet.cals), 250, 153);

//     fill(255);
//     textSize(24);

//     text("Protein: " + round(diet.protein) + " g", 70, 220);
//     text("Carbohydrates: " + round(diet.carbs) + " g", 70, 280);
//     text("Fats: " + round(diet.fat) + " g", 70, 340);

//     // if (!isPlanSafe(user, diet.cals)) {
//     //   fill(255, 80, 80);
//     //   textSize(18);
//     //   text("Warning: Calories may be too low.", 35, 420);
//     // }
//   }
// }
