import 'package:flutter/material.dart';

class Logo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: 90),
        child: Image.asset(
            'lib/images/logo.png',
        width: 150,
        ),
      ),
    );
  }
}
