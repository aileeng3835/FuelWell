class Food {
    public String name;
    public float gramsFat;
    public float gramsCarbs;
    public float gramsProtein;
    public float gramsSugar; 
    
    public String[] restrictionCategories;
    public String[] otherCategories; 

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
        return (gramsFat *  9) + (gramsCarbs * 4) + (gramsProtein * 4);
    }
}