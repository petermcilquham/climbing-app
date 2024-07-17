import 'dart:ui';

class RouteColors {
  Color getColorsBasedOnDifficulty(double difficulty) {
    Color color = const Color.fromARGB(255, 255, 255, 255);

    switch (difficulty) {
      case > 7: //red
        color = const Color.fromARGB(255, 244, 44, 44);
      case > 6: //orange
        color = const Color.fromARGB(255, 240, 137, 11);
      case > 5: //blue
        color = const Color.fromARGB(255, 59, 112, 227);
      case > 4: //green
        color = const Color.fromARGB(255, 120, 239, 69);
      case > 3: //yellow
        color = const Color.fromARGB(255, 252, 237, 76);
    }
    return color;
  }
}
