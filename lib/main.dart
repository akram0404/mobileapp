import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mob_foodrecipe_app/models/user.dart';
import 'package:mob_foodrecipe_app/screens/main_page.dart';
import 'package:mob_foodrecipe_app/screens/saved_page.dart';
import 'package:mob_foodrecipe_app/screens/wrapper.dart';
import 'package:mob_foodrecipe_app/services/auth.dart';
import 'screens/complete_profile.dart';
import 'package:get/get.dart';
import 'screens/trend_page.dart';
import 'screens/saved_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    CompleteProfile.tag: (context) => CompleteProfile(),
    TrendPage.tag: (context) => TrendPage(),
  };
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Users>.value(
      value: AuthService().user,
      child: GetMaterialApp(
        title: "Food Studio",
        home: Wrapper(),
        routes: routes,
      ),
    );
  }
}
