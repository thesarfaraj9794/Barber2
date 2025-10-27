import 'package:barber_booking_app/pages/Admin/booking_admin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {

  TextEditingController usernamecontroller =new TextEditingController();
  TextEditingController userpasswordcontroller =new TextEditingController();
  

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
                "Admin\nPannel",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
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
                
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   
                    Text(
                      "Username",
                      style: TextStyle(
                        color: Color(0xFFB91635),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                     
                      controller: usernamecontroller,
                      decoration: InputDecoration(
                        hintText: "User name",
                        prefixIcon: Icon(Icons.mail_lock_outlined),
                      ),
                    ),
                    SizedBox(height: 15.0),
                    Text(
                      "Password",
                      style: TextStyle(
                        color: Color(0xFFB91635),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextFormField(
                      
                      controller: userpasswordcontroller,
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
                    SizedBox(height: 20.0),
                    GestureDetector(
                      onTap: () {
                      LoginAdmin();
                        
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
                            "LOG IN",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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

  LoginAdmin() {
  FirebaseFirestore.instance.collection("Admin").get().then((snapshot) {
    snapshot.docs.forEach((result) {
      if(result.data()['id']!=usernamecontroller.text.trim()){

        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "your id is not correct",
                style: TextStyle(fontSize: 15.0),
              ),
            ),);

      }
      else if(result.data()['password']!=userpasswordcontroller.text.trim()){

        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "your password  is not correct",
                style: TextStyle(fontSize: 15.0),
              ),
            ),);
      }
      else{
        Navigator.push(context, MaterialPageRoute(builder: (context)=>BookingAdmin()));
      }
      //print(result.data()); // यहाँ आप जो करना चाहते हैं वो लिखें
    });
  });
}



}