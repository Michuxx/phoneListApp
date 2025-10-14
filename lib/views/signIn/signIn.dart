import 'package:flutter/material.dart';
import 'package:phone_list_app/SQlite/sqlite.dart';
import 'package:phone_list_app/views/notes/notes.dart';
import 'package:phone_list_app/views/signUp/signUp.dart';
import 'package:phone_list_app/widgets/authButton/authButton.dart';
import 'package:phone_list_app/widgets/authHeader/authHeader.dart';
import 'package:phone_list_app/widgets/changeAuth/ChangeAuth.dart';
import 'package:phone_list_app/widgets/input/input.dart';
import 'package:phone_list_app/widgets/logo/logo.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<StatefulWidget> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final db = DatabaseHelper();

  String? emailError;
  String? passwordError;

  final emailPattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

  void goToRegister(context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const SignUp()));
  }

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

  bool passwordValidation(password) {
    if (password.length < 6) {
      setState(() {
        passwordError = "Hasło ma mniej niż 6 znaków";
      });
      return false;
    } else {
      setState(() {
        passwordError = null;
      });
      return true;
    }
  }

  void login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    final isEmailOk = emailValidation(email);
    final isPassOk  = passwordValidation(password);

    if(isEmailOk && isPassOk) {
        var res = await db.loginDb(email, password);
        if(res == true) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Notes()));
        } else {
          setState(() {
            emailError = "Nieprawidłowy email lub hasło";
          });
        }

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F7FF),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Logo(),
              const SizedBox(height: 80),
              const AuthHeader(header: "Zaloguj się do konta"),
              const SizedBox(height: 30),
              Input(
                placeholder: "Email",
                controller: emailController,
                errorText: emailError,
              ),
              const SizedBox(height: 25),
              Input(
                placeholder: "Password",
                controller: passwordController,
                obscureText: true,
                errorText: passwordError,
              ),
              const SizedBox(height: 25),
              Authbutton(onPressed: login, label: 'Zaloguj'),
              const SizedBox(height: 50),
              ChangeAuth(
                text: 'Nie masz konta? ',
                textAction: "Zarejestruj się",
                onTap: () => goToRegister(context),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );

  }
}
