class SliderSwitch {
  String intToStringSwitch(int value) {
    String result = '';
    switch (value) {
      case 0:
        result = '3';
      case 1:
        result = '4';
      case 2:
        result = '5a';
      case 3:
        result = '5b';
      case 4:
        result = '5c';
      case 5:
        result = '6a';
      case 6:
        result = '6a+';
      case 7:
        result = '6b';
      case 8:
        result = '6b+';
      case 9:
        result = '6c';
      case 10:
        result = '6c+';
      case 11:
        result = '7a';
      case 12:
        result = '7a+';
      case 13:
        result = '7b';
      case 14:
        result = '7b+';
      case 15:
        result = '7c';
      case 16:
        result = '7c+';
      case 17:
        result = '8a';
    }
    return result;
  }
}
