class BoulderingRoute {
  final int id;
  final String boulderingRouteName;
  final double boulderingRouteDifficulty;

  BoulderingRoute({
    required this.id,
    required this.boulderingRouteName,
    this.boulderingRouteDifficulty = 0.0,
  });

  // Convert a BoulderingRoute into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, Object?> toMap() {
    return {
      'id': id,
      'boulderingRouteName': boulderingRouteName,
      'boulderingRouteDifficulty': boulderingRouteDifficulty,
    };
  }

  // Implement toString to make it easier to see information about
  // each BoulderingRoute when using the print statement.
  @override
  String toString() {
    return 'BoulderingRoute{id: $id, boulderingRouteName: $boulderingRouteName, boulderingRouteDifficulty: $boulderingRouteDifficulty}';
  }
}
