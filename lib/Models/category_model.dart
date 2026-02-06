import 'package:flutter/material.dart';

class CategoryModel {
  final String name;
  final String imagePath;
  final String darkImagePath;
  final IconData icon;

  CategoryModel({
    required this.name,
    required this.imagePath,
    required this.icon,
    required this.darkImagePath,
  });
  String getImagePath(bool isDark) => isDark ? darkImagePath : imagePath;

  toJson() {
    return {'name': name, 'imagePath': imagePath, 'icon': icon.codePoint, "darkImagePath": darkImagePath,};
  }

  factory CategoryModel.fromJson(json) {
    int codePoint = json["icon"];
    return CategoryModel(
      darkImagePath: json['darkImagePath'],
      name: json['name'],
      imagePath: json['imagePath'],
      icon: IconData(codePoint),
    );
  }
}
