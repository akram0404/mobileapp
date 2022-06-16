import 'package:flutter/material.dart';
import 'package:mob_foodrecipe_app/screens/detail_page.dart';
import 'package:get/get.dart';
import 'package:mob_foodrecipe_app/services/auth.dart';

Widget logoutWidgets() {
  final AuthService _auth = AuthService();

  return Column(
    children: [
      Container(
        padding: EdgeInsets.only(left: 90.0, top: 90.0),
        child: Icon(
          Icons.logout,
          size: 120.0,
          color: Colors.red[900],
        ),
      ),
      Container(
        padding: EdgeInsets.only(left: 60.0, top: 20.0),
        child: Text(
          'You are about to sign out. \n are you sure?',
          style: TextStyle(
            fontFamily: 'SourceSansPro',
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
            color: Colors.red[900],
          ),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        padding: EdgeInsets.only(top: 40.0, left: 55.0),
        child: ElevatedButton(
          onPressed: () async {
            //Get.to(Detail());

            await _auth.signout();
          },
          child: Container(
            child: Text('Logout',
                style: TextStyle(
                    fontFamily: 'SourceSansPro',
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            margin: EdgeInsets.all(12.0),
            padding: EdgeInsets.only(left: 30.0, right: 30.0),
          ),
        ),
      ),
      Container(
        padding: EdgeInsets.only(top: 15.0, left: 55.0),
        child: ElevatedButton(
          onPressed: () {
            Get.back();
          },
          child: Container(
            child: Text('Cancel',
                style: TextStyle(
                    fontFamily: 'SourceSansPro',
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            margin: EdgeInsets.all(12.0),
            padding: EdgeInsets.only(left: 30.0, right: 30.0),
          ),
        ),
      ),
    ],
  );
}
