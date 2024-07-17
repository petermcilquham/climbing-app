class BoulderingRoute {
  final String officialDifficulty;
  final List<dynamic> boulderingRouteDifficulty;
  final double avgDifficulty;
  final String routeID; //document name

  BoulderingRoute({
    required this.officialDifficulty,
    required this.boulderingRouteDifficulty,
    this.avgDifficulty = 0.0,
    this.routeID = '',
  });

  // Convert a BoulderingRoute into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, Object?> toMap() {
    return {
      'boulderingRouteName': officialDifficulty,
      'boulderingRouteDifficulty': boulderingRouteDifficulty,
    };
  }

  // Implement toString to make it easier to see information about
  // each BoulderingRoute when using the print statement.
  @override
  String toString() {
    return 'BoulderingRoute{boulderingRouteName: $officialDifficulty, boulderingRouteDifficulty: $boulderingRouteDifficulty}';
  }
}
