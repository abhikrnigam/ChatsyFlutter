

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';



class ChatScreen extends StatefulWidget {
  FirebaseUser user;
  String friendEmail;
  ChatScreen({this.friendEmail,this.user});
  @override
  _ChatScreenState createState() => _ChatScreenState();
}



class _ChatScreenState extends State<ChatScreen> {
  Firestore _firestore=Firestore.instance;
  String message;
  String friendEmail;
  FirebaseUser user;
  String currentUser;

  String getEmail()
  {
    friendEmail=widget.friendEmail;
  }

  @override
  void initState() {
   getEmail();
   getFirebaseUser();

  }

  Future getFirebaseUser()  async
  {
      user=await widget.user;
      currentUser=widget.user.email.toString();
      Future.delayed(Duration(milliseconds: 500),(){
        if(!mounted) return;
        setState(() {

        });
      });
  }


  String getDocumentName(){
    String currentUser=user.email.toString();
    String friendUser=friendEmail;

    List<String> chatroomname=[currentUser,friendUser];
    chatroomname.sort();
    String documentName=chatroomname[0]+chatroomname[1];
    return documentName;
  }

  final messagingController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "Messages",
                style: GoogleFonts.pacifico(
                  fontSize: 40,
                  color: Colors.blue,
                ),
              ),
            ),
            Expanded(
              flex: 10,
              child: Container(
                child:  currentUser==null?Center(child: SizedBox(height: 20,width: 20,child: CircularProgressIndicator(backgroundColor: Colors.cyan,),)):
                StreamBuilder(
                    stream: Firestore.instance.collection("chatroom").document(getDocumentName()).collection("chats").orderBy("time",descending: false).snapshots()  ,
                    builder: (context,snapshot)
                    {
                      List<String> messageText = [];
                      List<String> sender = [];
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.cyanAccent,
                          ),
                        );
                      }
                      else
                        {
                        int length = snapshot.data.documents.length;
                          int i = 0;
                          for (i = 0; i < length; i++)
                          {


                              messageText.add(snapshot.data.documents[i]["text"]
                                  .toString());
                              sender.add(snapshot.data.documents[i]["sender"]
                                  .toString());
                            }
                          }
                          return ListView.builder(
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (context, index) {
                              return sender[index].toString()=="null" || messageText[index].toString()=="null"?Container(height: 0,width: 0,):Container(
                                margin: currentUser == sender[index].toString()
                                    ? EdgeInsets.fromLTRB(70, 5, 2, 5)
                                    : EdgeInsets.fromLTRB(2, 5, 70, 5),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: currentUser == sender[index].toString()
                                      ? Colors.blue
                                      : Colors.grey,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  "${messageText[index]}",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 17,
                                  ),
                                ),
                              );
                            },
                          );

                        },

                ),

                  ),
              ),
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                    bottom:BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                  ),
              ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        controller: messagingController,
                        onChanged: (value){
                          message=value;
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                          hintText: 'Type your message here...',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    MaterialButton(
                      shape:RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20.0))),
                     color: Colors.blue,
                      onPressed: ()  async{
                        await _firestore.collection('chatroom').document(getDocumentName()).collection("chats").add({
                          'text':message,
                          "sender":user.email.toString(),
                          "receiver":friendEmail.toString(),
                          'time':DateTime.now(),
                        });

                        messagingController.clear();
                      },
                      child: Text(
                        'Send',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

