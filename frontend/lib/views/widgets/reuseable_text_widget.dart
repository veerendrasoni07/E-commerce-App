

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReuseableTextWidget extends StatelessWidget {
  String title;String subtitle;
  ReuseableTextWidget({super.key,required this.title,required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,style: GoogleFonts.montserrat(fontSize: 20,fontWeight: FontWeight.bold),),
          Text(subtitle,style: GoogleFonts.montserrat(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.blueAccent),),
        ],
      ),
    );
  }
}
