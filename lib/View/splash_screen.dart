import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news_app/View/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({ Key? key }) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
    void initState() {
      // TODO: implement initState
      super.initState();

      Timer(Duration(seconds: 2),(){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
      });
    }
  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.sizeOf(context).height*1;
    final width=MediaQuery.sizeOf(context).width*1;
    return Scaffold(
      body: Container(
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network('https://img.freepik.com/free-vector/news-concept-landing-page_52683-19508.jpg?w=740&t=st=1708012136~exp=1708012736~hmac=c0f3c918f4077b4f651f986e7d9697280c825e57bc69b44b68a85a6bf7c6f0c9',
            fit: BoxFit.cover,
            height: height*.5,
            width: width*.9,),
            SizedBox(
              height: height*0.04,
            ),
            Text("Top HeadLine",style: GoogleFonts.anton(letterSpacing: .6,color: Colors.grey.shade700),),
            SizedBox(
              height: height*0.04,
            ),
            SpinKitHourGlass(
              color: Colors.blue,
              size: 40,
            )
          
          ],
        ),
      ),
    );
  }
}