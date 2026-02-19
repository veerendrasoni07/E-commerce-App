import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Review {
  final String id;
  final String buyerId;
  final String email;
  final String fullname;
  final String productId;
  final double rating;
  final String review;
  Review({
    required this.id,
    required this.buyerId,
    required this.email,
    required this.fullname,
    required this.productId,
    required this.rating,
    required this.review,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'buyerId': buyerId,
      'email': email,
      'fullname': fullname,
      'productId': productId,
      'rating': rating,
      'review': review,
    };
  }

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
      id: map['_id'] as String,
      buyerId: map['buyerId'] as String,
      email: map['email'] as String,
      fullname: map['fullname'] as String,
      productId: map['productId'] as String,
      rating: (map['rating'] is int) ? (map['rating'] as int).toDouble() : double.parse(map['rating'].toString()),
      review: map['review'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Review.fromJson(String source) => Review.fromMap(json.decode(source) as Map<String, dynamic>);
}
