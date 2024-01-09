// ignore_for_file: unnecessary_this, unnecessary_new, prefer_collection_literals

class LoginRequestModel {
  String? username;
  String? password;

  LoginRequestModel({this.username, this.password});

  LoginRequestModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['password'] = this.password;
    return data;
  }
}