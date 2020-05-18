import 'package:chatsy/Screens/mainscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'welcomescreen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth=FirebaseAuth.instance;
  final GoogleSignIn googleSignIn=new GoogleSignIn();

  Future<FirebaseUser> signIn()async {

    GoogleSignInAccount signInAccount=await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication=await signInAccount.authentication;
    final AuthCredential authCredential=GoogleAuthProvider.getCredential(idToken: googleSignInAuthentication.idToken, accessToken: googleSignInAuthentication.idToken);
    FirebaseUser firebaseUser=(await _auth.signInWithCredential(authCredential)).user;
    if(firebaseUser==null){
      print("Some Error Occured");
    }
    else{
      Navigator.push(context, MaterialPageRoute(builder: (context)=>MainScreen()));
    }
  }
  @override
  Widget build(BuildContext context) {
    String email;
    String password;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
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
              children: <Widget>[
                Spacer(flex: 5,),
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
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal:50.0,vertical: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: RawMaterialButton(
                      onPressed: () {
                        signIn();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.google,
                            color: Colors.white,
                          ),
                          Text(
                            "   Sign in with Google",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
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
                  onPressed:() {
                    _auth.signInWithEmailAndPassword(email: email, password: password);
                    Navigator.push(context,MaterialPageRoute(builder:(context)=>(MainScreen())));
                  },
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 6,
                  fillColor: Colors.blue,
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
                Spacer(flex: 6,)
              ],
            ),
          ],

        ),
      ),
    );
  }
}
