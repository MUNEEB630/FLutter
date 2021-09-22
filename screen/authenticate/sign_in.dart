import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mun/models/user.dart';
import 'package:mun/screen/authenticate/signup.dart';
import 'package:mun/screen/services/forgetPassword.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  var email = "";
  var password = "";
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  userLogin() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => UserMain(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("No User Found for that Email");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              "No User Found for that Email",
              style: TextStyle(fontSize: 18.0, color: Colors.white),
            ),
          ),
        );
      } else if (e.code == 'wrong-password') {
        print("Wrong Password Provided by User");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              "Wrong Password Provided by User",
              style: TextStyle(fontSize: 18.0, color: Colors.white),
            ),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: Scaffold(backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,

      body: Container(

        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        image: DecorationImage(
          image: AssetImage("assets/b8.jpg"),
            fit: BoxFit.cover,

        ),
      ),

        child: Container(
          margin:EdgeInsets.only(top:90,bottom:20),


          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 30),
              child: ListView(
                children: [

                  Container(
                    margin:EdgeInsets.only(bottom:20),
                    child: Icon(

                      Icons.person,
                      color: Colors.white ,
                      size: 100.0,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    child: TextFormField(
                      autofocus: false,
                      cursorColor:Colors.white,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(

                        labelText: 'Email: ',
                        labelStyle: TextStyle(fontSize: 20.0,color: Colors.white),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.white, width: 0.0),),
                        errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                      ),
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Email';
                        } else if (!value.contains('@')) {
                          return 'Please Enter Valid Email';
                        }
                        return null;
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    child: TextFormField(
                      autofocus: false,
                      obscureText: true,
                      style: TextStyle(color: Colors.white),

                      decoration: InputDecoration(
                        labelText: 'Password: ',
                        labelStyle: TextStyle(fontSize: 20.0, color: Colors.white),
                        enabledBorder: const OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white, width: 0.0),),
                        errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                      ),
                      controller: passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Password';
                        }
                        return null;
                      },
                    ),
                  ),
                  Center(
                    child: Container(


                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Validate returns true if the form is valid, otherwise false.
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  email = emailController.text;
                                  password = passwordController.text;
                                });
                                userLogin();
                              }
                            },
                            child: Text(
                              'Login',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17)),

                              style: ElevatedButton.styleFrom(
                                  primary: Colors.black,
                                  fixedSize: Size(180,
                                  45),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30))
                            ),
                          ),
      ],),),
                  ),
                        Container(
                          margin:EdgeInsets.only(left:10),
                          child: TextButton(
                            onPressed: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ForgotPassword(),
                                ),
                              )
                            },
                            child: Text(
                              'Forgot Password ?',
                              style: TextStyle(fontSize: 16.0,color:Colors.white),
                            ),
                          ),
                        ),

                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an Account? ",style : TextStyle(fontSize: 16.0, color: Colors.white)),
                        TextButton(
                          onPressed: () => {
                            Navigator.pushAndRemoveUntil(
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (context, a, b) => Signup(),
                                  transitionDuration: Duration(seconds: 0),
                                ),
                                    (route) => false)
                          },
                          child: Container(

                              child: Center(child: Text('Signup',style: TextStyle(color:Colors.black,fontSize: 20,fontWeight: FontWeight.bold)))),
                        ),
                        // TextButton(
                        //   onPressed: () => {
                        //     Navigator.pushAndRemoveUntil(
                        //         context,
                        //         PageRouteBuilder(
                        //           pageBuilder: (context, a, b) => UserMain(),
                        //           transitionDuration: Duration(seconds: 0),
                        //         ),
                        //         (route) => false)
                        //   },
                        //   child: Text('Dashboard'),
                        // ),
                      ],
                    ),
                  ),



                ],
              ),
            ),
          ),
        ),
      ),
      ),
    );
  }
}