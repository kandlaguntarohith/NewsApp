import 'package:flutter/foundation.dart';

class Category {
  final String name;
  final String imageAdd;

  const Category({@required this.name, @required this.imageAdd});
}

const List<Category> categories = [
  const Category(name: 'general', imageAdd: 'assets/images/general.jpg'),
  const Category(name: 'business', imageAdd: 'assets/images/business.jpg'),
  const Category(
      name: 'entertainment', imageAdd: 'assets/images/entertainment.jpg'),
  const Category(name: 'health', imageAdd: 'assets/images/health.jpg'),
  const Category(name: 'science', imageAdd: 'assets/images/science.jpg'),
  const Category(name: 'sports', imageAdd: 'assets/images/sports.jpg'),
  const Category(name: 'technology', imageAdd: 'assets/images/technology.jpg'),
];
