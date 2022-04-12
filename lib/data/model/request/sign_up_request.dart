class SignUpRequest{
  String? email;
  String? name;
  String? password;
  String? phone;
  String? address;

  SignUpRequest(
      {this.email, this.name, this.password, this.phone, this.address});

  SignUpRequest.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    password = json['password'];
    phone = json['phone'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['name'] = this.name;
    data['password'] = this.password;
    data['phone'] = this.phone;
    data['address'] = this.address;
    return data;
  }

}