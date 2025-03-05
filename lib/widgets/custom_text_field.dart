import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String heading; // Heading text above the TextField
  final TextEditingController? controller; // Optional controller for input
  final TextStyle? headingStyle; // Optional style for the heading
  final double borderWidth; // Border width (default to 1)
  final Color borderColor; // Border color (default to teal)
  final double borderRadius; // Border radius (default to 4)

  const CustomTextField({
    required this.heading,
    this.controller,
    this.headingStyle,
    this.borderWidth = 1.0,
    this.borderColor = Colors.teal,
    this.borderRadius = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading,
          style: headingStyle ??
              const TextStyle(
                fontSize: 16,
                color: Colors.teal,
              ),
        ),
        const SizedBox(height: 8), // Space between heading and TextField
        TextField(
          controller: controller, // Optional controller
          maxLines: null, // Allows expansion to multiple lines
          minLines: 1, // Starts with 1 line, expands as needed
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor, width: borderWidth),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor, width: borderWidth),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor, width: borderWidth),
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
        ),
      ],
    );
  }
}
