import 'package:flutter/material.dart';
import 'package:phone_list_app/widgets/logo/logo.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Logo(),
      )
    );
  }
}
