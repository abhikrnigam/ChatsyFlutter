
import 'ChatScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

class HomeScreen extends StatefulWidget {
  Future<FirebaseUser> user;
  Text newFriendEmail;

  HomeScreen({this.user,this.newFriendEmail});                                  //Taking the data from discover Screen
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  FirebaseUser user;
  String email;







  Text getNewFriendEmail()
  {
    return widget.newFriendEmail;                                               //Getting the Email of the new User
  }

  Future<FirebaseUser> getUser() async
  {
    try {
      user = await widget.user;
      return user;
    }
    catch(e){
      print(e);//Getting the firebase user from the superclass
    }
  }

@override
  void initState() {
   getUser();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
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
//            Flexible(
//              child: email==null?CircularProgressIndicator():StreamBuilder<QuerySnapshot>(
//                stream: Firestore.instance.collection("User").document("${user.email}").collection("friends").snapshots(),
//                builder: (context,snapshot){
//                  if(!snapshot.hasData){
//                    return CircularProgressIndicator();
//                  }
//                  List<int> listOfIndicesForbidden=[];
//                  void uniqueListTiles()
//                  {
//                    print(user.email.toString());
//                    int length=snapshot.data.documents.length;
//                    for(int i=0;i<length && !listOfIndicesForbidden.contains(i);i++)
//                    {
//
//                            for (int j = i + 1; j < length; j++)
//                            {
//                                if (snapshot.data.documents[i]["name"] == snapshot.data.documents[j]["name"] && !listOfIndicesForbidden.contains(j))
//                                {
//                                  listOfIndicesForbidden.add(j);
//                                }
//                            }
//
//                    }
//
//                  }
//                  uniqueListTiles();
//                  return ListView.builder(
//                    itemCount: snapshot.data.documents.length,
//                      itemBuilder: (context,index)
//                      {
//                        String friendemail;
//                        friendemail=snapshot.data.documents[index]["name"].toString();
//                        if (!listOfIndicesForbidden.contains(index))
//                        {
//                          return Container(
//                            margin: EdgeInsets.symmetric(
//                                vertical: 5, horizontal: 10),
//                            padding: EdgeInsets.symmetric(
//                                vertical: 15, horizontal: 5),
//                            decoration: BoxDecoration(
//                                borderRadius: BorderRadius.circular(10),
//                                color: Colors.blue
//                            ),
//                            child: ListTile(
//                              onTap: (){
//                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreen(friendEmail: snapshot.data.documents[index]["name"].toString(),user: user,)));
//                              },
//                              leading: Icon(
//                                Icons.account_circle,
//                                color: Colors.white,
//                                size: 40,
//                              ),
//                              //contentPadding: EdgeInsets.symmetric(horizontal: 1,vertical: 3),
//                              title:  friendemail==null?Text("Discover users to populate chats",style: TextStyle(color: Colors.black54),):Text(
//                                "$friendemail",
//                                style: GoogleFonts.poppins(
//                                  fontSize: 20,
//                                  color: Colors.white,
//                                ),),
//                            ),
//                          );
//                        }
//                        else
//                          {
//                          index++;
//                          return Container(
//                            height: 0,
//                            width: 0,
//                          );
//                        }
//                      }
//                  );
//                },
//              ),
//            ),
            Flexible(
              child: FutureBuilder(
                future: getUser(),
                builder: (context,snapshot){
                  if(!snapshot.hasData){
                    return CircularProgressIndicator(backgroundColor: Colors.blue,);
                  }
                  else{
                    FirebaseUser user=snapshot.data;
                    return StreamBuilder<QuerySnapshot>(
                      stream: Firestore.instance.collection("User").document("${user.email}").collection("friends").snapshots(),
                      builder: (context,snapshot){
                        if(!snapshot.hasData){
                          return CircularProgressIndicator();
                        }
                        List<int> listOfIndicesForbidden=[];
                        void uniqueListTiles()
                        {
                          print(user.email.toString());
                          int length=snapshot.data.documents.length;
                          for(int i=0;i<length && !listOfIndicesForbidden.contains(i);i++)
                          {

                            for (int j = i + 1; j < length; j++)
                            {
                              if (snapshot.data.documents[i]["name"] == snapshot.data.documents[j]["name"] && !listOfIndicesForbidden.contains(j))
                              {
                                listOfIndicesForbidden.add(j);
                              }
                            }

                          }

                        }
                        uniqueListTiles();
                        return ListView.builder(
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (context,index)
                            {
                              String friendemail;
                              friendemail=snapshot.data.documents[index]["name"].toString();
                              if (!listOfIndicesForbidden.contains(index))
                              {
                                return Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.blue
                                  ),
                                  child: ListTile(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatScreen(friendEmail: snapshot.data.documents[index]["name"].toString(),user: user,)));
                                    },
                                    leading: Icon(
                                      Icons.account_circle,
                                      color: Colors.white,
                                      size: 40,
                                    ),
                                    //contentPadding: EdgeInsets.symmetric(horizontal: 1,vertical: 3),
                                    title:  friendemail==null?Text("Discover users to populate chats",style: TextStyle(color: Colors.black54),):Text(
                                      "$friendemail",
                                      style: GoogleFonts.poppins(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),),
                                  ),
                                );
                              }
                              else
                              {
                                index++;
                                return Container(
                                  height: 0,
                                  width: 0,
                                );
                              }
                            }
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


