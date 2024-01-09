// ignore_for_file: unnecessary_this, unnecessary_new, prefer_collection_literals

class LoginResponseModel {
  String? refresh;
  String? access;

  LoginResponseModel({this.refresh, this.access});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    refresh = json['refresh'];
    access = json['access'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['refresh'] = this.refresh;
    data['access'] = this.access;
    return data;
  }
}
