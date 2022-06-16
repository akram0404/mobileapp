import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/animation.dart';
import 'create_account.dart';
import 'login.dart';

class IntroPage extends StatefulWidget {
  _IntroPage createState() => _IntroPage();
}

class _IntroPage extends State<IntroPage> with SingleTickerProviderStateMixin {
  Animation animation;
  Animation animationController;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: Duration(seconds: 5), vsync: this)
          ..repeat(reverse: false);
    animation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.elasticOut,
    ));
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Opacity(
            opacity: 1,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/flowercake.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 30.0),
            child: ClipRRect(
              child: RotationTransition(
                turns: animation,
                child: Image.asset(
                  'images/foodstudiolast.png',
                  width: 150,
                  height: 150,
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(left: 100.0, top: 500.0),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Create();
                  }));
                },
                child: Container(
                  child: Text('Sign up with email',
                      style: TextStyle(
                          fontFamily: 'SourceSansPro',
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  margin: EdgeInsets.all(12.0),
                  padding: EdgeInsets.only(left: 30.0, right: 30.0),
                ),
              ),
              Container(margin: EdgeInsets.only(top: 0.0)),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 100.0),
                    child: Text(
                      'Already have an account?',
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 15.0,
                        color: Colors.grey[800],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Login();
                        }));
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                          fontFamily: 'SourceSansPro',
                          color: Colors.red[600],
                          fontWeight: FontWeight.bold,
                          fontSize: 18.5,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
