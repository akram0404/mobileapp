import 'package:flutter/material.dart';
import 'one_recipe.dart';
import 'trend_page.dart';
import 'package:get/get.dart';
import 'package:mob_foodrecipe_app/profile_main.dart';

void main() {
  runApp(Recipes());
}

class FavoriteWidget extends StatefulWidget {
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorited = false;

  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          child: IconButton(
            icon: (_isFavorited
                ? Icon(Icons.favorite)
                : Icon(Icons.favorite_outline)),
            color: Colors.redAccent,
            onPressed: _toggleFavorite,
          ),
        ),
      ],
    );
  }

  void _toggleFavorite() {
    setState(() {
      if (_isFavorited) {
        _isFavorited = false;
      } else {
        _isFavorited = true;
      }
    });
  }
}

Widget recipesData(
    String images, String mainText, String detailText, String rate) {
  return Container(
      child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Container(
            height: 289,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.grey,
              )
            ]),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                      onTap: () {
                        Get.to(OneRecipe());
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          images,
                          width: 350,
                          height: 200,
                          fit: BoxFit.fitWidth,
                        ),
                      )),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        mainText,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            detailText,
                            style: TextStyle(color: Colors.grey, fontSize: 10),
                          ),
                          FavoriteWidget(),
                        ],
                      ),
                      Row(
                        children: [
                          Text(rate,
                              style:
                                  TextStyle(fontSize: 12, color: Colors.grey)),
                          Icon(
                            Icons.star,
                            color: Colors.redAccent,
                            size: 18,
                          ),
                        ],
                      ),
                    ],
                  )
                ]),
          )));
}

class Recipes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: IconButton(
                icon: Icon(
                  Icons.local_fire_department,
                  color: Colors.redAccent,
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return TrendPage();
                  }));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: IconButton(
                icon: Icon(
                  Icons.person,
                  color: Colors.redAccent,
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Profile();
                  }));
                },
              ),
            ),
          ],
          title: Container(
              margin: const EdgeInsets.only(left: 15.0, right: 15.0),
              padding: const EdgeInsets.only(top: 10.0),
              child: TextField(
                decoration: InputDecoration(
                  fillColor: Colors.grey[100],
                  filled: true,
                  hintText: "Search..",
                  suffixIcon: Icon(
                    Icons.search,
                    color: Colors.redAccent,
                    size: 20,
                  ),
                ),
              ))),
      body: SafeArea(
        child: ListView(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Results",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              ),
              Column(
                children: [
                  IconButton(icon: Icon(Icons.filter_list), onPressed: () {}),
                ],
              )
            ],
          ),
          recipesData(
              "images/roastedVegetables.jpg",
              "Roasted Vegetables",
              "A casserole dish of seasonal vegetables that is so easy to prepare.",
              "4.7"),
          recipesData("images/steak.jpg", "Steak",
              "Is there anything better than a well-cooked steak?", "4.2"),
          recipesData(
              "images/sashimi.jpg",
              "Sashimi",
              "Sashimi is made from fresh fish that you slice into delicate",
              "5.0"),
          recipesData(
              "images/shish.jpg",
              "Shish",
              " perfectly tender chicken that’s been marinating in earthy spices.",
              "3.9"),
          recipesData(
              "images/pizza.jpg",
              "Pizza",
              "Making pizza can be a time-consuming process, but the taste is worth.",
              "4.3"),
          recipesData("images/pasta.jpg", "Pasta",
              "These baked pasta recipes are relatively inexpensive.", "4.9"),
          recipesData(
              "images/burger.jpg",
              "Burger",
              "Homemade hamburgers are a delicious treat for lunch or dinner.",
              "5.0"),
          recipesData(
              "images/grilledBarbecue.jpg",
              "Grilled Barbecue",
              "BBQ Chicken cooked on the grill,with your favorite barbecue sauce.",
              "5.0"),
        ]),
      ),
      backgroundColor: Colors.white,
    );
  }
}
