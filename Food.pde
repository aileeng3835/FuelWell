class Food {
    //Fields
    String name;

    float gramsFat;
    float gramsCarbs;
    float gramsProtein;
    float gramsSugar; // sugar is a type of carb
    
    String[] restrictionCategories;
    String[] otherCategories; // i'm assuming this could be like high protein, low carbs, ...

    //Constructor
    Food(String name, float gramsFat, float gramsCarbs, float gramsProtein, float gramsSugar, String[] restrictionCategories, String[] otherCategories){
        this.name = name;

        this.gramsFat = gramsFat;
        this.gramsCarbs = gramsCarbs;
        this.gramsProtein = gramsProtein;
        this.gramsSugar = gramsSugar;

        this.restrictionCategories = restrictionCategories;
        this.otherCategories = otherCategories;
    }

    //Methods
    float getTotalCalories() {
        //9 calories per gram of fat, 4 for carbs, and 4 for protein
        float totalCalories = (gramsFat *  9) + (gramsCarbs * 4) + (gramsProtein * 4);
        return totalCalories;
    }
}