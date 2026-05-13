// Main tab

import g4p_controls.*;
User user = new User();
Diet diet = new Diet();

boolean SubmitClicked = true;

void setup() {
  size(400, 600);
  createGUI();
}

void draw() {
  background(20);
  textSize(50);
  fill(57, 255, 94);
  text("FuelWell", 110, 80);

  if(SubmitClicked==true){
    textSize(20);
    fill(255);
    text("BMR:", 80, 140);
    text(diet.cals, 80, 140);
  }
}
