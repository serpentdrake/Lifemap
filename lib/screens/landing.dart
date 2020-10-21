import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LandingPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            'Assets/background2.png',
            fit: BoxFit.cover,
          ),
          ListView(
            children: <Widget>[
              SafeArea(
                top: true,
                child:  Center(
                child: Image.asset(
                  'Assets/logo.jpg',
                  fit: BoxFit.scaleDown,
                ),
              ),),
              // SizedBox(height: 90,),

              SizedBox(height: 20,),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white70,
                  border: Border.all(
                    color: Colors.black,
                    width: 0.3,
                  )
                ),
                alignment: Alignment.bottomCenter,
                child: Text('A simple system that empowers you to draw a map  that will help you in making the most of your Time, Talent & Treasure towards the achievement of your ultimate purpose ',
                  style: GoogleFonts.getFont('Alice', textStyle: TextStyle( fontSize: 30, color: Colors.black, letterSpacing: 0.5)),
                  textAlign: TextAlign.center,
                ),
              ),
             SizedBox(height: 10,),
             Row(
               children: <Widget>[
                 Container(
                   padding: EdgeInsets.all(8),
                   child: Text('Let\'s start your journey',
                     style: GoogleFonts.getFont('Alice', textStyle: TextStyle( fontSize: 25 ,color: Colors.white)),
                   ),
                 ),
                 FlatButton(
                     onPressed: () {

                     },
                     child: Text('here',
                       style: GoogleFonts.getFont('Alice',
                           textStyle: TextStyle(color: Colors.lightBlueAccent,
                               fontSize: 25)
                       ),
                     )
                 ),
               ],
             )

            ],
          )
        ],
      ),
    );
  }

}