import 'package:flutter/material.dart';
import 'package:mob_foodrecipe_app/screens/recipes.dart';

class Recipe {
  final String image;
  final String title;
  final String subtitle;
  final int likes;

  Recipe({this.image, this.title, this.subtitle, this.likes});
}
