import 'package:flutter/material.dart';

class InnerSubCategoryTile extends StatelessWidget {
  final String image;
  final String title;
  const InnerSubCategoryTile({super.key, required this.image,required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(color: Colors.grey.shade200,borderRadius: BorderRadius.circular(20)),
          child: ClipRRect(borderRadius: BorderRadius.circular(20),child: Image.network(image, fit: BoxFit.cover)),
        ),
        SizedBox(height: 8),
        SizedBox(
          width: 170,
          child: Text(title,textAlign: TextAlign.center, overflow:TextOverflow.ellipsis,style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
