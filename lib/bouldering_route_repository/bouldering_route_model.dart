class BoulderingRoute {
  final String boulderingRouteName;
  final List<dynamic> boulderingRouteDifficulty;
  final double avgDifficulty;

  BoulderingRoute({
    required this.boulderingRouteName,
    required this.boulderingRouteDifficulty,
    this.avgDifficulty = 0.0,
  });

  // Convert a BoulderingRoute into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, Object?> toMap() {
    return {
      'boulderingRouteName': boulderingRouteName,
      'boulderingRouteDifficulty': boulderingRouteDifficulty,
    };
  }

  // Implement toString to make it easier to see information about
  // each BoulderingRoute when using the print statement.
  @override
  String toString() {
    return 'BoulderingRoute{boulderingRouteName: $boulderingRouteName, boulderingRouteDifficulty: $boulderingRouteDifficulty}';
  }
}
