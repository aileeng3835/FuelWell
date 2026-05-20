class Diet {
    //fields
    float calsPerDay;
    float proteinPerDay;
    float carbsPerDay;
    float fatPerDay;

    // basically a type of diet
    // we can have it so that we have a list
    // of preconfigured percentages for things like
    // bulking or cutting, so that we don't have to manually
    // do a bunch of if statements

    float proteinPercent;
    float carbsPercent;
    float fatPercent;
    String dietName;
    float targetWeight;
    int numDays;
    int daysPassed;
    boolean isMaintain; // is this a maintenance diet
    boolean isLoseWeight; // is this diet designed to lose weight (we can check if the user is trying to lose weight on a bulk or something akin to that)

    Diet(String dietName, float protein, float carbs, float fat, boolean isMaintain, boolean isLoseWeight) {
      
      this.dietName = dietName;
      this.proteinPercent = protein;
      this.carbsPercent = carbs;
      this.fatPercent = fat;
      this.targetWeight = 0; // user sets this later
      this.numDays = 0;
      this.daysPassed = 0;
      this.isMaintain = isMaintain;
      this.isLoseWeight = isLoseWeight;

    }

    void storeInfoPerDay(User user) { // use this when we need to recalculate calories
      this.calsPerDay = calculateCaloriesPerDay(user);
      this.proteinPerDay = calcMacros(user).get("protein");
      this.carbsPerDay = calcMacros(user).get("carbs");
      this.fatPerDay = calcMacros(user).get("fat");
    }


  }