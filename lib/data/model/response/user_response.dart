class UserResponse{
  String? email;
  String? name;
  String? phone;
  int? userGroup;
  String? registerDate;
  String? token;

  UserResponse(
      {this.email,
        this.name,
        this.phone,
        this.userGroup,
        this.registerDate,
        this.token});

  UserResponse.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    userGroup = json['userGroup'];
    registerDate = json['registerDate'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['userGroup'] = this.userGroup;
    data['registerDate'] = this.registerDate;
    data['token'] = this.token;
    return data;
  }

  static UserResponse formJson(Map<String, dynamic> json){
    return UserResponse.fromJson(json);
  }

  @override
  String toString() {
    return 'UserResponse{email: $email, name: $name, phone: $phone, userGroup: $userGroup, registerDate: $registerDate, token: $token}';
  }
}