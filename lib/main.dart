import 'package:flutter/material.dart';
import 'package:flutter_application_1/repositories/bouldering_route.dart';
import 'package:flutter_application_1/widgets/custom_app_bar.dart';
import 'package:flutter_application_1/widgets/drawer_widget.dart';

import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';
import 'package:flutter_application_1/screens/page_two.dart';
import 'package:flutter_application_1/screens/page_three.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  // Set up the SettingsController, which will glue user settings to multiple
  // Flutter Widgets.
  final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();

  // Run the app and pass in the SettingsController. The app listens to the
  // SettingsController for changes, then passes it further down to the
  // SettingsView.
  // runApp(MyApp(settingsController: settingsController));

  //runApp(const MyApp());

  WidgetsFlutterBinding.ensureInitialized();
  // Open the database and store the reference.
  final database = openDatabase(
    // Set the path to the database. Note: Using the `join` function from the `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    join(await getDatabasesPath(), 'bouldering_routes_database.db'),
    // When the database is first created, create a table to store boulderingRoutes.
    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      return db.execute(
        'CREATE TABLE bouldering_routes(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)',
      );
    },
    // Set the version. This executes the onCreate function and provides a path to perform database upgrades and downgrades.
    version: 1,
  );

  // INSERT function
  Future<void> insertBoulderingRoute(BoulderingRoute boulderingRoute) async {
    // Get a reference to the database.
    final db = await database;

    // Insert the BoulderingRoute into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same boulderingRoute is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'bouldering_routes',
      boulderingRoute.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // GET function
  Future<List<BoulderingRoute>> getBoulderingRoutes() async {
    // Get a reference to the database.
    final db = await database;

    // Query the table for all the boulderingRoutes.
    final List<Map<String, Object?>> boulderingRoutesMaps =
        await db.query('bouldering_routes');

    // Convert the list of each boulderingRoutes's fields into a list of `BoulderingRoute` objects.
    return [
      for (final {
            'id': id as int,
            'boulderingRouteName': boulderingRouteName as String,
            'boulderingRouteDifficulty': boulderingRouteDifficulty as double,
          } in boulderingRoutesMaps)
        BoulderingRoute(
            id: id,
            boulderingRouteName: boulderingRouteName,
            boulderingRouteDifficulty: boulderingRouteDifficulty),
    ];
  }

  //UPDATE function
  Future<void> updateBoulderingRoute(BoulderingRoute boulderingRoute) async {
    // Get a reference to the database.
    final db = await database;

    // Update the given BoulderingRoute.
    await db.update(
      'bouldering_routes',
      boulderingRoute.toMap(),
      // Ensure that the boulderingRoute has a matching id.
      where: 'id = ?',
      // Pass the BoulderingRoute's id as a whereArg to prevent SQL injection.
      whereArgs: [boulderingRoute.id],
    );
  }

  //DELETE function
  Future<void> deleteBoulderingRoute(int id) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the BoulderingRoute from the database.
    await db.delete(
      'bouldering_routes',
      // Use a `where` clause to delete a specific boulderingRoute.
      where: 'id = ?',
      // Pass the BoulderingRoute's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

  // INSERT
  var r1 = BoulderingRoute(id: 1, boulderingRouteName: '3c');
  var r2 = BoulderingRoute(id: 1, boulderingRouteName: '4c');
  var r3 = BoulderingRoute(id: 1, boulderingRouteName: '4b');
  var r4 = BoulderingRoute(id: 1, boulderingRouteName: '5a');
  await insertBoulderingRoute(r1);
  await insertBoulderingRoute(r2);
  await insertBoulderingRoute(r3);
  await insertBoulderingRoute(r4);
  // Now, use the method above to retrieve all the boulderingRoutes.
  print(await getBoulderingRoutes());

  // UPDATE
  r1 = BoulderingRoute(id: r1.id, boulderingRouteName: '3b');
  await updateBoulderingRoute(r1);
  // Print the updated results.
  print(await getBoulderingRoutes());

  // Delete r1 from the database.
  // await deleteBoulderingRoute(r1.id);

  // Print the list of BoulderingRoutes (empty).
  //print(await getBoulderingRoutes());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Climbing App',
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
          scaffoldBackgroundColor: const Color.fromARGB(255, 91, 114, 156)),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double deviceHeight(BuildContext context) =>
        MediaQuery.of(context).size.height;
    double deviceWidth(BuildContext context) =>
        MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Climbing App',
        color: Color.fromRGBO(206, 129, 56, 1),
        showProfile: true,
      ),
      drawer: const DrawerWidget(),
      body: Column(
        children: [
          SizedBox(
              height: deviceHeight(context) * 0.25,
              width: deviceWidth(context),
              child: Image.asset("images/bouldering_wall.jpg",
                  fit: BoxFit.fitWidth)),
        ],
      ),
    );
  }
}
