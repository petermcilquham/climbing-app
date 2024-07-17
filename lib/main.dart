import 'package:climbing_app/bouldering_route_repository/bouldering_route_repository.dart';
import 'package:flutter/material.dart';
import 'package:climbing_app/bouldering_route_repository/bouldering_route_model.dart';
import 'package:climbing_app/widgets/custom_app_bar.dart';
import 'package:climbing_app/widgets/drawer_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';
import 'package:climbing_app/screens/page_two.dart';
import 'package:climbing_app/screens/page_three.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
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
  final BoulderingRouteRepository _boulderingRouteRepository =
      BoulderingRouteRepository();

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
            child:
                Image.asset("images/bouldering_wall.jpg", fit: BoxFit.fitWidth),
          ),
          ElevatedButton(
            onPressed: () {
              _boulderingRouteRepository.saveBoulderingRoute(
                  officialDifficulty: '6c',
                  boulderingRouteDifficulty: [5.9, 6.7, 6.4],
                  routeID: 'route4');
            },
            child: const Text("Add document to db"),
          ),
          ElevatedButton(
            onPressed: () {
              _boulderingRouteRepository.editBoulderingRoute(
                  boulderingRouteDifficulty: 3.5, routeID: 'route1');
            },
            child: const Text("Add value to difficulty array"),
          ),
        ],
      ),
    );
  }
}
