import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/screens/page_three.dart';
import 'package:flutter_application_1/screens/page_two.dart';

class DrawerWidget extends StatelessWidget implements PreferredSizeWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 200,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Drawer Header'),
          ),
          ListTile(
            title: const Text('Go to Home page'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => MyHomePage()),
              );
            },
          ),
          ListTile(
            title: const Text('Go to Page 2'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const PageTwo()),
              );
            },
          ),
          ListTile(
            title: const Text('Go to Page 3'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const PageThree()),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
