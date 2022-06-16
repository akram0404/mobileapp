import 'package:flutter/material.dart';
import 'package:mob_foodrecipe_app/widgets/profile_view.dart';

void main() {
  runApp(Profile());
}

class Profile extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'ProfileScreen ',
              home: ProfileFirst(),
            );
          },
        );
      },
    );
  }
}
