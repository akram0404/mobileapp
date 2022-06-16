import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mob_foodrecipe_app/widgets/profile_view.dart';
import 'trend_page.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';
import 'package:mob_foodrecipe_app/models/user.dart';

class CompleteProfile extends StatefulWidget {
  static String tag = 'complete-page';
  @override
  _CompleteProfileState createState() => new _CompleteProfileState();
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

class _CompleteProfileState extends State<CompleteProfile> {
  @override
  Widget build(BuildContext context) {
    File _image;
    final picker = ImagePicker();
    final user = Provider.of<Users>(context);
    TextEditingController FirstnameController = new TextEditingController();
    TextEditingController LastnameController = new TextEditingController();
    final welcome = Padding(
      padding: EdgeInsets.all(10.0),
      child: Text(
        'Create your Profile',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 25.0, color: Colors.black),
      ),
    );
    Future _imgFromCamera() async {
      PickedFile imageFile = await picker.getImage(source: ImageSource.camera);

      if (imageFile == null) return;

      File tmpFile = File(imageFile.path);

      final appDir = tmpFile.path;
      final fileName = path.basename(imageFile.path);
      tmpFile = await tmpFile.copy('${imageFile.path}/$fileName');

      print('File path is :${tmpFile.path}');

      setState(() {
        _image = tmpFile;
      });
    }

    Future _imgFromGallery() async {
      final picker = ImagePicker();
      final pickedFile = await picker.getImage(source: ImageSource.gallery);

      setState(() {
        _image = File(pickedFile.path);
      });
    }

    void _showPicker(Context) {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext bc) {
            return SafeArea(
              child: Container(
                child: new Wrap(
                  children: <Widget>[
                    new ListTile(
                        leading: new Icon(Icons.photo_camera),
                        title: new Text('Camera'),
                        onTap: () {
                          _imgFromCamera();
                          Navigator.of(context).pop();
                        }),
                    new ListTile(
                        leading: new Icon(Icons.photo_library),
                        title: new Text('Photo Library'),
                        onTap: () {
                          _imgFromGallery();
                          Navigator.of(context).pop();
                        }),
                  ],
                ),
              ),
            );
          });
    }

    final logo = Center(
      child: GestureDetector(
          onTap: () {
            _showPicker(context);
          },
          child: CircleAvatar(
              radius: 55,
              backgroundColor: Color(0xffFDCF09),
              child: _image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.file(
                        _image,
                        width: 100,
                        height: 100,
                        fit: BoxFit.fitHeight,
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(50)),
                      width: 100,
                      height: 100,
                      child: Icon(Icons.camera_alt, color: Colors.grey[800])))),
    );

    final firstname = TextFormField(
      keyboardType: TextInputType.name,
      autofocus: true,
      decoration: InputDecoration(
        hintText: 'First Name',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      controller: FirstnameController,
    );

    final lastname = TextFormField(
      keyboardType: TextInputType.name,
      autofocus: true,
      decoration: InputDecoration(
        hintText: 'Last Name',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
      controller: LastnameController,
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: ElevatedButton(
        style: raisedButtonStyle,
        onPressed: () {
          Map<String, dynamic> User = new Map<String, dynamic>();
          User["Firstname"] = FirstnameController.text;
          User["Lastname"] = LastnameController.text;
          User["image_url"] = 'profileimg.png';
          FirebaseFirestore.instance
              .collection("Users")
              .doc(user.uid)
              .set(User)
              .whenComplete(() {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileFirst()),
            );
          });
        },
        child: Text('Done', style: TextStyle(color: Colors.white)),
      ),
    );

    final forgotLabel = Text(
      " By signing up you agree to our Terms of Use and Privacy Policy ",
      style: TextStyle(fontSize: 12.0, color: Colors.grey),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            new IconButton(
              icon: new Icon(Icons.arrow_back),
              alignment: Alignment.topLeft,
              onPressed: () => Navigator.of(context).pop(null),
            ),
            welcome,
            SizedBox(height: 8.0),
            logo,
            SizedBox(height: 8.0),
            firstname,
            SizedBox(height: 8.0),
            lastname,
            SizedBox(height: 24.0),
            loginButton,
            forgotLabel
          ],
        ),
      ),
    );
  }
}
