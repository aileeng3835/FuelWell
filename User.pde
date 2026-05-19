class User {
  //Fields
  String name;
  int age;
  String sex;
  float userHeight, weight;
  ArrayList<String> dietaryRestrictions = new ArrayList<String>();
  Diet diet; 
    //0 is maintain, 1 is bulk, 2 is cut, 3 is lose weight
  
  User() {  
    resetUser(this);
  }
  
}
