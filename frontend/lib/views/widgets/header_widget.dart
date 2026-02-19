import 'package:frontend/views/screens/details/screens/search_product_screen.dart';
import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

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
              left: 50,
              bottom: 20,
              child: SizedBox(
                height: 50,
                width: 250,
                child: TextField(
                  onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>SearchProductScreen())),
                  decoration: InputDecoration(
                    hintText: "Search Here...",
                    hintStyle: TextStyle(color: Colors.white),
                    prefixIcon: Icon(Icons.search, color: Colors.white),
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

              )
          ),

          Positioned(
            right: 68,
              bottom: 30,
              child: Material(
                // color: Colors.transparent,
                type: MaterialType.transparency,
                child: InkWell(
                  onTap: (){},
                  child: Ink(
                    child: Icon(
                      Icons.notifications,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              )
          ),
          Positioned(
            right: 28,
              bottom: 30,
              child: Material(
                // color: Colors.transparent,
                type: MaterialType.transparency,
                child: InkWell(
                  onTap: (){},
                  child: Ink(
                    child: Icon(
                      Icons.message,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              )
          )

        ],
      ),
    );
  }
}

class HeaderWidget2 extends StatelessWidget {
  const HeaderWidget2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.15,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Colors.blue.shade900,
          Colors.blue.shade500,
        ]),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Row(
        children: [
          TextField(
            onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (_)=>SearchProductScreen())),
            decoration: InputDecoration(
              hintText: "Search Here...",
              hintStyle: TextStyle(color: Colors.black),
              prefixIcon: Icon(Icons.search, color: Colors.black),
              suffixIcon: Icon(Icons.camera_alt, color: Colors.black),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.black),
              )
            )
          ),
          SizedBox(width: 10,),
          Icon(Icons.notifications, color: Colors.black, size: 30,),
          SizedBox(width: 10,),
          Icon(Icons.support_agent_rounded, color: Colors.black, size: 30,),
        ],
      )
    );
  }
}


