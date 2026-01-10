import 'package:flutter/material.dart';
import 'package:phone_list_app/SQlite/sqlite.dart';
import 'package:phone_list_app/views/notes/notes.dart';
import 'package:phone_list_app/views/signUp/signUp.dart';
import 'package:phone_list_app/widgets/authButton/authButton.dart';
import 'package:phone_list_app/widgets/authHeader/authHeader.dart';
import 'package:phone_list_app/widgets/changeAuth/ChangeAuth.dart';
import 'package:phone_list_app/widgets/input/input.dart';
import 'package:phone_list_app/widgets/logo/logo.dart';
import 'package:phone_list_app/widgets/socialLoginBlock/socialLoginBlock.dart';

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

  void goToRegister(context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const SignUp()));
  }

  bool emailValidation(email) {
    if (email.isEmpty) {
      setState(() {
        emailError = "Nieprawidłowy adres e-mail lub nazwa";
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
        if(res != null) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Notes(userId: res,)));
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
              const SizedBox(height: 10),
              const AuthHeader(header: "Sign in"),
              const SizedBox(height: 30),
              Input(
                placeholder: "Email or name",
                controller: emailController,
                errorText: emailError,
                prefixIcon: Icon(Icons.person_outline),
              ),
              const SizedBox(height: 25),
              Input(
                placeholder: "Password",
                controller: passwordController,
                obscureText: true,
                errorText: passwordError,
                prefixIcon: Icon(Icons.lock_outline),
                suffixIcon: Icon(Icons.visibility),
              ),
              const SizedBox(height: 25),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Forgot password?",
                  style: TextStyle(
                    color: Color(0xFF471AA0),
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Authbutton(onPressed: login, label: 'Sign In'),
              const SizedBox(height: 60),
              const SocialLoginBlock(),
              const SizedBox(height: 50),
              ChangeAuth(
                text: "Don't have account? ",
                textAction: "Sign Up",
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
