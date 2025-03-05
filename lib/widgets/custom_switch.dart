import 'package:flutter/material.dart';

class CustomSwitch extends StatelessWidget {
  final String label;
  final bool value;
  final Function(bool) onChanged;

  const CustomSwitch({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    // Get screen width using MediaQuery
    final screenWidth = MediaQuery.of(context).size.width;

    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate available width for the text dynamically
        const switchWidth = 50.0; // Approximate width of the Switch widget
        final maxTextWidth =
            constraints.maxWidth - switchWidth - 16.0; // Account for padding

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: maxTextWidth < 0
                      ? 0
                      : maxTextWidth, // Prevent negative width
                ),
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: screenWidth < 400
                        ? 14
                        : 16, // Smaller font on very small screens
                    color: Colors.orange,
                  ),
                  softWrap: true,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            Switch(
              value: value,
              onChanged: onChanged,
              activeColor: Colors.green,
              activeTrackColor: Colors.orange,
              inactiveThumbColor: Colors.grey,
              inactiveTrackColor: Colors.grey[300],
              trackOutlineColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.selected)) return Colors.grey;
                return Colors.transparent;
              }),
              trackOutlineWidth: MaterialStateProperty.all(1.0),
            ),
          ],
        );
      },
    );
  }
}
