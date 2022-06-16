import 'package:flutter/material.dart';
import 'package:mob_foodrecipe_app/models/user.dart';
import 'package:mob_foodrecipe_app/screens/add_new_recipe.dart';
import 'package:mob_foodrecipe_app/screens/logout.dart';
import 'package:mob_foodrecipe_app/screens/my_posts_page.dart';
import 'package:mob_foodrecipe_app/screens/saved_page.dart';
import 'package:mob_foodrecipe_app/screens/trend_page.dart';
import 'package:mob_foodrecipe_app/screens/reports_page.dart';

import 'package:provider/provider.dart';

import 'profile_view.dart';

class InkWellDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    if (user.uid != "qxhv60uRBTX2m8EF0SXsFH6utDs2") {
      return Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: <Color>[Colors.redAccent, Colors.red])),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Material(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50.0)),
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset('images/profileimg.png',
                              height: 90, width: 90),
                        ),
                      ),
                    ],
                  ),
                )),
            CustomListTile(
                Icons.person,
                'Profile',
                () => {
                      Navigator.pop(context),
                      Navigator.push(
                          context,
                          // ignore: always_specify_types
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new ProfileFirst()))
                    }),
            CustomListTile(
                Icons.camera,
                'Add new Post',
                () => {
                      Navigator.pop(context),
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new AddNewRecipe()))
                    }),
            CustomListTile(
                Icons.trending_up,
                'Trending',
                () => {
                      Navigator.pop(context),
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new TrendPage()))
                    }),
            CustomListTile(
                Icons.list,
                'My Posts',
                () => {
                      Navigator.pop(context),
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new MyPostsPage()))
                    }),
            CustomListTile(
                Icons.save,
                'Saved Posts',
                () => {
                      Navigator.pop(context),
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new SavedPage()))
                    }),
            CustomListTile(
                Icons.lock,
                'Log Out',
                () => {
                      Navigator.pop(context),
                      Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new Logout()))
                    }),
          ],
        ),
      );
    } else {
      return Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: <Color>[Colors.redAccent, Colors.red])),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Material(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50.0)),
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset('images/profileimg.png',
                              height: 90, width: 90),
                        ),
                      ),
                    ],
                  ),
                )),
            CustomListTile(
                Icons.pages,
                'Reports',
                () => {
                      Navigator.pop(context),
                      Navigator.push(
                          context,
                          // ignore: always_specify_types
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new ReportPage()))
                    }),
          ],
        ),
      );
    }
  }
}

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function onTap;

  CustomListTile(this.icon, this.text, this.onTap);
  @override
  Widget build(BuildContext context) {
    //ToDO
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey.shade400))),
        child: InkWell(
            splashColor: Colors.orangeAccent,
            onTap: onTap,
            child: Container(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(icon),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                        ),
                        Text(
                          text,
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    Icon(Icons.arrow_right)
                  ],
                ))),
      ),
    );
  }
}
