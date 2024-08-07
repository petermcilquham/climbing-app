import 'package:flutter/material.dart';
import 'package:climbing_app/main.dart';
import 'package:climbing_app/screens/page_two.dart';
import 'package:climbing_app/widgets/custom_app_bar.dart';
import 'package:climbing_app/widgets/drawer_widget.dart';

class PageThree extends StatelessWidget {
  const PageThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppBar(
          title: 'Page Three',
          color: Color.fromRGBO(0, 0, 255, 1),
          showProfile: true,
        ),
        drawer: const DrawerWidget(),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const PageTwo()),
                  );
                },
                child: const Text('Go to page 2'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => MyHomePage()),
                  );
                },
                child: const Text('Go to home page'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Go back'),
              ),
            ],
          ),
        ));
  }
}
