// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Product {
  final String id;
  final String productName;
  final int productPrice;
  final int productQuantity;
  final String description;
  final String category;
  final String subcategory;
  final String vendorId;
  final String fullname;
  final List<String> images;
  final bool popular;
  final bool recommend;
  final int totalrating;
  final double averagerating;

  Product({
    required this.id,
    required this.productName,
    required this.productPrice,
    required this.productQuantity,
    required this.description,
    required this.category,
    required this.subcategory,
    required this.vendorId,
    required this.fullname,
    required this.images,
    required this.popular,
    required this.recommend,
    required this.totalrating,
    required this.averagerating,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'productName': productName,
      'productPrice': productPrice,
      'quantity': productQuantity,
      'description': description,
      'category': category,
      'subcategory': subcategory,
      'vendorId':vendorId,
      'fullname':fullname,
      'images': images,
      'popular': popular,
      'recommend': recommend,
      'totalrating': totalrating,
      'averagerating': averagerating,
    };
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(Map<String, dynamic> map) {
    return Product(
      id: map['_id'] as String,
      productName: map['productName'] ?? "",
      productPrice: map['productPrice'] ?? 0,
      productQuantity: map['productQuantity'] ?? 0,
      description: map['description'] ?? "",
      category: map['category'] ?? "",
      subcategory: map['subcategory'] ?? "",
      vendorId: map['vendorId'] ?? "",
      fullname: map['fullname'] ?? "",
      images:List<String>.from(map['images']),
      popular: map['popular'] ?? false,
      recommend: map['recommend'] ?? false,
      totalrating: map['totalrating'] ?? 0 ,
      averagerating: (map['averagerating'] is int ? (map['averagerating'] as int).toDouble() : 0.0)
    );
  }

}
