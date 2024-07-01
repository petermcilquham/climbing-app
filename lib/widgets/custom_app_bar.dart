import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/profile.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color color;
  final bool showProfile;

  const CustomAppBar(
      {required this.title, required this.color, this.showProfile = false});

  double deviceHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;
  double deviceWidth(BuildContext context) => MediaQuery.of(context).size.width;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      backgroundColor: color,
      actions: [
        if (showProfile)
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: SizedBox(
              height: deviceHeight(context) * 0.07,
              width: deviceWidth(context) * 0.07,
              child: IconButton(
                padding: const EdgeInsets.all(0),
                icon: Image.asset('images/profile-logo.png'),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Profile()),
                  );
                },
              ),
            ),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
