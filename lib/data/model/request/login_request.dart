class LoginRequest{
  late String email;
  late String password;

  LoginRequest({required String email , required String password}){
    if(email.isValidEmail() && password.isValidPassword()){
      this.email = email;
      this.password = password;
    }else{
      throw Exception("Invalid email or password");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }

}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
  bool isMatch(String email2){
    if(this == email2){
      return true;
    }
    return false;
  }
}
extension Password on String {
  bool isValidPassword() {
    return this.length >= 8;
  }
}