import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Order {
  final String id;
  final String fullname;
  final String email;
  final String state;
  final String city;
  final String locality;
  final String productName;
  final String productId;
  final int productQuantity;
  int quantity;
  final int productPrice;
  final String category;
  final String image;
  final String buyerId;
  final String vendorId;
  final bool processing;
  final bool delivered;

  Order({
    required this.id,
    required this.fullname,
    required this.email,
    required this.state,
    required this.city,
    required this.locality,
    required this.productName,
    required this.productId,
    required this.productQuantity,
    required this.quantity,
    required this.productPrice,
    required this.category,
    required this.image,
    required this.buyerId,
    required this.vendorId,
    required this.processing,
    required this.delivered,
  });
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fullname': fullname,
      'email': email,
      'state': state,
      'city': city,
      'locality': locality,
      'productName': productName,
      'productQuantity': productQuantity,
      'quantity': quantity,
      'productPrice': productPrice,
      'productId': productId,
      'category': category,
      'image': image,
      'buyerId': buyerId,
      'vendorId': vendorId,
      'processing': processing,
      'delivered': delivered,
    };
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(Map<String, dynamic> map) {
    return Order(
      id: map['_id']?.toString() ?? '',
      fullname: map['fullname']?.toString() ?? '',
      email: map['email']?.toString() ?? '',
      state: map['state']?.toString() ?? '',
      city: map['city']?.toString() ?? '',
      locality: map['locality']?.toString() ?? '',
      productName: map['productName']?.toString() ?? '',
      productId: map['productId']?.toString() ?? '',
      productQuantity: map['productQuantity'] ?? 0,
      quantity: map['quantity'] ?? 0,
      productPrice: map['productPrice'] ?? 0,
      category: map['category']?.toString() ?? '',
      image: map['image'] is String
          ? map['image']
          : map['image']['0'] ?? map['image'].values.first.toString(),
      buyerId: map['buyerId']?.toString() ?? '',
      vendorId: map['vendorId']?.toString() ?? '',
      processing: map['processing'] ?? false,
      delivered: map['delivered'] ?? false,
    );
  }





}
