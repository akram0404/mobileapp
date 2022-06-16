import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mob_foodrecipe_app/screens/main_page.dart';
import 'package:mob_foodrecipe_app/profile_main.dart';
import 'package:mob_foodrecipe_app/widgets/profile_view.dart';
import 'main_page.dart';
import 'package:mob_foodrecipe_app/widgets/view_saved_recipes.dart';

class SavedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 40,
          backgroundColor: Colors.white,
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.person,
                color: Colors.redAccent,
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ProfileFirst();
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
        child: SavedWidget(),
      ),
    );
  }
}
