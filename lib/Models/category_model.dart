import 'package:flutter/material.dart';

class CategoryModel {
  final String name;
  final String imagePath;
  final IconData icon;

  CategoryModel({
    required this.name,
    required this.imagePath,
    required this.icon,
  });

  toJson() {
    return {'name': name, 'imagePath': imagePath, 'icon': icon.codePoint};
  }

  factory CategoryModel.fromJson(json) {
    int codePoint = json["icon"];
    return CategoryModel(
      name: json['name'],
      imagePath: json['imagePath'],
      icon: IconData(codePoint),
    );
  }
}
