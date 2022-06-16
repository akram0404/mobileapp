import 'package:flutter/material.dart';
import 'package:mob_foodrecipe_app/screens/reports_page.dart';
import 'trend_page.dart';
import 'package:mob_foodrecipe_app/widgets/view_recipes.dart';
import 'package:mob_foodrecipe_app/widgets/profile_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mob_foodrecipe_app/models/recipe.dart';

class MainPage extends StatefulWidget {
  _MainPage createState() => _MainPage();
}

class _MainPage extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 40,
          backgroundColor: Colors.white,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.local_fire_department,
                color: Colors.deepOrangeAccent[400],
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return TrendPage();
                }));
              },
            ),
          ],
          title: Container(
              margin: const EdgeInsets.only(left: 15.0, right: 15.0),
              padding: const EdgeInsets.only(top: 5.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search..",
                  fillColor: Colors.grey[100],
                  filled: true,
                  suffixIcon: Icon(
                    Icons.search,
                    color: Colors.redAccent,
                    size: 20,
                  ),
                ),
              ))),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SaveWidget(),
      ),
    );
  }
}
