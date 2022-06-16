import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mob_foodrecipe_app/models/user.dart';
import 'package:mob_foodrecipe_app/screens/edit_profile.dart';
import 'package:provider/provider.dart';
import 'drawer.dart';
import 'package:mob_foodrecipe_app/screens/my_posts_page.dart';
import 'package:mob_foodrecipe_app/screens/saved_page.dart';

class ProfileFirst extends StatefulWidget {
  ProfileFirst({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ProfileFirstState createState() => _ProfileFirstState();
}

class _ProfileFirstState extends State<ProfileFirst> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    print("UIDDDD" + user.uid);
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.redAccent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, false),
        ),
      ),
      endDrawer: SizedBox(child: Drawer(child: new InkWellDrawer())),
      backgroundColor: Color(0xffF8F8FA),
      body: SingleChildScrollView(
        child: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Container(
              color: Colors.redAccent,
              height: 40 * SizeConfig.heightMultiplier,
              child: Padding(
                padding: EdgeInsets.only(
                    left: 30.0,
                    right: 30.0,
                    top: 10 * SizeConfig.heightMultiplier),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          new StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('Users')
                                  .doc(user.uid)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                var userDocument = snapshot.data;
                                if (userDocument['image_url'] == null) {
                                  return new Container(
                                    height: 11 * SizeConfig.heightMultiplier,
                                    width: 22 * SizeConfig.widthMultiplier,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image:
                                                AssetImage("profileimg.png"))),
                                  );
                                } else {
                                  return new Container(
                                    height: 11 * SizeConfig.heightMultiplier,
                                    width: 22 * SizeConfig.widthMultiplier,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage("images/" +
                                                userDocument['image_url']))),
                                  );
                                }
                              }),
                          SizedBox(
                            width: 5 * SizeConfig.widthMultiplier,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection('Users')
                                      .doc(user.uid)
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return new Text("Loading");
                                    }
                                    var userDocument = snapshot.data;
                                    return new Text(
                                      userDocument["Firstname"] +
                                          " " +
                                          userDocument["Lastname"],
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              3 * SizeConfig.textMultiplier,
                                          fontWeight: FontWeight.bold),
                                    );
                                  }),
                              SizedBox(
                                height: 1 * SizeConfig.heightMultiplier,
                              ),
                            ],
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      ),
                      Container(
                        child: new OutlinedButton(
                          child: new Text(
                            "Edit Profile",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          //color: Colors.white10,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditProfile()),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 35 * SizeConfig.heightMultiplier),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30.0),
                      topLeft: Radius.circular(30.0),
                    )),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 30.0, right: 30.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "My Posts",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 2.2 * SizeConfig.textMultiplier),
                            ),
                            Spacer(),
                            new OutlinedButton(
                              child: new Text(
                                "view all",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              //color: Colors.white10,
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyPostsPage()),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 3 * SizeConfig.heightMultiplier,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

_myAlbumCard(
    String asset1, String asset2, String asset3, String asset4, String more) {
  return Padding(
    padding: const EdgeInsets.only(left: 40.0),
    child: Container(
      height: 37 * SizeConfig.heightMultiplier,
      width: 60 * SizeConfig.widthMultiplier,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Colors.grey, width: 0.2)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset(
                    asset1,
                    height: 27 * SizeConfig.imageSizeMultiplier,
                    width: 27 * SizeConfig.imageSizeMultiplier,
                    fit: BoxFit.cover,
                  ),
                ),
                Spacer(),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset(
                    asset2,
                    height: 27 * SizeConfig.imageSizeMultiplier,
                    width: 27 * SizeConfig.imageSizeMultiplier,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 1 * SizeConfig.heightMultiplier,
            ),
            Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: Image.asset(
                    asset3,
                    height: 27 * SizeConfig.imageSizeMultiplier,
                    width: 27 * SizeConfig.imageSizeMultiplier,
                    fit: BoxFit.cover,
                  ),
                ),
                Spacer(),
                Stack(
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.asset(
                        asset4,
                        height: 27 * SizeConfig.imageSizeMultiplier,
                        width: 27 * SizeConfig.imageSizeMultiplier,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      child: Container(
                        height: 27 * SizeConfig.imageSizeMultiplier,
                        width: 27 * SizeConfig.imageSizeMultiplier,
                        decoration: BoxDecoration(
                            color: Colors.black38,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Center(
                          child: Text(
                            more,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 2.5 * SizeConfig.textMultiplier,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

_favoriteCard(String s) {
  return Padding(
    padding: const EdgeInsets.only(left: 40.0),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(15.0),
      child: Image.asset(
        s,
        height: 20 * SizeConfig.heightMultiplier,
        width: 70 * SizeConfig.widthMultiplier,
        fit: BoxFit.cover,
      ),
    ),
  );
}

class SizeConfig {
  static double _screenWidth;
  static double _screenHeight;
  static double _blockSizeHorizontal = 0;
  static double _blockSizeVertical = 0;

  static double textMultiplier;
  static double imageSizeMultiplier;
  static double heightMultiplier;
  static double widthMultiplier;
  static bool isPortrait = true;
  static bool isMobilePortrait = false;

  void init(BoxConstraints constraints, Orientation orientation) {
    if (orientation == Orientation.portrait) {
      _screenWidth = constraints.maxWidth;
      _screenHeight = constraints.maxHeight;
      isPortrait = true;
      if (_screenWidth < 450) {
        isMobilePortrait = true;
      }
    } else {
      _screenWidth = constraints.maxHeight;
      _screenHeight = constraints.maxWidth;
      isPortrait = false;
      isMobilePortrait = false;
    }

    _blockSizeHorizontal = _screenWidth / 100;
    _blockSizeVertical = _screenHeight / 100;

    textMultiplier = _blockSizeVertical;
    imageSizeMultiplier = _blockSizeHorizontal;
    heightMultiplier = _blockSizeVertical;
    widthMultiplier = _blockSizeHorizontal;

    print(_blockSizeHorizontal);
    print(_blockSizeVertical);
  }
}
