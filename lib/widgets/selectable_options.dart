import 'package:flutter/material.dart';

class SelectableOptions extends StatelessWidget {
  final String label;
  final List<Map<String, dynamic>> options;
  final String selectedOption;
  final Function(String) onSelected;

  const SelectableOptions({
    required this.label,
    required this.options,
    required this.selectedOption,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, color: Colors.teal),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: options.map((option) {
            bool isSelected = selectedOption == option['label'];
            return GestureDetector(
              onTap: () => onSelected(option['label']),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  border:
                      Border.all(color: isSelected ? Colors.blue : Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Icon(option['icon'],
                    //     color: isSelected ? Colors.blue : Colors.grey),
                    // const SizedBox(width: 8),
                    Text(option['label'],
                        style: const TextStyle(color: Colors.black)),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
