import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'loginscreen.dart';
import 'registrationscreen.dart';
class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<bool> _callBack() async{
      return false;
    }
    var filledcolor=Colors.lightBlue;
    return WillPopScope(
      onWillPop: _callBack,
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: SafeArea(
            child: Stack(
              children:<Widget>[
                Bubble(bubblecolor: Colors.redAccent,alignment: Alignment(-0.2,-0.2),),
                Bubble(bubblecolor: Colors.amber,alignment: Alignment.topRight,),
                Bubble(bubblecolor: Colors.deepPurple,alignment: Alignment.bottomLeft,),
                Bubble(bubblecolor: Colors.green,alignment: Alignment.bottomRight,),
                Bubble(bubblecolor: Colors.green,alignment: Alignment.centerLeft,),
                Bubble(bubblecolor: Colors.pinkAccent,alignment: Alignment.topLeft,),
                Bubble(bubblecolor: Colors.amber,alignment: Alignment(0.6,-0.2),),
                Bubble(bubblecolor: Colors.purpleAccent,alignment: Alignment(0.2,0.5),),
                Bubble(bubblecolor: Colors.amber,alignment: Alignment(-0.1,0.8),),
                Bubble(bubblecolor: Colors.deepPurple,alignment: Alignment(0.1,-0.7),),
                Bubble(bubblecolor: Colors.redAccent,alignment: Alignment(0.5,0.9),),
                Bubble(bubblecolor: Colors.amber,alignment: Alignment(-0.8,0.5),),
                Bubble(bubblecolor: Colors.deepPurple,alignment: Alignment(-1.0,-0.7),),
                Bubble(bubblecolor: Colors.redAccent,alignment: Alignment(-0.1,-0.5),),
                Column(
                mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Spacer(flex:2),
               Hero(
                 tag:'chatsyContainer',
                 child: Material(
                   child: Container(
                     margin: EdgeInsets.only(right:15,left: 15,),
                     width: MediaQuery.of(context).size.width,
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(20),
                       color: Colors.lightBlueAccent,
                     ),
                     child: Padding(
                       padding: const EdgeInsets.all(10.0),
                       child: Text(
                           "Chatsy",
                         style: GoogleFonts.quicksand(
                           fontSize: 40,
                           fontWeight: FontWeight.bold,
                           color: Colors.white,
                         ),
                       ),
                     ),
                   ),
                 ),
               ),
                Spacer(flex:1),
                RawMaterialButton(
                  onPressed:(){
                    Navigator.push(context,MaterialPageRoute(builder:(context)=>(LoginScreen())));
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 6,
                  fillColor: filledcolor,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical:8.0,horizontal: 40),
                    child: Text(
                      'Login',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                RawMaterialButton(
                  onPressed: (){
                    Navigator.push(context,MaterialPageRoute(builder:(context)=>(RegistrationScreen())));
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 6,
                  fillColor: filledcolor,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical:8.0,horizontal: 40),
                    child: Text(
                      'Register',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
                Spacer(flex:3),
                Text("Made By: Abhishek with ❤️",
                style: GoogleFonts.poppins(
                  fontSize: 12.0,
                  color: Colors.grey,
                ),)
              ],
              ),],
            ),
          ),
        ),
      ),
    );
  }
}

class Bubble extends StatelessWidget {
  Color bubblecolor;
  Alignment alignment;
Bubble({this.bubblecolor,this.alignment});
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: MediaQuery.of(context).size.height*0.1,
          width: MediaQuery.of(context).size.width*0.1,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: bubblecolor,
          ),
        ),
      ),
    );
  }
}
