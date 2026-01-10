import 'package:flutter/cupertino.dart';
import 'package:phone_list_app/widgets/socialButton/socialButton.dart';

class SocialLoginBlock extends StatelessWidget {
  const SocialLoginBlock({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Or sign in with",
          style: TextStyle(
            color: Color(0xFF471AA0),
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            socialButton('lib/images/google.png', () {
              print("Google login");
            }),
            socialButton('lib/images/fb.png', () {
              print("Facebook login");
            }),
            socialButton('lib/images/x.png', () {
              print("X login");
            }),
            socialButton('lib/images/linkedin.png', () {
              print("LinkedIn login");
            }),
          ],
        ),
      ],
    );
  }
}