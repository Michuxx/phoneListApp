import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phone_list_app/widgets/authButton/authButton.dart';
import 'package:phone_list_app/widgets/authHeader/authHeader.dart';
import 'package:phone_list_app/widgets/changeAuth/ChangeAuth.dart';
import 'package:phone_list_app/widgets/input/input.dart';
import 'package:phone_list_app/widgets/logo/logo.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  String? emailError;
  String? passwordError;
  String? confirmPasswordError;


  final emailPattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

  bool emailValidation(email) {
    final regex =RegExp(emailPattern);
    if (email.isEmpty || !regex.hasMatch(email)) {
      setState(() {
        emailError = "Nieprawidłowy adres e-mail";
      });
      return false;
    } else {
      setState(() {
        emailError = null;
      });
      return true;
    }
  }

  bool passwordValidation(password, confirmPassword) {
    if (password.length < 6) {
      setState(() {
        confirmPasswordError = "Hasło ma mniej niż 6 znaków";
      });
      return false;
    } else if (password !=confirmPassword) {
      setState(() {
        confirmPasswordError = "Nie są takie same";
      });
      return false;
    }
    else {
      setState(() {
        confirmPasswordError = null;
      });
      return true;
    }
  }

  void register() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    final isEmailOk = emailValidation(email);
    final isPassOk  = passwordValidation(password, confirmPassword);

    if(isEmailOk && isPassOk) {
      print("zarejestrowano");
    }
  }

  void goToLogin(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F7FF),
      body: SafeArea(
        child:
        SingleChildScrollView(
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
                errorText: emailError,
              ),
              SizedBox(height: 25),
              Input(
                placeholder: "Password",
                controller: passwordController,
                obscureText: true,
                errorText: passwordError,
              ),
              SizedBox(height: 25),
              Input(
                placeholder: "Confirm Password",
                controller: confirmPasswordController,
                obscureText: true,
                errorText: confirmPasswordError,
              ),
              SizedBox(height: 25),
              Authbutton(onPressed: register, label: 'Utwórz konto'),
              SizedBox(height: 20),
              ChangeAuth(
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


