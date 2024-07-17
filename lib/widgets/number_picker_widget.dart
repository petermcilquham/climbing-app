import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class NumberPickerWidget extends StatefulWidget {
  const NumberPickerWidget({super.key});

  @override
  State<NumberPickerWidget> createState() => _NumberPickerWidgetState();
}

class _NumberPickerWidgetState extends State<NumberPickerWidget> {
  final value = 3.0;

  @override
  Widget build(BuildContext context) {
    return DecimalNumberPicker(
      minValue: 3,
      maxValue: 9,
      value: value,
      decimalPlaces: 1,
      onChanged: (value) => setState(() => value = value),
    );
  }
}
