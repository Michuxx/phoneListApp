import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final String placeholder;
  final bool obscureText;
  final TextEditingController controller;
  final String? errorText;

  const Input({
    super.key,
    required this.placeholder,
    this.obscureText = false,
    required this.controller,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasError = errorText != null && errorText!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: hasError
                ? Border.all(color: Colors.red, width: 1.5)
                : null,
            boxShadow: [
              BoxShadow(
                color: hasError
                    ? Colors.red.withOpacity(0.2)
                    : Colors.deepPurple.withOpacity(0.15),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextField(
            obscureText: obscureText,
            controller: controller,
            decoration: InputDecoration(
              labelText: placeholder,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 18,
              ),
            ),
          ),
        ),
        if (hasError)
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 4),
            child: Text(
              errorText!,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
      ],
    );
  }
}
