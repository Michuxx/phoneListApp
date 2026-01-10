import 'package:flutter/material.dart';
import 'package:phone_list_app/services/sessionManager/sessionManager.dart';
import 'package:phone_list_app/views/notes/notes.dart';
import 'package:phone_list_app/views/signIn/signIn.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  int? userId = await SessionManager.getUserId();

  runApp(MyApp(userId: userId));
}

class MyApp extends StatelessWidget {
  final int? userId;

  const MyApp({super.key, this.userId});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aplikacja do notatek',
      // 4. Logika wyboru ekranu startowego
      home: userId != null ? Notes(userId: userId!) : const SignIn(),
    );
  }
}