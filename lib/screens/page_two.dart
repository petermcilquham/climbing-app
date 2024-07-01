import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/boulder_routes_page.dart';
import 'package:flutter_application_1/widgets/custom_app_bar.dart';
import 'package:flutter_application_1/widgets/drawer_widget.dart';

class PageTwo extends StatelessWidget {
  const PageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    var items = List<String>.generate(10, (i) => 'Route $i');

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Page Two',
        color: Color.fromRGBO(255, 0, 0, 1),
        showProfile: true,
      ),
      drawer: const DrawerWidget(),
      body: Center(
        child: ListView.builder(
          itemCount: items.length,
          prototypeItem: ListTile(
            title: Text(items.first),
          ),
          itemBuilder: (context, index) {
            return ListTile(
              title: Center(
                child: Text(items[index]),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => BoulderRoutesPage(
                          routeName: items[index],
                          routeColor: const Color.fromRGBO(255, 255, 255, 1))),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
