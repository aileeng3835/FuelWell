class User {
  //Fields
  String name;
  int age;
  String sex;
  float userHeight, weight;
  ArrayList<String> dietaryRestrictions = new ArrayList<String>();
  Diet diet; 
    //0 is stay healthy, 1 is lose weight, 2 is bulk, 3 is cut
  
  User() {  
    resetUser(this);
  }
  
}
