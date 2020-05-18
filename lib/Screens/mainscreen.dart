import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'discoverscreen.dart';
import 'profilescreen.dart';
import 'homescreen.dart';




class MainScreen extends StatefulWidget {

  GoogleSignIn googleSignIn=new GoogleSignIn();
  GoogleSignInAccount googleSignInAccount;
  GoogleSignInAuthentication googleSignInAuthentication;
  AuthCredential authCredential;
  FirebaseUser user;
  MainScreen({this.googleSignInAccount,this.googleSignInAuthentication,this.authCredential,this.user});
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    getCurrentUser();
    getCurrentLocation();
    getUser().then((value) {
  setState(() {
  transferUser=user;
    });
    }
    );

  }


  FirebaseUser transferUser;
  GoogleSignIn googleSignIn;
  GoogleSignInAccount googleSignInAccount;
  GoogleSignInAuthentication googleSignInAuthentication;
  AuthCredential authCredential;
  FirebaseUser user;
  FirebaseAuth _auth=FirebaseAuth.instance;

  void getCurrentUser() async{
    if(user==null) {
      user = await _auth.currentUser();

    }
    else{
     print("User already exists");
    }


  }
  void signOut(){

    googleSignIn=widget.googleSignIn;
    googleSignInAccount=widget.googleSignInAccount;
    authCredential=widget.authCredential;
    user=widget.user;
    googleSignIn.signOut();
    Navigator.pop(context);

  }

  void getCurrentLocation() async {
    Position pos = await Geolocator().getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    Geoflutterfire geo = Geoflutterfire();
    GeoFirePoint location = geo.point(
        latitude: pos.latitude, longitude: pos.longitude);

    var name=user.email;
    Firestore _firestore=Firestore.instance;
   await _firestore.collection("User").document("$name").updateData({
     "location":location.data,
     "name":user.displayName,
   });
  }


  Future<FirebaseUser> getUser() async {
      transferUser=await user;
    return transferUser;
  }


  Widget getPage(int index) {
    if(index==0){
      return  DiscoverScreen(user: getUser(),);
    }
    if(index==1){
      return HomeScreen(user: getUser(),);
    }
    else return ProfileScreen(user: getUser(),);
}


  int index=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getPage(index),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value){
          setState(() {
            index=value;
          });

        },
        backgroundColor: Colors.lightBlueAccent,
        currentIndex: index,
        selectedItemColor: Colors.white,
        selectedFontSize: 15,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.search,
              size: 35,),
            title: Text(
              'Discover',
            ),
          ),
          BottomNavigationBarItem(
          icon: Icon(Icons.home,size: 35,),
              title: Text(
            'Chats',)
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.perm_identity,
              size: 35,
            ),
            title: Text(
              'Profile',
            ),
          ),
        ],
      ),
    );
  }
}













