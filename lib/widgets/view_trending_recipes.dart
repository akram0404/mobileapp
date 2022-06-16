import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mob_foodrecipe_app/screens/one_recipe.dart';
//import 'package:like_button/like_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mob_foodrecipe_app/models/user.dart';
import 'package:provider/provider.dart';

class TrendWidget extends StatefulWidget {
  _TrendWidgetState createState() => _TrendWidgetState();
}

class _TrendWidgetState extends State<TrendWidget> {
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Posts')
            .orderBy('likes', descending: true)
            .limit(30)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 0.0, top: 15.0),
                child: Text(
                  'Trending Posts',
                  style: TextStyle(
                    fontFamily: 'SourceSansPro',
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.red[900],
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.only(top: 20.0),
                  children: snapshot.data.docs.map((document) {
                    bool _isSaved;
                    bool isLiked;
                    String likedby = document["description"];
                    List savedBy = document["savedBy"];
                    List reportedBy = document["reports.reportedBy"];
                    List reasons = document["reports.reasons"];

                    if (savedBy.contains(user.uid)) {
                      _isSaved = true;
                    } else {
                      _isSaved = false;
                    }

                    if (likedby.contains(user.uid)) {
                      isLiked = true;
                    } else {
                      isLiked = false;
                    }

                    showAlertDialog(BuildContext context) {
                      Widget cancelButton = ElevatedButton(
                        child: Text(
                          "Cancel",
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      );
                      Widget spamButton = ElevatedButton(
                        child: Text(
                          "Spam",
                          style: TextStyle(color: Colors.redAccent),
                        ),
                        onPressed: () {
                          if (reportedBy.contains(user.uid)) {
                            Navigator.pop(context);
                          } else if (reasons.contains("Spam")) {
                            FirebaseFirestore.instance
                                .collection('Posts')
                                .doc(document.id)
                                .update({
                              "reports.reportedBy":
                                  FieldValue.arrayUnion([user.uid])
                            });
                            Navigator.pop(context);
                          } else {
                            FirebaseFirestore.instance
                                .collection('Posts')
                                .doc(document.id)
                                .update({
                              "reports.reasons":
                                  FieldValue.arrayUnion(["Spam"]),
                              "reports.reportedBy":
                                  FieldValue.arrayUnion([user.uid])
                            });
                            Navigator.pop(context);
                          }
                        },
                      );
                      Widget inpButton = ElevatedButton(
                        child: Text(
                          "Inappropriate",
                          style: TextStyle(color: Colors.redAccent),
                        ),
                        onPressed: () {
                          if (reportedBy.contains(user.uid)) {
                            Navigator.pop(context);
                          } else if (reasons.contains("Inappropriate")) {
                            FirebaseFirestore.instance
                                .collection('Posts')
                                .doc(document.id)
                                .update({
                              "reports.reportedBy":
                                  FieldValue.arrayUnion([user.uid])
                            });
                            Navigator.pop(context);
                          } else {
                            FirebaseFirestore.instance
                                .collection('Posts')
                                .doc(document.id)
                                .update({
                              "reports.reasons":
                                  FieldValue.arrayUnion(["Inappropriate"]),
                              "reports.reportedBy":
                                  FieldValue.arrayUnion([user.uid])
                            });
                            Navigator.pop(context);
                          }
                        },
                      );
                      AlertDialog alert = AlertDialog(
                        title: Text(
                          "Report",
                          style: TextStyle(
                            color: Colors.redAccent,
                          ),
                        ),
                        content: Text("why are you reporting this post?"),
                        actions: [
                          cancelButton,
                          spamButton,
                          inpButton,
                        ],
                      );

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return alert;
                        },
                      );
                    }

                    void _toggleSaved() {
                      if (_isSaved == true) {
                        FirebaseFirestore.instance
                            .collection('Posts')
                            .doc(document.id)
                            .update({
                          "savedBy": FieldValue.arrayRemove([user.uid])
                        });
                      } else {
                        FirebaseFirestore.instance
                            .collection('Posts')
                            .doc(document.id)
                            .update({
                          "savedBy": FieldValue.arrayUnion([user.uid])
                        });
                      }
                      _isSaved = !_isSaved;
                    }

                    Future<bool> changedata() async {
                      if (isLiked == true) {
                        FirebaseFirestore.instance
                            .collection('Posts')
                            .doc(document.id)
                            .update({
                          "likes": FieldValue.increment(-1),
                          "likedBy": FieldValue.arrayRemove([user.uid])
                        });
                      } else {
                        FirebaseFirestore.instance
                            .collection('Posts')
                            .doc(document.id)
                            .update({
                          "likes": FieldValue.increment(1),
                          "likedBy": FieldValue.arrayUnion([user.uid])
                        });
                      }
                      isLiked = !isLiked;

                      return Future.value(isLiked);
                    }

                    return Stack(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 310.0),
                              child: PopupMenuButton(
                                icon: Icon(Icons.more_horiz),
                                onSelected: (value) {
                                  if (value == 1) {
                                    showAlertDialog(context);
                                  } else {
                                    return;
                                  }
                                },
                                itemBuilder: (_) => [
                                  PopupMenuItem(
                                      value: 1, child: Text("Report")),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(OneRecipe());
                              },
                              child: Container(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.asset(
                                    'images/burger.jpg',
                                    width: 350,
                                    height: 200,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 30.0),
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(bottom: 5.0),
                                    child: Text(
                                      document["title"],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    document["description"],
                                    style: TextStyle(
                                      color: Colors.grey[500],
                                      fontSize: 15,
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(0.0),
                                        margin: const EdgeInsets.all(0.0),
                                      ),
                                      /*
                                      LikeButton(
                                        likeCount: document["likes"],
                                        countBuilder: (int count, bool isLiked,
                                            String text) {
                                          var color = isLiked
                                              ? Colors.redAccent
                                              : Colors.blueGrey;
                                          Widget result;
                                          if (count == 0) {
                                            result = Text(
                                              "love",
                                              style: TextStyle(color: color),
                                            );
                                          } else {
                                            result = Text(
                                              text,
                                              style: TextStyle(color: color),
                                            );
                                          }

                                          return result;
                                        },
                                        onTap: (bool isLiked) {
                                          return changedata();
                                        },
                                        likeBuilder: (bool isLiked) {
                                          if (likedby.contains(user.uid)) {
                                            isLiked = true;
                                          } else {
                                            isLiked = false;
                                          }
                                          return Icon(
                                            Icons.favorite,
                                            size: 25,
                                            color: isLiked
                                                ? Colors.redAccent
                                                : Colors.blueGrey[200],
                                          );
                                        },
                                      ),*/
                                      Container(
                                        margin:
                                            const EdgeInsets.only(right: 250.0),
                                      ),
                                      IconButton(
                                          icon: (_isSaved
                                              ? Icon(Icons.turned_in)
                                              : Icon(Icons
                                                  .turned_in_not_outlined)),
                                          color: Colors.redAccent,
                                          onPressed: _toggleSaved),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        });
  }
}
