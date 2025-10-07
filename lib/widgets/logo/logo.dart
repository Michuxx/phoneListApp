import 'package:flutter/material.dart';

class Logo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: 140),
        child: Text(
          'DSW 56135',
          style: TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}
