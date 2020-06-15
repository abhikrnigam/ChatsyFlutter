import 'package:chatsy/Screens/loginscreen.dart';
import 'package:chatsy/Screens/mainscreen.dart';
import 'package:flutter/material.dart';
import "package:chatsy/Screens/welcomescreen.dart";
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown,DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Future<bool> getPrefs() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool page = sharedPreferences.getBool("isLoggedIn");
    return page;
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPrefs();
  }
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: FutureBuilder(
        future: getPrefs(),
        builder: (context,snapshot){
          if(!snapshot.hasData){
            return Container(
              height: 100,
              width: 100,
              color: Colors.white,
              child: CircularProgressIndicator(backgroundColor: Colors.blue,),
            );
          }
          else{
            if(snapshot.data==true){
              return MainScreen();
            }
            else{
              return WelcomeScreen();
            }
          }
        },
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
