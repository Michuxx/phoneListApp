import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phone_list_app/widgets/authButton/authButton.dart';
import 'package:phone_list_app/widgets/authHeader/authHeader.dart';
import 'package:phone_list_app/widgets/goToSignUp/goToSignUp.dart';
import 'package:phone_list_app/widgets/input/input.dart';
import 'package:phone_list_app/widgets/logo/logo.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}


final emailController = TextEditingController();
final passwordController = TextEditingController();
final confirmPasswordController = TextEditingController();

void register() {}

void goToLogin(BuildContext context) {
  Navigator.pop(context);
}

class _SignUpState extends State<SignUp> {
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
              AuthHeader(header: "Utwórz konto"),
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
              Input(
                placeholder: "Confirm Password",
                controller: confirmPasswordController,
                obscureText: true,
              ),
              SizedBox(height: 25),
              Authbutton(onPressed: register, label: 'Utwórz konto'),
              Spacer(),
              GoToSignUp(
                  text: 'Masz konto? ',
                  textAction: "Zaloguj się",
                  onTap: () => goToLogin(context)
              )
            ],
          ),
        ),
      ),
    );
  }
}


