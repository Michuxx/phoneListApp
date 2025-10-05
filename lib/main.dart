import 'package:flutter/material.dart';
import 'package:phone_list_app/views/signIn/signIn.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/signIn',
    routes: {
      '/signIn': (context) => const SignIn(),
    },
  ));
}
