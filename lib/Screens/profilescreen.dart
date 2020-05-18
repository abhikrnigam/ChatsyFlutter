import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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


  @override
  void initState() {
    super.initState();
    checkSharedPrefs();
  }

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
      print("Image Inserted");
      String url=await storage.getDownloadURL();
      print("Download url getter");
      setStorageImageUrlSharedPerfs("$url");
      setSharedPreferencesTrue();
      setState(() {
        Scaffold.of(context).showSnackBar(SnackBar(content: Text("Profile picture uploaded....Kindly wait...."),)) ;
      });
      Future.delayed(Duration(milliseconds: 500),(){
        if (!mounted) return;
        setState(() {

        });
      });

    }

  Future<FirebaseUser> getUser()  async
  {
    return await widget.user;
  }


  void setSharedPreferencesTrue() async
  {
  SharedPreferences prefs=await SharedPreferences.getInstance();
  prefs.setBool("doProfilePicExists", true);
  }





  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image:  NetworkImage(url),
                ),
              ),
              height: MediaQuery.of(context).size.height*0.20,
            width: MediaQuery.of(context).size.width*0.50,
//            child: Image.network(url,fit: BoxFit.fill, loadingBuilder: (BuildContext context,Widget widget,ImageChunkEvent imagechunkevent){
//              if(imagechunkevent==null)return widget;
//              return CircularProgressIndicator(
//                value: imagechunkevent.expectedTotalBytes != null ?
//                imagechunkevent.cumulativeBytesLoaded / imagechunkevent.expectedTotalBytes
//                    : null,
//                backgroundColor: Colors.blue,
//                strokeWidth: 10,
//              );
//            },) ,
            ),
            RawMaterialButton(
              fillColor: Colors.cyan,
              onPressed:  uploadImage,
            ),
            Row(
              children: <Text>[
                Text(""),
                Text(""),
              ],
            ),
            Text(""),
          ],
        ),
      ),
    );
  }
}
