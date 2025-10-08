import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthHeader extends StatelessWidget {
  final String header;

  const AuthHeader({
    super.key,
    required this.header
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      header,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 28,
          color: Colors.black54
      ),
    );
  }
}
