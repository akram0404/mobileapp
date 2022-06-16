import 'package:flutter/material.dart';
import 'package:mob_foodrecipe_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mob_foodrecipe_app/screens/forget_password.dart';
import 'constants.dart';
import 'package:email_validator/email_validator.dart';
import '../Animation/FadeAnimation.dart';
import 'package:mob_foodrecipe_app/screens/create_account.dart';
import 'profile_main.dart';
import 'package:get/get.dart';

class Login extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthService _auth = AuthService();
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool _obscureText = true;
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

  Widget _buildLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 70),
          child: Text(
            'Log in',
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height / 25,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildForm() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Form(
        key: _formkey,
        child: Column(
          children: [
            TextFormField(
              autofocus: true,
              controller: _email,
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
                  prefixIcon: Icon(
                    Icons.email,
                    color: mainColor,
                  ),
                  labelText: 'E-mail'),
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
                prefixIcon: Icon(
                  Icons.lock,
                  color: mainColor,
                ),
                labelText: 'Password',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForgetPasswordButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return ForgetPass();
            }));
          },
          child: Text("Forgot Password?"),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FadeAnimation(
            2,
            Container(
              height: 1.4 * (MediaQuery.of(context).size.height / 20),
              width: 5 * (MediaQuery.of(context).size.width / 10),
              margin: EdgeInsets.only(bottom: 20),
              child: ElevatedButton(
                onPressed: () async {
                  if (_formkey.currentState.validate()) {
                    dynamic result = await _auth.signInWithEmailAndPassword(
                        _email.text, _password.text);
                    if (result == null) {
                      return 'error occurred';
                    } else {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Profile();
                      }));
                    }
                  } else {
                    return "unsuccessful";
                  }
                },
                child: Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 1.5,
                    fontSize: MediaQuery.of(context).size.height / 40,
                  ),
                ),
              ),
            ))
      ],
    );
  }

  Widget _buildOrRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 20),
          child: Text(
            '- OR -',
            style: TextStyle(
              fontWeight: FontWeight.w400,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildSocialBtnRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
            onTap: () {},
            child: FadeAnimation(
              2,
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: mainColor2,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 2),
                        blurRadius: 6.0)
                  ],
                ),
                child: Icon(
                  FontAwesomeIcons.google,
                  color: Colors.white,
                ),
              ),
            ))
      ],
    );
  }

  Widget _buildContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[],
                ),
                _buildForm(),
                _buildForgetPasswordButton(),
                _buildLoginButton(),
                _buildOrRow(),
                _buildSocialBtnRow(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpBtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 0.0, top: 20),
          child: ElevatedButton(
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Dont have an account? ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.height / 40,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: 'Sign Up',
                    style: TextStyle(
                      color: mainColor2,
                      fontSize: MediaQuery.of(context).size.height / 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Create();
              }));
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xFFFF9E80),
        body: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.7,
              width: MediaQuery.of(context).size.width,
              child: Container(
                decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: const Radius.circular(70),
                    bottomRight: const Radius.circular(70),
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildLogo(),
                _buildContainer(),
                _buildSignUpBtn(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
