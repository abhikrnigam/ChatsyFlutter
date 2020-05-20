import 'dart:math';
import 'package:chatsy/Screens/mainscreen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:chatsy/Screens/homescreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:rxdart/rxdart.dart';


class DiscoverScreen extends StatefulWidget {
  Future<FirebaseUser> user;
  DiscoverScreen({this.user});


  @override
  _DiscoverScreenState createState() => _DiscoverScreenState();
}


class _DiscoverScreenState extends State<DiscoverScreen> {


  Firestore _firestore=Firestore.instance;
  FirebaseUser user;





  double radius=20;



@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();



}

  Future<Position> getPosition()async{
  Position pos=await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.low);

  return pos;
  }

  void getRandomUser(double radius)  async{

    FirebaseUser user=await getCurrentUser();
    Geoflutterfire geo=Geoflutterfire();
    String field='location';
    Position pos=await getPosition();   //Getting the location of the user



    var collectionReference = _firestore.collection('User');
    GeoFirePoint center = geo.point(latitude: pos.latitude, longitude: pos.longitude);
    Stream<List<DocumentSnapshot>> stream = geo.collection(collectionRef: collectionReference)
        .within(center: center, radius: radius, field: field);                                    //Asking firebase for the geoquery using geoflutter fire

    List<Text> randomUser=[];
  List<String> randomUserString=[];                                                               //for storing the data for the database updation

    stream.listen((event) {                                                                       //Stream of the geoquery data
      int length=event.length;
      for(int i=0;i<length;i++)
      {
        if(event[i]["email"].toString()!= user.email.toString())
        {
          randomUser.add(Text("${event[i]["email"]}")); //adding the users to the list

          randomUserString.add("${event[i]["email"]}");

        }
      }
      var rng=Random();
      int random=rng.nextInt(length-1);

        addToFriends(randomUserString[random]);



      Navigator.push(context, MaterialPageRoute(builder: (context)=>MainScreen(transferIndex: 1,)));
    }
    );
  }


  void addToFriends(String friendUser) async{
    FirebaseUser user=await getCurrentUser();
    await _firestore.collection("User").document("${user.email}").collection("friends").add({
        "name":friendUser
    });
    await _firestore.collection("User").document("${friendUser}").collection("friends").add({
      "name":user.email
    });

    List<String> chatRoomName=["${user.email.toString()}","$friendUser"];
    chatRoomName.sort();



    await _firestore.collection("chatroom").document("${chatRoomName[0]}${chatRoomName[1]}").collection("chats").document().setData({
      "sender":null,
      "receiver":null,
      "text":null,
      "time":null,
    });
  }



  Future getCurrentUser()async{

    FirebaseUser user=await widget.user;
   return user;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.8,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Hero(
            tag: 'chatsyContainer',
            child: Material(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                  color: Colors.lightBlueAccent,
                ),
                child: Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 35, 1, 5),
                      child: Text(
                        "Chatsy",
                        style: GoogleFonts.quicksand(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 35,
                        ),
                      ),
                    )
                ),
              ),
            ),
          ),

          Flexible(
            child: ListView(
              children:<Widget>[
                RawMaterialButton(
                  onPressed: (){
                    getRandomUser(radius);
                  },
                child: Container(
                  margin: EdgeInsets.only(top: 20,right: 30,left: 30,bottom: 20),
                  padding: EdgeInsets.symmetric(vertical: 100,horizontal: 40),
                  child: Text(
                    "Discover",
                    style: GoogleFonts.quicksand(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(4.0,4.0),
                        blurRadius: 15.0,
                        spreadRadius: 1.0,
                      ),
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(-4.0,-4.0),
                        blurRadius: 15.0,
                        spreadRadius: 1.0,
                      ),
                    ],
                    shape: BoxShape.circle,
                    color: Colors.lightBlueAccent,
                  ),
                ),
              ),
                Material(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.lightBlueAccent,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 30,horizontal: 10),
                    padding: EdgeInsets.symmetric(horizontal: 7,vertical: 5),

                    child: Column(
                      children: <Widget>[
                        Text(
                          "Distance",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: "${radius.toInt()}",
                                style: TextStyle(
                                  fontSize: 60,
                                  color: Colors.white,
                                ),
                              ),
                              TextSpan(
                                text: 'Km',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),

                              ),
                            ],
                          ),
                        ),
                        Slider(
                          value: radius,
                          max: 100,
                          min: 0,
                          activeColor: Colors.blue,
                          inactiveColor: Colors.white,
                          onChanged: (double newvalue){
                            setState(() {
                              radius=newvalue;
                            });
                          },
                        ),
                      ],
                    ),

                  ),
                ),
              ],
            ),
          ),

        ],
        ),
    );
  }
}


