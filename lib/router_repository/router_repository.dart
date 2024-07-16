// import 'dart:async';

// import 'package:flutter/widgets.dart';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';

// Future<void> initBoulderingRouteDb() async {
//   // Avoid errors caused by flutter upgrade.
//   // Importing 'package:flutter/widgets.dart' is required.
//   WidgetsFlutterBinding.ensureInitialized();
//   // Open the database and store the reference.
//   final database = openDatabase(
//     // Set the path to the database. Note: Using the `join` function from the
//     // `path` package is best practice to ensure the path is correctly
//     // constructed for each platform.
//     join(await getDatabasesPath(), 'bouldering_routes_database.db'),
//     onCreate: (db, version) {
//       // Run the CREATE TABLE statement on the database.
//       return db.execute(
//         'CREATE TABLE boulderingroutes(id INTEGER PRIMARY KEY, boulderingRouteAvgDiff DOUBLE, boulderingRouteDifficulty DOUBLE)',
//       );
//     },
//     // Set the version. This executes the onCreate function and provides a
//     // path to perform database upgrades and downgrades.
//     version: 1,
//   );
// }

// Future<void> insertBoulderingRoute(BoulderingRoute boulderingRoute) async {
//   // Get a reference to the database.
//   final db = await database;

//   // Insert the Dog into the correct table. You might also specify the
//   // `conflictAlgorithm` to use in case the same dog is inserted twice.
//   //
//   // In this case, replace any previous data.
//   await db.insert(
//     'boulderingroutes',
//     boulderingRoute.toMap(),
//     conflictAlgorithm: ConflictAlgorithm.replace,
//   );
// }



// class BoulderingRoute {
//   final int id;
//   double? boulderingRouteAvgDiff = 0.0;
//   double? boulderingRouteDifficulty = 0.0;

//   BoulderingRoute({
//     required this.id,
//     this.boulderingRouteAvgDiff,
//     this.boulderingRouteDifficulty,
//   });

//   Map<String, Object?> toMap() {
//     return {
//       'id': id,
//       'boulderingRouteAvgDiff': boulderingRouteAvgDiff,
//       'boulderingRouteDifficulty': boulderingRouteDifficulty,
//     };
//   }

//   @override
//   String toString() {
//     return 'BoulderingRoute{id: $id, boulderingRouteAvgDiff: $boulderingRouteAvgDiff, boulderingRouteDifficulty: $boulderingRouteDifficulty}';
//   }
// }
