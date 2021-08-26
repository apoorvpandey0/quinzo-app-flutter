class UserModel {
  String access_token;
  String refresh_token;
  String fname;
  String username;
  String lname;
  String email;
  String password;
  String phone;
  UserModel(
      {this.access_token,
      this.refresh_token,
      this.fname,
      this.lname,
      this.username,
      this.email,
      this.password,
      this.phone});
  UserModel.fromJson(Map<String, dynamic> json) {
    access_token = json['access_token'];
    refresh_token = json['refresh_token'];
    fname = json['fname'];
    lname = json['lname'];
    username = json['username'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
  }
  // convert this to json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['access_token'] = this.access_token;
    data['refresh_token'] = this.refresh_token;
    data['fname'] = this.fname;
    data['lname'] = this.lname;
    data['username'] = this.username;
    data['email'] = this.email;
    data['password'] = this.password;
    data['phone'] = this.phone;
    return data;
  }
}
