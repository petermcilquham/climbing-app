class AverageNumber {
  double getAverageNumberFromList(List<dynamic> numbers) {
    return (numbers.reduce((a, b) => a + b)) / numbers.length;
  }
}
