import 'package:flutter/material.dart';

class InnerBannerWidget extends StatelessWidget {
  final String image;
  InnerBannerWidget({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 170,
      width: MediaQuery.of(context).size.height,
      child: ClipRRect(borderRadius: BorderRadius.circular(20),child: Image.network(image,fit: BoxFit.cover,)),
    );
  }
}
