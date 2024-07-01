import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgets/custom_app_bar.dart';
import 'package:flutter_application_1/widgets/drawer_widget.dart';

class BoulderRoutesPage extends StatelessWidget {
  const BoulderRoutesPage(
      {super.key, required this.routeName, required this.routeColor});

  final String routeName;
  final Color routeColor;

  double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;

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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    const snackBar = SnackBar(
                      content: Text('You flashed it!'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                  child: const Text("Flashed"),
                ),
                ElevatedButton(
                  onPressed: () {
                    const snackBar = SnackBar(
                      content: Text('You did it!'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
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
