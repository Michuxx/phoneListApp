import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChangeAuth extends StatelessWidget {
  final String text;
  final String textAction;
  final VoidCallback onTap;

  const ChangeAuth({
    super.key,
    required this.text,
    required this.textAction,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
         Text(
          text,
          style: TextStyle(
              color: Colors.black54,
            fontSize: 20,
          ),

        ),
        TextButton(
            onPressed: onTap,
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size(0,0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap
            ),
            child: Text(
                textAction,
              style: TextStyle(fontSize: 20),
            ))
      ],
    );
  }
}
