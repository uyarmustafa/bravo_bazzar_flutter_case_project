// ignore_for_file: avoid_print

import 'package:bravo_bazzar_flutter_case_project/login/viewmodel/login_service.dart';
import 'package:bravo_bazzar_flutter_case_project/home/home_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Center(child: Text('Login'))),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'asset/image/ShopGo_logo.png',
                width: 100,
                height: 100,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  AutofillGroup(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: usernameController,
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: passwordController,
                          textInputAction: TextInputAction.next,
                          obscureText: true,
                          obscuringCharacter: '*',
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            if (usernameController.text != '' ||
                                passwordController.text != '') {
                              fetchLoginService(usernameController.text,
                                  passwordController.text);
                              isLoginFail
                                  ? null
                                  : Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const HomeView()));
                            } else {
                              print('Username and password are mandatory');
                            }
                          },
                          key: const Key("loginButton"),
                          child: const Text('Login'),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
