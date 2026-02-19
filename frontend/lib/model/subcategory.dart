import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class SubCategory {
  String categoryId;
  String categoryName;
  String image;
  String subcategoryName;
  SubCategory({
    required this.categoryId,
    required this.categoryName,
    required this.image,
    required this.subcategoryName,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'categoryId': categoryId,
      'categoryName': categoryName,
      'image': image,
      'subcategoryName': subcategoryName,
    };
  }

  factory SubCategory.fromJson(Map<String, dynamic> map) {
    return SubCategory(
      categoryId: map['categoryId'] as String,
      categoryName: map['categoryName'] as String,
      image: map['image'] as String,
      subcategoryName: map['subcategoryName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

 
}
