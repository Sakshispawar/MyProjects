// To parse this JSON data, do
//
//     final dmartCategoryModel = dmartCategoryModelFromJson(jsonString);

import 'dart:convert';

DmartCategoryModel dmartCategoryModelFromJson(String str) => DmartCategoryModel.fromJson(json.decode(str));

class DmartCategoryModel {
  List<Category> categories;

  DmartCategoryModel({
    required this.categories,
  });

  factory DmartCategoryModel.fromJson(Map<String, dynamic> json) => DmartCategoryModel(
    categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
  );


}

class Category {
  String name;
  List<String> subcategory;

  Category({
    required this.name,
    required this.subcategory,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    name: json["name"],
    subcategory: List<String>.from(json["subcategory"].map((x) => x)),
  );


}
