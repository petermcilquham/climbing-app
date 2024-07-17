import 'package:climbing_app/bouldering_route_repository/bouldering_route_repository.dart';
import 'package:climbing_app/widgets/number_picker_widget.dart';
import 'package:climbing_app/widgets/wheel_slider.dart';
import 'package:flutter/material.dart';
import 'package:climbing_app/widgets/custom_app_bar.dart';
import 'package:climbing_app/widgets/drawer_widget.dart';

class BoulderRoutesPage extends StatelessWidget {
  BoulderRoutesPage(
      {super.key,
      required this.routeName,
      required this.routeDifficulties,
      required this.routeAvgDifficulty,
      required this.routeColor});

  final String routeName;
  final List<dynamic> routeDifficulties;
  final double routeAvgDifficulty;
  final Color routeColor;

  double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;

  final BoulderingRouteRepository _boulderingRouteRepository =
      BoulderingRouteRepository();

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Rate the route:'),
          content: const NumberPickerWidget(),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('OK'),
              onPressed: () {
                _boulderingRouteRepository.editBoulderingRoute(
                    boulderingRouteDifficulty: 3.1, routeID: 'route1');
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('No Thanks'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: routeName,
        color: routeColor,
        showProfile: false,
      ),
      drawer: const DrawerWidget(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Text('Route average difficulty: $routeAvgDifficulty'),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _dialogBuilder(context),
                  child: const Text("Flashed"),
                ),
                ElevatedButton(
                  onPressed: () => _dialogBuilder(context),
                  child: const Text("Done"),
                )
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("Rate the route:")],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("Placeholder for difficulty rating here")],
            ),
          ),
          const Expanded(
            child: SizedBox(),
          ),
          Container(
            width: deviceWidth(context) * 1,
            height: 40,
            color: const Color.fromRGBO(0, 0, 0, 1),
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Color.fromRGBO(255, 255, 255, 1),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
