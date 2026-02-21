

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReuseableTextWidget extends StatelessWidget {
  String title;String subtitle;final void Function()? onTap;
  ReuseableTextWidget({super.key,required this.title,required this.subtitle,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,style: GoogleFonts.montserrat(fontSize: 20,fontWeight: FontWeight.bold),),
        InkWell(onTap: onTap,child: Text(subtitle,style: GoogleFonts.montserrat(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.blueAccent),)),
      ],
    );
  }
}
