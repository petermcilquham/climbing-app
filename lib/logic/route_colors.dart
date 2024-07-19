import 'package:flutter/material.dart';

class RouteColors {
  Color getColorsBasedOnDifficulty(String routeName) {
    Color color = const Color.fromARGB(255, 255, 255, 255);

    switch (routeName) {
      case '8a': //black
        color = const Color.fromARGB(255, 0, 0, 0);
      case '7a' || '7a+' || '7b' || '7b+'|| '7c' || '7c+': //red
        color = const Color.fromARGB(255, 244, 44, 44);
      case '6a' || '6a+' || '6b' || '6b+'|| '6c' || '6c+': //orange
        color = const Color.fromARGB(255, 240, 137, 11);
      case '5a' || '5b' || '5c': //blue
        color = const Color.fromARGB(255, 59, 112, 227);
      case '4': //yellow
        color = const Color.fromARGB(255, 252, 237, 76);
      case '3': //green
        color = const Color.fromARGB(255, 120, 239, 69);
    }
    return color;
  }
}
