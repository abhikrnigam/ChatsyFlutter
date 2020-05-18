import 'package:chatsy/Screens/loginscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'welcomescreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {


  void setPreference() async
  {
    SharedPreferences pref=await SharedPreferences.getInstance();
    pref.setBool("doProfilePicExists", false);
  }

  FirebaseAuth _auth=FirebaseAuth.instance;
  Firestore _firestore=Firestore.instance;
  String email;
  String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
            Spacer(flex:3),
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
                    padding: const EdgeInsets.all(12.0),

                        child:RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: "Chatsy \n",
                              style: GoogleFonts.quicksand(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                              ),
                              TextSpan(
                                text: "Register",
                                style: GoogleFonts.poppins(
                                  color:Colors.white,
                                  fontSize:14,
                                )
                              ),
                            ],
                          ),
                        ),
                  ),
                  ),
                ),
              ),
            Spacer(),
            Padding(
              padding:  EdgeInsets.symmetric(vertical:15.0,horizontal:12.0),
              child: TextField(
                textAlign: TextAlign.center,
                autofocus: true,
                style: TextStyle(
                  color: Colors.black,
                ),
                onChanged: (value){
                    email=value;
                },
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  hintText: 'Enter your email id ',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical:15.0,horizontal:12.0),
              child: TextField(
                textAlign: TextAlign.center,
                autofocus: true,
                obscureText: true,
                style: TextStyle(
                  color: Colors.black,
                ),
                onChanged: (value){
                  password=value;
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  hintText: 'Enter password ',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            RawMaterialButton(
              onPressed:() async{
                if(email==null || password==null){
                  print("email or password cant be numm");
                }
                else {
                  _auth.createUserWithEmailAndPassword(email: email, password: password);
                  setPreference();
                await  _firestore.collection("User").document("$email").setData({
                    "email":email,
                  }).then((value) => {Navigator.push(context, MaterialPageRoute(builder: (context) => (LoginScreen())))});

                }
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 6,
              fillColor: Colors.blue,
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
          ],
        ),
      ],
      ),
    );
  }
}
