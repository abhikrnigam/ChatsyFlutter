import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'mainscreen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';



String url="";


class ProfileScreen extends StatefulWidget {
  Future<FirebaseUser> user;
  ProfileScreen({this.user});
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
<<<<<<< HEAD
  Firestore _firestore=Firestore.instance;
=======
Firestore _firestore=Firestore.instance;
>>>>>>> master


  @override
  void initState() {
    super.initState();
    checkSharedPrefs();
  }

<<<<<<< HEAD
=======



    void setStorageImageUrlSharedPerfs(String url)  async{
>>>>>>> master



  void setStorageImageUrlSharedPerfs(String url)  async{

    SharedPreferences perfs=await SharedPreferences.getInstance();

    perfs.setString("StorageImageURL", url);

  }

  Future<String> getStorageImageURLSharedPerfs() async{

    SharedPreferences perfs=await SharedPreferences.getInstance();
    return perfs.getString("StorageImageURL");

  }



  void checkSharedPrefs() async{

    SharedPreferences perfs=await SharedPreferences.getInstance();
    if(perfs.getBool("doProfilePicExists"))
    {
      url=await getStorageImageURLSharedPerfs();

<<<<<<< HEAD
    }
    else{
      url="https://moonvillageassociation.org/wp-content/uploads/2018/06/default-profile-picture1.jpg";
    }
    Future.delayed(Duration(milliseconds: 200),(){
      if (!mounted) return;
      setState(() {

      });
    });

  }

  void uploadImage()async{

    FirebaseUser user=await getUser();
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    StorageReference storage=FirebaseStorage.instance.ref().child("${user.email}+profileImage");
    storage.delete().whenComplete(() => {
      print("Image deleted from database")
    });
    storage=FirebaseStorage.instance.ref().child("${user.email}+profileImage");
    StorageUploadTask uploadTask=storage.putFile(tempImage);
    StorageTaskSnapshot taskSnapshot=await uploadTask.onComplete;
    String url=await storage.getDownloadURL();
    setStorageImageUrlSharedPerfs("$url");
    setSharedPreferencesTrue();
    setState(() {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text("Profile picture uploaded, refresh page to view"),)) ;
    });


  }
=======
      FirebaseUser user=await getUser();
      var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);
      StorageReference storage=FirebaseStorage.instance.ref().child("${user.email}+profileImage");
      storage.delete().whenComplete(() => {
        print("Image deleted from database")
      });
      storage=FirebaseStorage.instance.ref().child("${user.email}+profileImage");
      StorageUploadTask uploadTask=storage.putFile(tempImage);
      StorageTaskSnapshot taskSnapshot=await uploadTask.onComplete;
      String url=await storage.getDownloadURL();
      setStorageImageUrlSharedPerfs("$url");
      setSharedPreferencesTrue();
      setState(() {
        Scaffold.of(context).showSnackBar(SnackBar(content: Text("Profile picture uploaded, refresh page to view"),)) ;
      });


    }
>>>>>>> master
  FirebaseUser user;
  Future getUser()  async
  {
    return await widget.user;
  }

  void setSharedPreferencesTrue() async
  {
    SharedPreferences prefs=await SharedPreferences.getInstance();
    prefs.setBool("doProfilePicExists", true);
  }

  FirebaseUser CurrentUser;
  var CurrentUserEmail;

  Future getCurrentUserEmail() async{
    CurrentUser = await widget.user;
    CurrentUserEmail=CurrentUser.email.toString();
    return CurrentUserEmail;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
      body: Column(
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
          Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left:60.0),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image:  NetworkImage(url),
                        ),
                      ),
                      height: 150,
                      width: 150,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 90, 2, 2),
                    child: FloatingActionButton(
                      backgroundColor: Colors.blue,
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 30,
                      ),
                      onPressed:  uploadImage,
                    ),
                  ),
                ],
              ),
                FutureBuilder(
                  future: getCurrentUserEmail(),
                  builder: (context,snapshot){
                    if(snapshot.connectionState==ConnectionState.done){
                      return StreamBuilder(
                        stream: Firestore.instance.collection("User").document("${snapshot.data}").snapshots(),
                        builder: (context,docs){
                          if(!docs.hasData){
                            return Center(child: CircularProgressIndicator(backgroundColor: Colors.blue,));
                          }
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Card(
                                elevation: 6,
                                color: Colors.blue,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                                  child: Text(
                                    "${docs.data["name"]}",
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 35,
                                    ),
                                  ),
                                ),
                              ),
                              Card(
                                elevation: 6,
                                color: Colors.blue,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                                  child: Text(
                                    "${docs.data["email"]}",
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }
                    else return Center(child: CircularProgressIndicator(backgroundColor: Colors.blue,));
                  },
                ),
            ],
          ),
        ],
=======
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
            Spacer(),
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left:60.0),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image:  NetworkImage(url),
                          ),
                        ),
                        height: 150,
                        width: 150,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(8, 90, 2, 2),
                      child: FloatingActionButton(
                        backgroundColor: Colors.blue,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 30,
                        ),
                        onPressed:  uploadImage,
                      ),
                    ),
                  ],
                ),

                Spacer(),
                FutureBuilder(
                  future: getCurrentUserEmail(),
                  builder: (context,snapshot){
                    if(snapshot.connectionState==ConnectionState.done){
                      return StreamBuilder(
                        stream: Firestore.instance.collection("User").document("${snapshot.data}").snapshots(),
                        builder: (context,docs){
                          if(!docs.hasData){
                            return Center(child: CircularProgressIndicator(backgroundColor: Colors.blue,));
                          }
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Card(
                                elevation: 6,
                                color: Colors.blue,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                                  child: Text(
                                    "${docs.data["name"]}",
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 35,
                                    ),
                                  ),
                                ),
                              ),
                              Card(
                                elevation: 6,
                                color: Colors.blue,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                                  child: Text(
                                    "${docs.data["email"]}",
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }
                    else return Center(child: CircularProgressIndicator(backgroundColor: Colors.blue,));
                  },
                ),

              ],
            ),
          ],
        ),
>>>>>>> master
      ),
    );
  }
}