class Food {
    //Fields
    String name;
    float gramsFat;
    float gramsCarbs;
    float gramsProtein;
    String[] restrictionCategories;

    //Constructor
    Food(String name, float gramsFat, float gramsCarbs, float gramsProtein, String[] restrictionCategories) {
        this.name = name;
        this.gramsFat = gramsFat;
        this.gramsCarbs = gramsCarbs;
        this.gramsProtein = gramsProtein;
        this.restrictionCategories = restrictionCategories;

    }

    //Methods
    float getTotalCalories() {
        //9 calories per gram of fat, 4 for carbs, and 4 for protein
        float totalCalories = (gramsFat *  9) + (gramsCarbs * 4) + (gramsProtein * 4);
        return totalCalories;
    }
}