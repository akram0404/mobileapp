import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mob_foodrecipe_app/screens/one_recipe.dart';
//import 'package:like_button/like_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mob_foodrecipe_app/models/user.dart';
import 'package:provider/provider.dart';

class SavedWidget extends StatefulWidget {
  _SavedWidgetState createState() => _SavedWidgetState();
}

class _SavedWidgetState extends State<SavedWidget> {
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Posts')
            .where('savedBy', arrayContains: user.uid)
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
                  'Saved Posts',
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
                      clipBehavior: Clip.none,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(padding: const EdgeInsets.only(top: 15.0)),
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
