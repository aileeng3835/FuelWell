class User {
  //Fields
  String name;
  int age;
  String sex;
  float userHeight, weight;
  ArrayList<String> dietaryRestrictions = new ArrayList<String>();
  Diet diet;
  float calsPerDay;
    //0 is maintain, 1 is bulk, 2 is cut, 3 is lose weight
  
  User(String name, int age, String sex, float userheight, float weight, ArrayList<String> dietaryRestrictions, String dietname, ArrayList<Diet> dietList) {  
    this.name = name;
    this.age = age;
    this.sex = sex;
    this.userHeight = userheight;
    this.weight = weight;
    this.dietaryRestrictions = dietaryRestrictions;
    this.diet = fetchDietWithDietName(dietname, dietList);

  }


  
  
}
