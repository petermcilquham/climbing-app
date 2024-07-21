import 'package:climbing_app/logic/slider_switch.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class SliderWidget extends StatefulWidget {
  const SliderWidget({super.key, required this.min, required this.max});

  final int min;
  final int max;

  @override
  State<SliderWidget> createState() => SliderWidgetState();
}

class SliderWidgetState extends State<SliderWidget> {
  final SliderSwitch _sliderSwitch = SliderSwitch();

  int _value = 0;

  String returnState() {
    return _sliderSwitch.intToStringSwitch(_value);
  }

  @override
  void initState() {
    _value = widget.min;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SfSlider(
      min: widget.min,
      max: widget.max,
      interval: 1,
      stepSize: 1,
      value: _value,
      showLabels: true,
      activeColor: const Color.fromARGB(255, 204, 156, 156),
      inactiveColor: const Color.fromARGB(255, 204, 156, 156),
      enableTooltip: true,
      tooltipTextFormatterCallback: (dynamic actualTooltip, String formattedTooltip) {
        return _sliderSwitch.intToStringSwitch(actualTooltip);
      },
      labelFormatterCallback: (dynamic actualValue, String formattedValue) {
        return _sliderSwitch.intToStringSwitch(actualValue);
      },
      onChanged: (dynamic newValue) {
        setState(() {
          _value = newValue;
        });
      },
    );
  }
}
