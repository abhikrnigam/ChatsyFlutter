import 'package:chatsy/Screens/welcomescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'discoverscreen.dart';
import 'profilescreen.dart';
import 'homescreen.dart';




class MainScreen extends StatefulWidget {
  int transferIndex;
  FirebaseUser user;
  MainScreen({this.user,this.transferIndex});
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int transferIndex;
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
    transferIndex=widget.transferIndex;
    getTransferedPage();
  }


  FirebaseUser transferUser;
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
  void signOut() async{
  SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
  sharedPreferences.setBool("isLoggedIn", false);
    _auth.signOut().then((value) => {
      print("user signed out"),
    }).catchError((e)=>{
      print(e),
    });
    Navigator.push(context,MaterialPageRoute(builder: (context)=>WelcomeScreen()));

  }

  void getCurrentLocation() async {
    Position pos = await Geolocator().getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    Geoflutterfire geo = Geoflutterfire();
    GeoFirePoint location = geo.point(
        latitude: pos.latitude, longitude: pos.longitude);

    var name=user.email.toString();
    Firestore _firestore=Firestore.instance;
   await _firestore.collection("User").document("$name").updateData({
     "location":location.data,
   });
  }


  Future<FirebaseUser> getUser() async {
      transferUser=user;
    return transferUser;
  }


  void getTransferedPage(){
    if(transferIndex!=null){
      setState(() {
        getPage(transferIndex);
      });

    }
    else return;
  }


  Widget getPage(int index) {
    if(index==0){
      return  DiscoverScreen(user: getUser(),);
    }
    if(index==1){
      return HomeScreen(user: getUser(),);
    }
    if(index==2)
      return ProfileScreen(user: getUser(),);
    else signOut();
}


  int index=1;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: getPage(index),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: (value){
            setState(() {
              index=value;
            });

          },
          backgroundColor: Colors.lightBlueAccent,
          currentIndex: index,
          selectedItemColor: Colors.white,
          selectedFontSize: 20,
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
            BottomNavigationBarItem(
              icon: Icon(
                Icons.exit_to_app,
                size: 35,),
              title: Text(
                'Sign Out',
              ),
            ),
          ],
        ),
    );
  }
}













