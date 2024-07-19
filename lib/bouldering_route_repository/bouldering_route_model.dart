class BoulderingRoute {
  final String? routeID; //document name
  final String routeName; //also official difficulty
  final List<dynamic>? gradedDifficulties;
  final double? avgGradedDifficulty;
  final Map<dynamic, dynamic>? gradedDifficultiesMap; // <gradedDifficulty, no of grades>

  BoulderingRoute({
    this.routeID,
    required this.routeName,
    this.gradedDifficulties,
    this.avgGradedDifficulty,
    this.gradedDifficultiesMap,
  });

  // Implement toString to make it easier to see information about
  // each BoulderingRoute when using the print statement.
  @override
  String toString() {
    return 'BoulderingRoute{boulderingRouteName: $routeName, boulderingRouteDifficulty: $gradedDifficulties}';
  }
}
