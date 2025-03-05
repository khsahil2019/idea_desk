import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:idea_desk/widgets/custom_text_field.dart';

class DynamicTextFieldList extends StatelessWidget {
  final String heading; // Heading text above the fields
  final RxList<TextEditingController>
      controllers; // Observable list of controllers
  final VoidCallback onAddField; // Callback to add a new field
  final Function(int) onRemoveField; // Callback to remove a field at index
  final TextStyle? headingStyle; // Optional heading style
  final bool showRemoveButton; // Whether to show remove buttons (default: true)

  const DynamicTextFieldList({
    required this.heading,
    required this.controllers,
    required this.onAddField,
    required this.onRemoveField,
    this.headingStyle,
    this.showRemoveButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
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
          const SizedBox(height: 0),
          ...controllers.map((controller) {
            final index = controllers.indexOf(controller);
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      heading: '', // No repeated heading for each field
                      controller: controller,
                    ),
                  ),
                  if (showRemoveButton &&
                      controllers.length >
                          1) // Show remove button if more than one field
                    IconButton(
                      icon: const Icon(Icons.remove_circle, color: Colors.red),
                      onPressed: () => onRemoveField(index),
                    ),
                ],
              ),
            );
          }).toList(),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton.icon(
                onPressed: onAddField,
                icon: const Icon(Icons.add, color: Colors.teal),
                label: const Text(
                  'Add More',
                  style: TextStyle(color: Colors.teal),
                ),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.teal,
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: Colors.teal, width: 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
