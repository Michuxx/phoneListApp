import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Authbutton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  const Authbutton({
    super.key,
    required this.onPressed,
    required this.label
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF1A3DC1),
          minimumSize: Size(double .infinity, 65),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)
          ),
          elevation: 6,
          shadowColor: Colors.black.withOpacity(0.2),
      ),
      child: Text(label,
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20
        ),),
    );
  }
}
