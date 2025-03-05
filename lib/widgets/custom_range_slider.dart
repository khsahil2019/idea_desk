import 'package:flutter/material.dart';

class CustomRangeSlider extends StatelessWidget {
  final String heading;
  final RangeValues? rangeValues; // For RangeSlider mode
  final double? singleValue; // For Slider mode
  final double min;
  final double max;
  final int divisions;
  final String unit;
  final bool isRangeSlider; // Toggle between RangeSlider and Slider
  final Function(RangeValues)? onRangeChanged; // Callback for RangeSlider
  final Function(double)? onSingleChanged; // Callback for Slider
  final TextStyle? headingStyle;

  const CustomRangeSlider({
    required this.heading,
    this.rangeValues, // Required for RangeSlider mode
    this.singleValue, // Required for Slider mode
    required this.min,
    required this.max,
    required this.divisions,
    required this.unit,
    this.isRangeSlider = true, // Default to RangeSlider
    this.onRangeChanged, // Required if isRangeSlider is true
    this.onSingleChanged, // Required if isRangeSlider is false
    this.headingStyle,
  }) : assert(isRangeSlider && rangeValues != null && onRangeChanged != null ||
            !isRangeSlider && singleValue != null && onSingleChanged != null);

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
        const SizedBox(height: 8),
        isRangeSlider
            ? RangeSlider(
                values: rangeValues!,
                min: min,
                max: max,
                divisions: divisions,
                labels: RangeLabels(
                  '${rangeValues!.start.round()}$unit',
                  '${rangeValues!.end.round()}$unit',
                ),
                activeColor: Colors.orange,
                inactiveColor: Colors.grey[300],
                onChanged: onRangeChanged!,
              )
            : Slider(
                value: singleValue!,
                min: min,
                max: max,
                divisions: divisions,
                label: '${singleValue!.round()}$unit',
                activeColor: Colors.orange,
                inactiveColor: Colors.grey[300],
                onChanged: onSingleChanged!,
              ),
        Text(
          isRangeSlider
              ? '${rangeValues!.start.round()} - ${rangeValues!.end.round()} $unit'
              : '${singleValue!.round()} $unit',
          style: const TextStyle(fontSize: 14, color: Colors.orange),
        ),
      ],
    );
  }
}
