import 'package:barber_booking_app/pages/home.dart';
import 'package:barber_booking_app/pages/login.dart';
import 'package:barber_booking_app/services/database.dart';
import 'package:barber_booking_app/services/shared_pref.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';

class Singup extends StatefulWidget {
  const Singup({super.key});

  @override
  State<Singup> createState() => _SingupState();
}

class _SingupState extends State<Singup> {
  String? name, mail, password;

  TextEditingController nameController = new TextEditingController(); //ye textfield input ko control krta h to read or set
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  final _formkey = GlobalKey<FormState>(); // Used to access and manage the form's state, such as validating or resetting it

  // registration() async {  //ye ragistation function h jo user regist.. ko handle krta h is fun ko kahi se call kiya jata h
  // //jb hm register button pr click krte h
  //   if (password != null && name != null && mail != null) { //Checks if all fields are filled (not null).
  //     try {
  //       //UserCredential: Stores the result of the authentication.
  //       //FirebaseAuth.instance: Accesses the Firebase authentication service
  //       //createUserWithEmailAndPassword(...): Registers a new user with an email and password.
  //       UserCredential userCredential = await FirebaseAuth.instance
  //           .createUserWithEmailAndPassword(email: mail!, password: password!);
  //           String id=randomAlphaNumeric(10);// Generates a random string of 10 characters (letters and numbers). and store user id

  //           await SharedpreferenceHelper().saveUserName(nameController.text);
  //           await SharedpreferenceHelper().saveUserEmail(emailController.text);
  //           await SharedpreferenceHelper().saveUserId(id);
  //           Map<String ,dynamic>userInfoMap={ //A dictionary where keys are strings and values can be anything.
  //             "Name":nameController.text,//add user name krega
  //             "Email":emailController.text,// useremail add krega
  //             "id":id,//add the user random id
              


  //           };
  //           await DatabaseMethod().addUserDetails(userInfoMap, id);// databasemethod:A custom class handling database actions.
  //       ScaffoldMessenger.of(context).showSnackBar( //used for like notification
  //         SnackBar(
  //           content: Text(
  //            "Registure Scussfully",
  //             style: TextStyle(fontSize: 15.0),
  //           ),
  //         ),
  //       );
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (context) => Home()),
  //       );
  //       //on FirebaseAuthException: Catches specific Firebase errors.
  //       //catch (e): Stores the error object in e.
  //     } on FirebaseAuthException catch (e) {//for erroe handling
  //       if (e.code == 'week-password') {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             content: Text(
  //               "password Provide is too week",
  //               style: TextStyle(fontSize: 15.0),
  //             ),
  //           ),
  //         );
  //       } else if (e.code == "email-already-in-use") {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             content: Text(
  //               "Account already exist",
  //               style: TextStyle(fontSize: 15.0),
  //             ),
  //           ),
  //         );
  //       }
  //     }
  //   }
  // }
  registration() async {
    if (password != null && name != null && mail != null) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: mail!, password: password!);

        String id = userCredential.user!.uid; // Firebase UID का उपयोग करें

        await SharedpreferenceHelper().saveUserName(nameController.text);
        await SharedpreferenceHelper().saveUserEmail(emailController.text);
        await SharedpreferenceHelper().saveUserId(id);

        Map<String, dynamic> userInfoMap = {
          "Name": nameController.text,
          "Email": emailController.text,
          "id": id,
        };

        await DatabaseMethod().addUserDetails(userInfoMap, id);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Register Successfully",
              style: TextStyle(fontSize: 15.0),
            ),
          ),
        );

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Home()));
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Password is too weak")),
          );
        } else if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Account already exists")),
          );
        }
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
                "Create Your\nAccount",
                style: TextStyle(
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
                bottom: 30.0,
              ),
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 6,
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
                      "Name",
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
                      controller: nameController,
                      decoration: InputDecoration(
                        hintText: "name",
                        prefixIcon: Icon(Icons.person_2_outlined),
                      ),
                    ),
                    SizedBox(height: 8.0),
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
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        
                      ],
                    ),
                    SizedBox(height: 15.0),
                    GestureDetector(
                      onTap: () {
                        if(_formkey.currentState!.validate()){
                          setState(() {
                            mail=emailController.text;
                            name=nameController.text;
                            password=passwordController.text;
                            
                          });
                        }
                        registration();
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
                            "Sing up",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
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
                          "Already have an account?",
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Sing In",
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
