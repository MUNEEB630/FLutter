import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mun/screen/authenticate/sign_in.dart';
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    runApp(MyApp());
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
          home:AnimatedSplashScreen(
        backgroundColor: Colors.black,
        splash: 'assets/b2.jpg',
        nextScreen: Login(),
        splashTransition: SplashTransition.fadeTransition,
        splashIconSize: 250,
      )
      // ),
    );
  }
  Future getData() async{
    var url = Uri.parse('https://honey-methodology.000webhostapp.com/get.php');
    http.Response response = await http.get(url);
    var data = jsonDecode(response.body);
    return data.toString();
  }
  @override
  void initState(){
      getData();
    }
}



