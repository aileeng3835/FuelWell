/* =========================================================
 * ====                   WARNING                        ===
 * =========================================================
 * The code in this tab has been generated from the GUI form
 * designer and care should be taken when editing this file.
 * Only add/edit code inside the event handlers i.e. only
 * use lines between the matching comment tags. e.g.

 void myBtnEvents(GButton button) { //_CODE_:button1:12356:
     // It is safe to enter your event code here  
 } //_CODE_:button1:12356:
 
 * Do not rename this tab!
 * =========================================================
 */

synchronized public void dashboard_draw(PApplet appc, GWinData data) { //_CODE_:dashboard:659053:
  appc.background(230);
} //_CODE_:dashboard:659053:

public void toUserInfoTab_click(GButton source, GEvent event) { //_CODE_:toUserInfoTab:777504:
  userInfoTab.setVisible(true);
  dashboard.setVisible(false);
  deletePlanTab.setVisible(false);
  customPlanTab.setVisible(false);
  
} //_CODE_:toUserInfoTab:777504:

public void toCustomPlanTab_clicked(GButton source, GEvent event) { //_CODE_:toCustomPlanTab:959556:
  // println("button1 - GButton >> GEvent." + event + " @ " + millis());
  userInfoTab.setVisible(false);
  dashboard.setVisible(false);
  deletePlanTab.setVisible(false);
  customPlanTab.setVisible(true);
} //_CODE_:toCustomPlanTab:959556:

public void toDeletePlanTab_click(GButton source, GEvent event) { //_CODE_:toDeletePlanTab:716853:
  // println("toDeletePlanTab - GButton >> GEvent." + event + " @ " + millis());
  userInfoTab.setVisible(false);
  dashboard.setVisible(false);
  deletePlanTab.setVisible(true);
  customPlanTab.setVisible(false);
} //_CODE_:toDeletePlanTab:716853:

synchronized public void userInfoTab_draw(PApplet appc, GWinData data) { //_CODE_:userInfoTab:277410:
  appc.background(230);
} //_CODE_:userInfoTab:277410:

public void toDashboardButton_click(GButton source, GEvent event) { //_CODE_:toDashboardButton:550522:
  dashboard.setVisible(true);
  userInfoTab.setVisible(false);
  deletePlanTab.setVisible(false);
  customPlanTab.setVisible(false);
} //_CODE_:toDashboardButton:550522:

public void ageField_type(GTextField source, GEvent event) { //_CODE_:ageField:391582:
  user.age = int(ageField.getText());
} //_CODE_:ageField:391582:

public void userHeightField_type(GTextField source, GEvent event) { //_CODE_:userHeightField:796273:
  user.userHeight = float(userHeightField.getText());
} //_CODE_:userHeightField:796273:

public void userWeightField_type(GTextField source, GEvent event) { //_CODE_:userWeightField:689910:
  user.weight = float(userWeightField.getText());
} //_CODE_:userWeightField:689910:

public void sexField_click(GDropList source, GEvent event) { //_CODE_:sexField:731036:
  user.sex = sexField.getSelectedText();
} //_CODE_:sexField:731036:

public void saveUserInfoButton_click(GButton source, GEvent event) { //_CODE_:saveUserInfoButton:890613:
  try {
      if(!ageField.getText().equals("")) user.age = int(ageField.getText());
      if(!userHeightField.getText().equals("")) user.userHeight = float(userHeightField.getText());
      if(!userWeightField.getText().equals("")) user.weight = float(userWeightField.getText());
      
      if(!targetWeightField.getText().equals("") && user.diet != null) {
          user.diet.targetWeight = float(targetWeightField.getText());
      }
  } catch (Exception e) {
      println("Invalid input. Please ensure height, weight, and age are numbers.");
      return; 
  }
  
  if (user.diet != null) {
      user.diet.storeInfoPerDay(user);
      recommendations = recommendFoods(user, foodDB);
      recommendationsKeys = new ArrayList<String>(recommendations.keySet());
      saveUserToJson(user);
      saveAllDiets(dietList);
      SubmitClicked = true;
      println("User Profile and Diet Saved.");
  }
} //_CODE_:saveUserInfoButton:890613:

public void resetUserInfoButton_click(GButton source, GEvent event) { //_CODE_:resetUserInfoButton:534489:
  resetUser(user);
  ageField.setText("");
  userHeightField.setText("");
  userWeightField.setText("");
  targetWeightField.setText("");
  SubmitClicked = false;
} //_CODE_:resetUserInfoButton:534489:

public void goalList_click(GDropList source, GEvent event) { //_CODE_:goalList:466574:
  String selectedDiet = goalList.getSelectedText();
  user.diet = fetchDietWithDietName(selectedDiet, dietList);
} //_CODE_:goalList:466574:

public void isVegetarian_click(GCheckbox source, GEvent event) { //_CODE_:isVegetarian:287580:
  if(source.isSelected()) user.dietaryRestrictions.add("vegetarian");
  else user.dietaryRestrictions.remove("vegetarian");
} //_CODE_:isVegetarian:287580:

public void isVegan_click(GCheckbox source, GEvent event) { //_CODE_:isVegan:968256:
  if(source.isSelected()) user.dietaryRestrictions.add("vegan");
  else user.dietaryRestrictions.remove("vegan");
} //_CODE_:isVegan:968256:

public void isHalal_click(GCheckbox source, GEvent event) { //_CODE_:isHalal:254714:
  if(source.isSelected()) user.dietaryRestrictions.add("halal");
  else user.dietaryRestrictions.remove("halal");
} //_CODE_:isHalal:254714:

public void isPescetarian_click(GCheckbox source, GEvent event) { //_CODE_:isPescetarian:998524:
  if(source.isSelected()) user.dietaryRestrictions.add("pescetarian");
  else user.dietaryRestrictions.remove("pescetarian");
} //_CODE_:isPescetarian:998524:

public void isGlutenFree_click(GCheckbox source, GEvent event) { //_CODE_:isGlutenFree:368552:
  if(source.isSelected()) user.dietaryRestrictions.add("glutenfree");
  else user.dietaryRestrictions.remove("glutenfree");
} //_CODE_:isGlutenFree:368552:

public void isNutAllergy_click(GCheckbox source, GEvent event) { //_CODE_:isNutAllergy:563699:
  if(source.isSelected()) user.dietaryRestrictions.add("nutallergy");
  else user.dietaryRestrictions.remove("nutallergy");
} //_CODE_:isNutAllergy:563699:

public void isLactoseIntolerant_click(GCheckbox source, GEvent event) { //_CODE_:isLactoseIntolerant:504553:
  if(source.isSelected()) user.dietaryRestrictions.add("lactoseintolerant");
  else user.dietaryRestrictions.remove("lactoseintolerant");
} //_CODE_:isLactoseIntolerant:504553:

public void targetWeightField_click(GTextField source, GEvent event) { //_CODE_:targetWeightField:785529:
  user.diet.targetWeight = float(targetWeightField.getText());
} //_CODE_:targetWeightField:785529:

public void NumberofDaysTyped(GTextField source, GEvent event) { //_CODE_:NumberofDays:465733:
  // println("textfield1 - GTextField >> GEvent." + event + " @ " + millis());
  user.diet.numDays = int(NumberofDays.getText());
} //_CODE_:NumberofDays:465733:

synchronized public void customPlanTab_draw(PApplet appc, GWinData data) { //_CODE_:customPlanTab:742484:
  appc.background(230);
} //_CODE_:customPlanTab:742484:

public void toDashboardButton2_clicked(GButton source, GEvent event) { //_CODE_:toDashboardButton2:346182:
  // println("toDashboardButton2 - GButton >> GEvent." + event + " @ " + millis());
  userInfoTab.setVisible(false);
  dashboard.setVisible(true);
  deletePlanTab.setVisible(false);
  customPlanTab.setVisible(false);
} //_CODE_:toDashboardButton2:346182:

public void customNameField_type(GTextField source, GEvent event) { //_CODE_:customNameField:605669:
  println("textfield1 - GTextField >> GEvent." + event + " @ " + millis());
} //_CODE_:customNameField:605669:

public void proteinPercentField_type(GTextField source, GEvent event) { //_CODE_:proteinPercentField:585488:
  println("proteinPercentField - GTextField >> GEvent." + event + " @ " + millis());
} //_CODE_:proteinPercentField:585488:

public void carbPercentField_type(GTextField source, GEvent event) { //_CODE_:carbPercentField:648206:
  println("textfield1 - GTextField >> GEvent." + event + " @ " + millis());
} //_CODE_:carbPercentField:648206:

public void fatPercentField_type(GTextField source, GEvent event) { //_CODE_:fatPercentField:446832:
  println("fatPercentField - GTextField >> GEvent." + event + " @ " + millis());
} //_CODE_:fatPercentField:446832:

public void isMaintainBox_click(GCheckbox source, GEvent event) { //_CODE_:isMaintainBox:337901:
  println("isMaintainBox - GCheckbox >> GEvent." + event + " @ " + millis());
} //_CODE_:isMaintainBox:337901:

public void isLoseBox_click(GCheckbox source, GEvent event) { //_CODE_:isLoseBox:976316:
  println("isLoseBox - GCheckbox >> GEvent." + event + " @ " + millis());
} //_CODE_:isLoseBox:976316:

public void customDaysField_type(GTextField source, GEvent event) { //_CODE_:customDaysField:318736:
  println("customDaysField - GTextField >> GEvent." + event + " @ " + millis());
} //_CODE_:customDaysField:318736:

public void addPlanButton_click1(GButton source, GEvent event) { //_CODE_:addPlanButton:244947:
  // println("addPlanButton - GButton >> GEvent." + event + " @ " + millis());
  try {
      String newDietName = "";
      float newProteinPercent = 0.0;
      float newCarbsPercent = 0.0;
      float newFatPercent = 0.0;
      float newTargetWeight = 0.0;
      int newNumDays = 0;
      boolean newIsMaintain = false;
      boolean newIsLoseWeight = false;
      
      if(!customNameField.getText().equals("")) newDietName = (customNameField.getText());
      if(!proteinPercentField.getText().equals("")) newProteinPercent = float(proteinPercentField.getText());
      if(!carbPercentField.getText().equals("")) newCarbsPercent = float(carbPercentField.getText());
      if(!fatPercentField.getText().equals("")) newFatPercent = float(fatPercentField.getText());
      newTargetWeight = user.weight; //placeholder so things don't break (the user can get a new target weight in modify user info)
      newIsMaintain = isMaintainBox.isSelected();
      newIsLoseWeight = isLoseBox.isSelected();
      if(!customDaysField.getText().equals("")) newNumDays = int(customDaysField.getText());
      addDiet(newDietName, newProteinPercent / 100.0, newCarbsPercent / 100.0, newFatPercent / 100.0, newNumDays, 0, newIsMaintain, newIsLoseWeight, newTargetWeight);

  } catch (Exception e) {
      println("Invalid input. Please make sure you have inputted all relevant information.");
      return; 
  }
  userInfoTab.setVisible(false);
  dashboard.setVisible(true);
  deletePlanTab.setVisible(false);
  customPlanTab.setVisible(false);
} //_CODE_:addPlanButton:244947:

synchronized public void deletePlanTab_draw(PApplet appc, GWinData data) { //_CODE_:deletePlanTab:428170:
  appc.background(230);
} //_CODE_:deletePlanTab:428170:

public void toDashboardButton3_click(GButton source, GEvent event) { //_CODE_:toDashboardButton3:523269:
  // println("toDashboardButton3 - GButton >> GEvent." + event + " @ " + millis());
  userInfoTab.setVisible(false);
  dashboard.setVisible(true);
  deletePlanTab.setVisible(false);
  customPlanTab.setVisible(false);
} //_CODE_:toDashboardButton3:523269:

public void planToDeleteField_type(GTextField source, GEvent event) { //_CODE_:planToDeleteField:866039:
  println("planToDeleteField - GTextField >> GEvent." + event + " @ " + millis());
} //_CODE_:planToDeleteField:866039:

public void deletePlanButton_click(GButton source, GEvent event) { //_CODE_:deletePlanButton:217754:
  println("deletePlanButton - GButton >> GEvent." + event + " @ " + millis());
} //_CODE_:deletePlanButton:217754:



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
  G4P.setMouseOverEnabled(false);
  surface.setTitle("Sketch Window");
  dashboard = GWindow.getWindow(this, "Dashboard", 0, 0, 400, 300, JAVA2D);
  dashboard.noLoop();
  dashboard.setActionOnClose(G4P.KEEP_OPEN);
  dashboard.addDrawHandler(this, "dashboard_draw");
  toUserInfoTab = new GButton(dashboard, 130, 160, 140, 30);
  toUserInfoTab.setText("Modify User Info >");
  toUserInfoTab.addEventHandler(this, "toUserInfoTab_click");
  welcomeMessage = new GLabel(dashboard, 90, 120, 220, 20);
  welcomeMessage.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  welcomeMessage.setText("Welcome to the FuelWell dashboard.");
  welcomeMessage.setOpaque(false);
  toCustomPlanTab = new GButton(dashboard, 130, 200, 140, 30);
  toCustomPlanTab.setText("Create Custom Plan >");
  toCustomPlanTab.addEventHandler(this, "toCustomPlanTab_clicked");
  toDeletePlanTab = new GButton(dashboard, 130, 240, 140, 30);
  toDeletePlanTab.setText("Delete Custom Plan >");
  toDeletePlanTab.addEventHandler(this, "toDeletePlanTab_click");
  userInfoTab = GWindow.getWindow(this, "userInfo", 0, 0, 400, 300, JAVA2D);
  userInfoTab.noLoop();
  userInfoTab.setActionOnClose(G4P.KEEP_OPEN);
  userInfoTab.addDrawHandler(this, "userInfoTab_draw");
  toDashboardButton = new GButton(userInfoTab, 11, 12, 140, 30);
  toDashboardButton.setText("< Back to Dashboard");
  toDashboardButton.addEventHandler(this, "toDashboardButton_click");
  ageLabel = new GLabel(userInfoTab, 12, 79, 80, 20);
  ageLabel.setTextAlign(GAlign.RIGHT, GAlign.MIDDLE);
  ageLabel.setText("Age:");
  ageLabel.setOpaque(false);
  sexLabel = new GLabel(userInfoTab, 11, 104, 80, 20);
  sexLabel.setTextAlign(GAlign.RIGHT, GAlign.MIDDLE);
  sexLabel.setText("Sex:");
  sexLabel.setOpaque(false);
  userHeightLabel = new GLabel(userInfoTab, 13, 129, 80, 20);
  userHeightLabel.setTextAlign(GAlign.RIGHT, GAlign.MIDDLE);
  userHeightLabel.setText("Height (cm):");
  userHeightLabel.setOpaque(false);
  userWeightLabel = new GLabel(userInfoTab, 14, 153, 80, 20);
  userWeightLabel.setTextAlign(GAlign.RIGHT, GAlign.MIDDLE);
  userWeightLabel.setText("Weight (kg):");
  userWeightLabel.setOpaque(false);
  ageField = new GTextField(userInfoTab, 99, 79, 40, 20, G4P.SCROLLBARS_NONE);
  ageField.setOpaque(true);
  ageField.addEventHandler(this, "ageField_type");
  userHeightField = new GTextField(userInfoTab, 99, 132, 60, 20, G4P.SCROLLBARS_NONE);
  userHeightField.setOpaque(true);
  userHeightField.addEventHandler(this, "userHeightField_type");
  userWeightField = new GTextField(userInfoTab, 100, 156, 50, 20, G4P.SCROLLBARS_NONE);
  userWeightField.setOpaque(true);
  userWeightField.addEventHandler(this, "userWeightField_type");
  sexField = new GDropList(userInfoTab, 98, 106, 70, 60, 2, 10);
  sexField.setItems(loadStrings("list_731036"), 0);
  sexField.addEventHandler(this, "sexField_click");
  saveUserInfoButton = new GButton(userInfoTab, 206, 246, 120, 30);
  saveUserInfoButton.setText("Save User Info");
  saveUserInfoButton.setLocalColorScheme(GCScheme.GREEN_SCHEME);
  saveUserInfoButton.addEventHandler(this, "saveUserInfoButton_click");
  resetUserInfoButton = new GButton(userInfoTab, 64, 246, 120, 30);
  resetUserInfoButton.setText("Reset User Info");
  resetUserInfoButton.setLocalColorScheme(GCScheme.RED_SCHEME);
  resetUserInfoButton.addEventHandler(this, "resetUserInfoButton_click");
  goalLabel = new GLabel(userInfoTab, 208, 25, 50, 20);
  goalLabel.setTextAlign(GAlign.RIGHT, GAlign.MIDDLE);
  goalLabel.setText("Goal:");
  goalLabel.setOpaque(false);
  goalList = new GDropList(userInfoTab, 259, 27, 90, 100, 4, 10);
  goalList.setItems(loadStrings("list_466574"), 0);
  goalList.addEventHandler(this, "goalList_click");
  dietaryRestrictionsLabel = new GLabel(userInfoTab, 206, 55, 130, 20);
  dietaryRestrictionsLabel.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  dietaryRestrictionsLabel.setText("Dietary Restrictions:");
  dietaryRestrictionsLabel.setOpaque(false);
  isVegetarian = new GCheckbox(userInfoTab, 213, 78, 120, 20);
  isVegetarian.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  isVegetarian.setText("Vegetarian");
  isVegetarian.setOpaque(false);
  isVegetarian.addEventHandler(this, "isVegetarian_click");
  isVegan = new GCheckbox(userInfoTab, 213, 98, 120, 20);
  isVegan.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  isVegan.setText("Vegan");
  isVegan.setOpaque(false);
  isVegan.addEventHandler(this, "isVegan_click");
  isHalal = new GCheckbox(userInfoTab, 213, 119, 120, 20);
  isHalal.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  isHalal.setText("Halal");
  isHalal.setOpaque(false);
  isHalal.addEventHandler(this, "isHalal_click");
  isPescetarian = new GCheckbox(userInfoTab, 212, 140, 120, 20);
  isPescetarian.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  isPescetarian.setText("Pescetarian");
  isPescetarian.setOpaque(false);
  isPescetarian.addEventHandler(this, "isPescetarian_click");
  isGlutenFree = new GCheckbox(userInfoTab, 213, 161, 120, 20);
  isGlutenFree.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  isGlutenFree.setText("Gluten Free");
  isGlutenFree.setOpaque(false);
  isGlutenFree.addEventHandler(this, "isGlutenFree_click");
  isNutAllergy = new GCheckbox(userInfoTab, 213, 182, 120, 20);
  isNutAllergy.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  isNutAllergy.setText("Nut Allergy");
  isNutAllergy.setOpaque(false);
  isNutAllergy.addEventHandler(this, "isNutAllergy_click");
  isLactoseIntolerant = new GCheckbox(userInfoTab, 213, 202, 120, 20);
  isLactoseIntolerant.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  isLactoseIntolerant.setText("Lactose Intolerant");
  isLactoseIntolerant.setOpaque(false);
  isLactoseIntolerant.addEventHandler(this, "isLactoseIntolerant_click");
  targetWeightLabel = new GLabel(userInfoTab, 14, 180, 80, 20);
  targetWeightLabel.setTextAlign(GAlign.RIGHT, GAlign.MIDDLE);
  targetWeightLabel.setText("Target (kg):");
  targetWeightLabel.setOpaque(false);
  targetWeightField = new GTextField(userInfoTab, 100, 180, 50, 20, G4P.SCROLLBARS_NONE);
  targetWeightField.setOpaque(true);
  targetWeightField.addEventHandler(this, "targetWeightField_click");
  label1 = new GLabel(userInfoTab, 14, 207, 80, 20);
  label1.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label1.setText("Days:");
  label1.setOpaque(false);
  NumberofDays = new GTextField(userInfoTab, 100, 207, 50, 20, G4P.SCROLLBARS_NONE);
  NumberofDays.setOpaque(true);
  NumberofDays.addEventHandler(this, "NumberofDaysTyped");
  customPlanTab = GWindow.getWindow(this, "Create Custom Plan", 0, 0, 400, 300, JAVA2D);
  customPlanTab.noLoop();
  customPlanTab.setActionOnClose(G4P.KEEP_OPEN);
  customPlanTab.addDrawHandler(this, "customPlanTab_draw");
  toDashboardButton2 = new GButton(customPlanTab, 11, 12, 140, 30);
  toDashboardButton2.setText("< Back to Dashboard");
  toDashboardButton2.addEventHandler(this, "toDashboardButton2_clicked");
  customNameField = new GTextField(customPlanTab, 203, 50, 120, 20, G4P.SCROLLBARS_NONE);
  customNameField.setOpaque(true);
  customNameField.addEventHandler(this, "customNameField_type");
  customNameLabel = new GLabel(customPlanTab, 87, 50, 113, 20);
  customNameLabel.setTextAlign(GAlign.RIGHT, GAlign.MIDDLE);
  customNameLabel.setText("Custom Plan Name:");
  customNameLabel.setOpaque(false);
  proteinPercentLabel = new GLabel(customPlanTab, 92, 74, 109, 20);
  proteinPercentLabel.setTextAlign(GAlign.RIGHT, GAlign.MIDDLE);
  proteinPercentLabel.setText("Protein Percentage:");
  proteinPercentLabel.setOpaque(false);
  proteinPercentField = new GTextField(customPlanTab, 203, 75, 50, 20, G4P.SCROLLBARS_NONE);
  proteinPercentField.setOpaque(true);
  proteinPercentField.addEventHandler(this, "proteinPercentField_type");
  carbPercentLabel = new GLabel(customPlanTab, 97, 98, 106, 20);
  carbPercentLabel.setTextAlign(GAlign.RIGHT, GAlign.MIDDLE);
  carbPercentLabel.setText("Carbs Percentage:");
  carbPercentLabel.setOpaque(false);
  carbPercentField = new GTextField(customPlanTab, 203, 98, 50, 20, G4P.SCROLLBARS_NONE);
  carbPercentField.setOpaque(true);
  carbPercentField.addEventHandler(this, "carbPercentField_type");
  fatPercentLabel = new GLabel(customPlanTab, 113, 123, 90, 20);
  fatPercentLabel.setTextAlign(GAlign.RIGHT, GAlign.MIDDLE);
  fatPercentLabel.setText("Fat Percentage:");
  fatPercentLabel.setOpaque(false);
  fatPercentField = new GTextField(customPlanTab, 203, 123, 50, 20, G4P.SCROLLBARS_NONE);
  fatPercentField.setOpaque(true);
  fatPercentField.addEventHandler(this, "fatPercentField_type");
  percentTipLabel = new GLabel(customPlanTab, 78, 146, 250, 20);
  percentTipLabel.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  percentTipLabel.setText("Tip - the percentages should add up to 100%!");
  percentTipLabel.setOpaque(false);
  isMaintainBox = new GCheckbox(customPlanTab, 139, 172, 120, 20);
  isMaintainBox.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  isMaintainBox.setText("Maintain Weight");
  isMaintainBox.setOpaque(false);
  isMaintainBox.addEventHandler(this, "isMaintainBox_click");
  isLoseBox = new GCheckbox(customPlanTab, 140, 195, 120, 20);
  isLoseBox.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
  isLoseBox.setText("Lose Weight");
  isLoseBox.setOpaque(false);
  isLoseBox.addEventHandler(this, "isLoseBox_click");
  customDaysLabel = new GLabel(customPlanTab, 111, 259, 90, 20);
  customDaysLabel.setTextAlign(GAlign.RIGHT, GAlign.MIDDLE);
  customDaysLabel.setText("Total # of Days:");
  customDaysLabel.setOpaque(false);
  customDaysField = new GTextField(customPlanTab, 203, 259, 50, 20, G4P.SCROLLBARS_NONE);
  customDaysField.setOpaque(true);
  customDaysField.addEventHandler(this, "customDaysField_type");
  weightTipLabel = new GLabel(customPlanTab, 3, 226, 394, 20);
  weightTipLabel.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  weightTipLabel.setText("Tip - Maintain and Lose Weight are mutually exclusive, either you maintain your current weight (by checking Maintain), or you gain/lose weight (by checking or unchecking Lose)");
  weightTipLabel.setOpaque(false);
  addPlanButton = new GButton(customPlanTab, 310, 263, 80, 30);
  addPlanButton.setText("Add Plan");
  addPlanButton.addEventHandler(this, "addPlanButton_click1");
  deletePlanTab = GWindow.getWindow(this, "Delete Custom Plan", 0, 0, 400, 300, JAVA2D);
  deletePlanTab.noLoop();
  deletePlanTab.setActionOnClose(G4P.KEEP_OPEN);
  deletePlanTab.addDrawHandler(this, "deletePlanTab_draw");
  toDashboardButton3 = new GButton(deletePlanTab, 11, 12, 140, 30);
  toDashboardButton3.setText("< Back to Dashboard");
  toDashboardButton3.addEventHandler(this, "toDashboardButton3_click");
  label2 = new GLabel(deletePlanTab, 71, 64, 129, 20);
  label2.setTextAlign(GAlign.RIGHT, GAlign.MIDDLE);
  label2.setText("Name of Plan to Delete:");
  label2.setOpaque(false);
  planToDeleteField = new GTextField(deletePlanTab, 206, 64, 120, 20, G4P.SCROLLBARS_NONE);
  planToDeleteField.setOpaque(true);
  planToDeleteField.addEventHandler(this, "planToDeleteField_type");
  deletePlanButton = new GButton(deletePlanTab, 155, 136, 90, 30);
  deletePlanButton.setText("DELETE PLAN");
  deletePlanButton.setLocalColorScheme(GCScheme.RED_SCHEME);
  deletePlanButton.addEventHandler(this, "deletePlanButton_click");
  label3 = new GLabel(deletePlanTab, 80, 103, 240, 20);
  label3.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
  label3.setText("Warning: this action is irreversible!");
  label3.setOpaque(false);
  dashboard.loop();
  userInfoTab.loop();
  customPlanTab.loop();
  deletePlanTab.loop();
}

// Variable declarations 
// autogenerated do not edit
GWindow dashboard;
GButton toUserInfoTab; 
GLabel welcomeMessage; 
GButton toCustomPlanTab; 
GButton toDeletePlanTab; 
GWindow userInfoTab;
GButton toDashboardButton; 
GLabel ageLabel; 
GLabel sexLabel; 
GLabel userHeightLabel; 
GLabel userWeightLabel; 
GTextField ageField; 
GTextField userHeightField; 
GTextField userWeightField; 
GDropList sexField; 
GButton saveUserInfoButton; 
GButton resetUserInfoButton; 
GLabel goalLabel; 
GDropList goalList; 
GLabel dietaryRestrictionsLabel; 
GCheckbox isVegetarian; 
GCheckbox isVegan; 
GCheckbox isHalal; 
GCheckbox isPescetarian; 
GCheckbox isGlutenFree; 
GCheckbox isNutAllergy; 
GCheckbox isLactoseIntolerant; 
GLabel targetWeightLabel; 
GTextField targetWeightField; 
GLabel label1; 
GTextField NumberofDays; 
GWindow customPlanTab;
GButton toDashboardButton2; 
GTextField customNameField; 
GLabel customNameLabel; 
GLabel proteinPercentLabel; 
GTextField proteinPercentField; 
GLabel carbPercentLabel; 
GTextField carbPercentField; 
GLabel fatPercentLabel; 
GTextField fatPercentField; 
GLabel percentTipLabel; 
GCheckbox isMaintainBox; 
GCheckbox isLoseBox; 
GLabel customDaysLabel; 
GTextField customDaysField; 
GLabel weightTipLabel; 
GButton addPlanButton; 
GWindow deletePlanTab;
GButton toDashboardButton3; 
GLabel label2; 
GTextField planToDeleteField; 
GButton deletePlanButton; 
GLabel label3; 
