import 'package:flutter/material.dart';
import 'package:mob_foodrecipe_app/services/auth.dart';
import 'complete_profile.dart';
import 'package:email_validator/email_validator.dart';
import '../Animation/FadeAnimation.dart';
import 'package:get/get.dart';

class Create extends StatefulWidget {
  _Create createState() => _Create();
}

class _Create extends State<Create> {
  // This widget is the root of your application.
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmpassword = TextEditingController();
  bool _obscureText = true;
  bool _obscureTextConfirm = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;

      if (_obscureText) {
        _obscureText = true;
      } else {
        _obscureText = false;
      }
    });
  }

  void _toggleConfirm() {
    setState(() {
      _obscureTextConfirm = !_obscureTextConfirm;
      if (_obscureTextConfirm) {
        _obscureTextConfirm = true;
      } else {
        _obscureTextConfirm = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 330.0, top: 20.0),
                  child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10.0, top: 45.0),
                ),
                Text(
                  'Create your account',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                  ),
                ),
                Padding(padding: const EdgeInsets.only(top: 20.0)),
                CreateAccount(_formKey),
                Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  width: 200.0,
                  height: 50.0,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        // print(_email);
                        // print(_password.text);

                        dynamic result =
                            await _auth.register(_email.text, _password.text);
                        if (result == null) {
                          return 'error occurred';
                        } else {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return CompleteProfile();
                          }));
                        }
                      } else {
                        return "unsuccessful";
                      }
                    },
                    child: Container(
                      child: Text('Next', style: TextStyle(fontSize: 20)),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    'By signing up you agree to our Terms of Use \nand Privacy Policy',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Column CreateAccount(key) {
    return Column(
      children: [
        FadeAnimation(
          3,
          Container(
            margin: const EdgeInsets.only(left: 50.0, right: 50.0, top: 15.0),
            padding: const EdgeInsets.only(top: 10.0),
            child: Form(
              key: key,
              child: Column(
                children: [
                  TextFormField(
                    controller: _email,
                    autofocus: true,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "This Field is Empty";
                      } else if (!EmailValidator.validate(value)) {
                        return "The email you inserted is not valid";
                      }
                      return null;
                    },
                    onSaved: (String email) {
                      _email.text = email;
                    },
                    decoration: InputDecoration(
                      hintText: "Email",
                      fillColor: Colors.grey[50],
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 15.0),
                  ),
                  TextFormField(
                    autofocus: true,
                    controller: _password,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "This Field is Empty";
                      } else if (value.length < 6) {
                        return "your password should have at least 6 characters";
                      }
                      return null;
                    },
                    onSaved: (String password) {
                      _password.text = password;
                    },
                    decoration: InputDecoration(
                      hintText: "Password",
                      suffixIcon: IconButton(
                        icon: _obscureText
                            ? Icon(Icons.visibility)
                            : Icon(Icons.visibility_off),
                        onPressed: _toggle,
                      ),
                      fillColor: Colors.grey[50],
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                    obscureText: _obscureText,
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 15.0),
                  ),
                  TextFormField(
                    autofocus: true,
                    controller: _confirmpassword,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "This Field is Empty";
                      } else if (value != _password.text) {
                        return "password does not match";
                      }
                      return null;
                    },
                    onSaved: (String confirmpassword) {
                      _confirmpassword.text = confirmpassword;
                    },
                    decoration: InputDecoration(
                      hintText: "Confirm Password",
                      suffixIcon: IconButton(
                        icon: _obscureTextConfirm
                            ? Icon(Icons.visibility)
                            : Icon(Icons.visibility_off),
                        onPressed: _toggleConfirm,
                      ),
                      fillColor: Colors.grey[50],
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                    obscureText: _obscureTextConfirm,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
