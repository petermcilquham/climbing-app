import 'package:climbing_app/bouldering_route_repository/bouldering_route_repository.dart';
import 'package:climbing_app/logic/enum.dart';
import 'package:flutter/material.dart';
import 'package:climbing_app/widgets/custom_app_bar.dart';
import 'package:climbing_app/widgets/drawer_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp(boulderingRouteRepository: BoulderingRouteRepository()));
}

class MyApp extends StatelessWidget {
  const MyApp({required this.boulderingRouteRepository, super.key});

  final BoulderingRouteRepository boulderingRouteRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => BoulderingRouteRepository(),
      child: MaterialApp(
        title: 'Climbing App',
        theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
            scaffoldBackgroundColor: const Color.fromARGB(255, 91, 114, 156)),
        home: MyHomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final BoulderingRouteRepository _boulderingRouteRepository = BoulderingRouteRepository();

  @override
  Widget build(BuildContext context) {
    double deviceHeight(BuildContext context) => MediaQuery.of(context).size.height;
    double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;

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
            child: Image.asset("images/bouldering_wall.jpg", fit: BoxFit.fitWidth),
          ),
          ElevatedButton(
            onPressed: () {
              _boulderingRouteRepository.saveBoulderingRoute(
                routeID: 'route1',
                routeName: '3',
                gradedDifficulties: boulderingGradesEnum,
              );
            },
            child: const Text("Save boulderingRoute"),
          ),
          ElevatedButton(
            onPressed: () {
              _boulderingRouteRepository.editBoulderingRoute(routeID: 'route5', gradedDifficulty: '6b+');
            },
            child: const Text("Edit boulderingRoute"),
          ),
          ElevatedButton(
            onPressed: () async {
              print(await _boulderingRouteRepository.getBoulderingRouteGradedDifficultiesMapByRouteID('route5'));
            },
            child: const Text("Get boulderingRoute by roueID"),
          ),
        ],
      ),
    );
  }
}
