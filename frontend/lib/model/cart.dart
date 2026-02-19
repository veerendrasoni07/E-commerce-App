// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Cart {
  final String productName;
  final int productPrice;
  final String category;
  final String vendorId;
  final List<String> images;
  final String productId;
  final String description;
  final int productQuantity;
  int quantity;
  final String fullname;

  Cart({
    required this.productName,
    required this.productPrice,
    required this.category,
    required this.vendorId,
    required this.images,
    required this.productId,
    required this.description,
    required this.productQuantity,
    required this.quantity,
    required this.fullname
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'productName': productName,
      'productPrice': productPrice,
      'category': category,
      'vendorId': vendorId,
      'images': images,
      'productId': productId,
      'description': description,
      'productQuantity': productQuantity,
      'quantity': quantity,
      'fullname': fullname,
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      productName: map['productName'] as String,
      productPrice: map['productPrice'] as int,
      category: map['category'] as String,
      vendorId: map['vendorId'] as String,
      images: List<String>.from((map['images'])),
      productId: map['productId'] as String,
      description: map['description'] as String,
      productQuantity: map['productQuantity'] as int,
      quantity: map['quantity'] as int,
      fullname: map['fullname'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Cart.fromJson(String source) => Cart.fromMap(json.decode(source) as Map<String, dynamic>);
}
