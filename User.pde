class User {
  // Can someone else try without all the publics because for some reason I needed to add this cause it would flash an error.
  public String name;
  public int age;
  public String sex;
  public float userHeight, weight;
  public ArrayList<String> dietaryRestrictions = new ArrayList<String>();
  public Diet diet;
  
  User(String name, int age, String sex, float userheight, float weight, ArrayList<String> dietaryRestrictions, String dietname, ArrayList<Diet> dietList) {  
    this.name = name;
    this.age = age;
    this.sex = sex;
    this.userHeight = userheight;
    this.weight = weight;
    this.dietaryRestrictions = dietaryRestrictions;
    this.diet = fetchDietWithDietName(dietname, dietList);
    
    if(this.diet == null && dietList.size() > 0) {
        this.diet = dietList.get(0);
    }
  }
}