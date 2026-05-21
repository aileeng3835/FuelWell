class Diet {
  public float calsPerDay;
  public float proteinPerDay;
  public float carbsPerDay;
  public float fatPerDay;

  public float proteinPercent;
  public float carbsPercent;
  public float fatPercent;
  public String dietName;
  public float targetWeight;
  public int numDays;
  public int daysPassed;
  public boolean isMaintain; 
  public boolean isLoseWeight; 

  Diet(String dietName, float protein, float carbs, float fat, int totalDays, int daysPassed, boolean isMaintain, boolean isLoseWeight, float targetWeight) {
    this.dietName = dietName;
    this.proteinPercent = protein;
    this.carbsPercent = carbs;
    this.fatPercent = fat;
    this.targetWeight = targetWeight; 
    this.numDays = totalDays;
    this.daysPassed = daysPassed;
    this.isMaintain = isMaintain;
    this.isLoseWeight = isLoseWeight;
  }

    void storeInfoPerDay(User user) { // use this when we need to recalculate calories
      this.calsPerDay = calculateCaloriesPerDay(user);
      HashMap<String, Float> macros = calcMacros(user, this.calsPerDay);
      this.proteinPerDay = macros.get("protein");
      this.carbsPerDay = macros.get("carbs");
      this.fatPerDay = macros.get("fat");
    }


  }