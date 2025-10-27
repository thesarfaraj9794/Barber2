import 'package:barber_booking_app/pages/home.dart';
import 'package:barber_booking_app/pages/singup.dart';
import 'package:barber_booking_app/services/shared_pref.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? mail, password;

  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  final _formkey = GlobalKey<FormState>();
  // userLogin() async {
  //   try {
  //     await FirebaseAuth.instance.signInWithEmailAndPassword(
  //       email: mail!,  //email: mail!: The email entered by the user (! ensures it's not null).
  //       password: password!,
  //     );
  //     Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code != 'user-not-found') {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text(
  //             "No user found for that Email",
  //             style: TextStyle(fontSize: 15.0, color: Colors.black),
  //           ),
  //         ),
  //       );
  //     } else if (e.code == 'wrong-password') {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text(
  //             "Wrong Password Provided by user",
  //             style: TextStyle(fontSize: 15.0, color: Colors.black),
  //           ),
  //         ),
  //       );
  //     }
  //   }
  // }
  userLogin() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: mail!, password: password!);

      String uid = userCredential.user!.uid;

      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .get();

      if (userDoc.exists) {
        String userName = userDoc.get('Name');
        String userEmail = userDoc.get('Email');

        await SharedpreferenceHelper().saveUserId(uid);
        await SharedpreferenceHelper().saveUserName(userName);
        await SharedpreferenceHelper().saveUserEmail(userEmail);

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("User data not found")),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("No user found for that email")),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Wrong password provided")),
        );
      }
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(top: 30.0, left: 15.0),
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFB91635),
                    Color(0Xff621d3c),
                    Color(0xFF311937),
                  ],
                ),
              ),
              child: Text(
                "Hello\nSign in!",
                style: 
                TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                top: 40.0,
                left: 20.0,
                right: 30.0,
                bottom: 50.0,
              ),
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 5,
              ),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Gmail",
                      style: TextStyle(
                        color: Color(0xFFB91635),
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter gmail';
                        }
                        return null;
                      },
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: "Gmail",
                        prefixIcon: Icon(Icons.mail_lock_outlined),
                      ),
                    ),
                    SizedBox(height: 15.0),
                    Text(
                      "Password",
                      style: TextStyle(
                        color: Color(0xFFB91635),
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter name';
                        }
                        return null;
                      },
                      controller: passwordController,
                      decoration: InputDecoration(
                        hintText: "Password",
                        prefixIcon: Icon(Icons.password_outlined),
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: 15.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Text(
                        //   "Forgot Password?",
                        //   style: TextStyle(
                        //     color: Color(0xFF311937),
                        //     fontSize: 15,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                      ],
                    ),
                    SizedBox(height: 40.0),
                    GestureDetector(
                      onTap: () {
                        if(_formkey.currentState!.validate()){
                          setState(() {
                            mail=emailController.text;
                            password=passwordController.text;
                          });
                          userLogin();
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFFB91635),
                              Color(0Xff621d3c),
                              Color(0xFF311937),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            "Sing in",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Don't have account?",
                          style: TextStyle(
                            color: Color(0xFF311937),
                            fontSize: 10.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Singup()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Sing up",
                            style: TextStyle(
                              color: Color(0Xff621d3c),
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
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
