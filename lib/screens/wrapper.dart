import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:mob_foodrecipe_app/models/user.dart';
import 'package:mob_foodrecipe_app/screens/detail_page.dart';
import 'package:mob_foodrecipe_app/screens/intro_page.dart';
import 'package:mob_foodrecipe_app/screens/main_page.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    if (user == null) {
      return Detail();
    } else {
      return MainPage();
    }
  }
}
