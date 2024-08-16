import 'package:flutter/material.dart';

class CategoriesModel with ChangeNotifier {
  String? name;
  String? image;

  CategoriesModel({
    this.name,
    this.image,
  });

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
  }
  static List<CategoriesModel> categoriesfromSnapshot(List snapshot) {
    return snapshot.map((data) {
      return CategoriesModel.fromJson(data);
    }).toList();
  }
}
