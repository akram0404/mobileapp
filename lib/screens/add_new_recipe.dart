import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mob_foodrecipe_app/screens/one_recipe.dart';
import 'package:mob_foodrecipe_app/widgets/view_recipes.dart';
import 'package:mob_foodrecipe_app/profile_main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:mob_foodrecipe_app/models/user.dart';

class NewRecipe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);

    return Scaffold(body: AddNewRecipe());
  }
}

class AddNewRecipe extends StatefulWidget {
  @override
  _AddNewRecipeState createState() => _AddNewRecipeState();
}

class _AddNewRecipeState extends State<AddNewRecipe> {
  File _file;
  String imgurl;
  Future pickerCamera() async {
    final myfile = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      _file = File(myfile.path);
    });
  }

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  void validate() {
    if (formkey.currentState.validate()) {
      print('Validated');
    }
    print('Not validated');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.redAccent,
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Profile();
              }));
            },
          )),
      body: insertRecipe(),
    );
  }

  Widget insertRecipe() {
    TextEditingController recipeName = new TextEditingController();
    TextEditingController ingredients = new TextEditingController();
    TextEditingController steps = new TextEditingController();

    addData() async {
      var image = FirebaseStorage.instance.ref().child(_file.path);
      var uploadImage = image.putFile(_file);
      imgurl = await (await uploadImage).ref.getDownloadURL();
      print("image url: " + imgurl);
      Map<String, dynamic> demoData = {
        "image": imgurl.toString(),
        "title": recipeName.text,
        "ingredients": ingredients.text,
        "description": steps.text,
        "likes": 0
      };
      CollectionReference collectionReference =
          FirebaseFirestore.instance.collection('Posts');
      collectionReference.add(demoData);
    }

    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      onPrimary: Colors.black87,
      primary: Colors.grey[300],
      minimumSize: Size(88, 36),
      padding: EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2)),
      ),
    );
    return Container(
      padding: EdgeInsets.only(left: 16, top: 25, right: 16),
      child: GestureDetector(
          child: ListView(children: [
        Text(
          "Add Your Favorite Recipe.",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 15,
        ),
        Center(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                child: _file == null
                    ? text()
                    : Image.file((_file), fit: BoxFit.fill),
                width: 300,
                height: 220,
                decoration: BoxDecoration(
                  border: Border.all(width: 4, color: Colors.white),
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 2,
                      blurRadius: 10,
                      color: Colors.grey[350],
                    )
                  ],
                  shape: BoxShape.rectangle,
                ),
              ),
              Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(
                        width: 4,
                        color: Colors.white,
                      ),
                      color: Colors.redAccent,
                    ),
                    child: IconButton(
                        icon: Icon(Icons.image),
                        color: Colors.white,
                        onPressed: () {
                          pickerCamera();
                        }),
                  )),
            ],
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey, width: 0.2),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 7)
                ]),
            child: Padding(
              padding: const EdgeInsets.only(left: 14),
              child: TextFormField(
                controller: recipeName,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Recipe Name",
                    hintStyle: TextStyle(
                        color: Colors.grey,
                        fontFamily: "Times New Roman",
                        fontSize: 18)),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey, width: 0.2),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 7)
                ]),
            child: Padding(
              padding: const EdgeInsets.only(left: 14),
              child: TextFormField(
                controller: ingredients,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Ingredients",
                    hintStyle: TextStyle(
                        color: Colors.grey,
                        fontFamily: "Times New Roman",
                        fontSize: 18)),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey, width: 0.2),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 7)
                ]),
            child: Padding(
              padding: const EdgeInsets.only(left: 14),
              child: TextFormField(
                controller: steps,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Steps",
                    hintStyle: TextStyle(
                        color: Colors.grey,
                        fontFamily: "Times New Roman",
                        fontSize: 18)),
              ),
            ),
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              width: 50,
              height: 40,
              // ignore: deprecated_member_use
              child: ElevatedButton(
                  style: raisedButtonStyle,
                  onPressed: () {
                    addData();
                  },
                  child: Text(
                    "ADD",
                    style: TextStyle(
                        fontSize: 14, letterSpacing: 2.2, color: Colors.white),
                  )),
            ))
      ])),
    );
  }
}
