import 'package:flutter/material.dart';

class InnerHeaderWidget extends StatelessWidget {
  final void Function()? onTap;
  final TextEditingController controller;
  const InnerHeaderWidget({super.key,required this.onTap,required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.15,
      child: Stack(
        children: [
          Image.asset(
            "assets/images/header_bg_image.jpg",
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Positioned(
            left: 5,
            bottom: 25,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back,color: Colors.white,),
            ),
          ),
          Positioned(
            left: 50,
            bottom: 20,
            child: SizedBox(
              height: 50,
              width: 250,
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  hintText: "Search Here...",
                  hintStyle: TextStyle(color: Colors.white),
                  prefixIcon: InkWell(onTap: onTap,child: Icon(Icons.search, color: Colors.white)),
                  suffixIcon: Icon(Icons.camera_alt, color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.white, width: 2), // optional: make it thicker on focus
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                style: TextStyle(color: Colors.white), // make typed text white too
              ),
            ),
          ),

          Positioned(
            right: 68,
            bottom: 30,
            child: Material(
              // color: Colors.transparent,
              type: MaterialType.transparency,
              child: InkWell(
                onTap: () {},
                child: Ink(
                  child: Icon(
                    Icons.notifications,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 28,
            bottom: 30,
            child: Material(
              // color: Colors.transparent,
              type: MaterialType.transparency,
              child: InkWell(
                onTap: () {},
                child: Ink(
                  child: Icon(Icons.message, color: Colors.white, size: 30),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
