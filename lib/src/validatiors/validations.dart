class Validations{
  static bool isValidUser(String user){
    return user != null && user.length >= 6 && user.length <= 30 ;
  }

  static bool isValidPass(String password){
    bool hasSpecialCharacters = password.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    return password != null && password.length >= 6 && password.length <= 30 && hasSpecialCharacters == false ;
  }
}