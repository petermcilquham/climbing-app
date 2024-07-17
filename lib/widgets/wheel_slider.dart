import 'package:flutter/material.dart';
import 'package:wheel_slider/wheel_slider.dart';

class WheelSliderWidget extends StatefulWidget {
  const WheelSliderWidget({super.key});

  @override
  State<WheelSliderWidget> createState() => _WheelSliderWidgetState();
}

class _WheelSliderWidgetState extends State<WheelSliderWidget> {
  double _nCurrentValue = 4.0;

  var list = [for (var i = 3; i < 14; i += 1) i];

  @override
  Widget build(BuildContext context) {
    return WheelSlider.customWidget(
      //interval: 0.5, // this field is used to show decimal/double values
      //perspective: 0.01,
      totalCount: 10,
      initValue: 0,
      isInfinite: false,
      horizontal: false,
      scrollPhysics: const BouncingScrollPhysics(),
      verticalListHeight: 200,
      // unSelectedNumberStyle: const TextStyle(
      //   fontSize: 12.0,
      //   color: Colors.black54,
      // ),
      // currentIndex: _nCurrentValue,
      onValueChanged: (val) {
        setState(() {
          _nCurrentValue = val;
        });
      },
      hapticFeedbackType: HapticFeedbackType.heavyImpact,
      itemSize: 80,
      children: List.generate(
        10,
        (index) => Center(
          child: Text(index.toString()),
        ),
      ),
    );
  }
}
