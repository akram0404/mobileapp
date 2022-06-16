import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:mob_foodrecipe_app/screens/intro_page.dart';
import '../Animation/FadeAnimation.dart';
import 'package:mob_foodrecipe_app/screens/login.dart';
import 'package:mob_foodrecipe_app/screens/intro_page.dart';

class ImageCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Carousel(
            boxFit: BoxFit.cover,
            images: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/soup.jpg'),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30.0, left: 135.0),
                    child: FadeAnimation(
                      4,
                      Text(
                        'Discover outstanding recipes',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'SourceSansPro',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.red[900],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/wafflesandwitch.jpg'),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 80.0, left: 100.0),
                    child: FadeAnimation(
                      4,
                      Text(
                        'Elevate your at-home food experience!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'SourceSansPro',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.red[900],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/frenchtoast.jpg'),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 100.0, left: 220.0),
                    child: FadeAnimation(
                      4,
                      Text(
                        'Share your \n recipes with \n others!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'SourceSansPro',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.red[900],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
            animationCurve: Curves.fastOutSlowIn,
            animationDuration: Duration(milliseconds: 1500),
            showIndicator: false,
          ),
          Container(
            margin: EdgeInsets.only(top: 580.0, left: 90.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return IntroPage();
                }));
              },
              child: Container(
                padding: EdgeInsets.only(
                    left: 50.0, right: 50.0, top: 10.0, bottom: 10.0),
                child: Text('Get Started!',
                    style:
                        TextStyle(fontSize: 20, fontFamily: 'SourceSansPro')),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
          ),
          Row(
            children: [
              Container(
                  margin: EdgeInsets.only(top: 620.0, left: 90.0),
                  child: Text(
                    'Already have an account?',
                    style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 15.0,
                      color: Colors.grey[800],
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              Container(
                margin: EdgeInsets.only(top: 620.0),
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
    );
  }
}
