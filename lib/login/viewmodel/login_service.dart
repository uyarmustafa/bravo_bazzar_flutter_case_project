// ignore_for_file: avoid_print

import 'dart:io';

import 'package:dio/dio.dart';

import '../../shared_prefrences.dart';
import '../model/login_request_model.dart';
import '../model/login_response_model.dart';

String path = "https://api.bravoshopgo.com/api/v1/token/";
String? token;
bool isLoginFail = false;



Future<void> fetchLoginService(String username, String password) async {
  try {
    LoginResponseModel? data = await login(
      LoginRequestModel(
        username: username, //'test_user',
        password: password, //'61b2szWzvrgEZ46',
      ),
    );
    if (data?.access != '' || data?.access != null) {
      token = data?.access;
      LocaleManager.instance.setStringValue(PreferencesKeys.TOKEN, token!);

      isLoginFail = false;
      // String aa = LocaleManager.instance.getStringValue(PreferencesKeys.TOKEN);
      // print(aa);
    } else {
      isLoginFail = true;
      print("Token could not be received.");
    }
  } catch (e) {
    isLoginFail = true;
    print(e.toString());
  }
}

Future<LoginResponseModel?> login(LoginRequestModel model) async {
  try {
    final response = await Dio().post(
      path,
      data: model,
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Origin': 'https://api.bravoshopgo.com'
        },
      ),
    );
    if (response.statusCode == HttpStatus.ok) {
      return LoginResponseModel.fromJson(response.data);
    }
  } catch (e) {
    print(e.toString());
  }
  return null;
}
