
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      showSnackBar(context, jsonDecode(response.body)['msg']);
      break;
    case 500:
      showSnackBar(context, jsonDecode(response.body)['error']);
      break;
    default:
      showSnackBar(context, response.body);
  }
}

void dialogProgressIndicator(BuildContext context,String text) {
  showDialog(context: context, builder: (context){
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 15,),
            Text(text,style: GoogleFonts.roboto(fontSize: 18,fontWeight: FontWeight.bold,letterSpacing: 2.5),)
          ],
        ),
      ),
    );
  });
}
