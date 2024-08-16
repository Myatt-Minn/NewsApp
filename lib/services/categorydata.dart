import 'package:flutter_newsapp_api/models/category_model.dart';

List<CategoriesModel> getCategories() {
  List<CategoriesModel> categories = [];
  categories.add(
      CategoriesModel(name: "business", image: "assets/images/business.jpg"));
  categories.add(CategoriesModel(
      name: "entertainment", image: "assets/images/entertainment.jpg"));
  categories.add(
      CategoriesModel(name: "general", image: "assets/images/general.webp"));
  categories
      .add(CategoriesModel(name: "health", image: "assets/images/health.jpg"));
  categories.add(
      CategoriesModel(name: "science", image: "assets/images/science.png"));
  categories
      .add(CategoriesModel(name: "sports", image: "assets/images/sports.png"));

  return categories;
}
