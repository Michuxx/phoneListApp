import 'package:flutter/material.dart';
import 'package:phone_list_app/widgets/authButton/authButton.dart';
import 'package:phone_list_app/widgets/authHeader/authHeader.dart';
import 'package:phone_list_app/widgets/goToSignUp/goToSignUp.dart';
import 'package:phone_list_app/widgets/input/input.dart';
import 'package:phone_list_app/widgets/logo/logo.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<StatefulWidget> createState() => _SignInState();
}

void login() {

}

void goToRegister() {

}

class _SignInState extends State<SignIn> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F7FF),
      body: SafeArea(
        child:
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Logo(),
              SizedBox(height: 80),
              AuthHeader(header: "Zaloguj się do konta"),
              SizedBox(height: 30),
              Input(
                placeholder: "Email",
                controller: emailController,
              ),
              SizedBox(height: 25),
              Input(
                placeholder: "Password",
                controller: passwordController,
                obscureText: true,
              ),
              SizedBox(height: 25),
              Authbutton(onPressed: login, label: 'Zaloguj'),
              Spacer(),
              GoToSignUp(
                  text: 'Nie masz konta? ',
                  textAction: "Zarejestruj się",
                  onTap: goToRegister
              )
            ],
          ),
        ),
      ),
    );
  }
}
