//import 'package:barber_booking_app/pages/Admin/admin_login.dart';
import 'package:barber_booking_app/pages/home.dart';
import 'package:barber_booking_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:barber_booking_app/services/shared_pref.dart';

class Booking extends StatefulWidget {
  final String service;
  const Booking({super.key, required this.service});

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  String? name, email;
  TextEditingController numberController = TextEditingController();

  getthedatafromsharedpref() async {
    name = await SharedpreferenceHelper().getUserName();
    email = await SharedpreferenceHelper().getUserEmail();
    setState(() {});
  }

  getontheload() async {
    await getthedatafromsharedpref();
    setState(() {});
  }

  @override
  void initState() {
    getontheload();
    super.initState();
  }

  DateTime _selectedDate = DateTime.now();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2024),
      lastDate: DateTime(2026),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  TimeOfDay _selectedTime = TimeOfDay.now();
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF2b1615),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0, top: 15.0),
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                      size: 15,
                    ),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Let's the\njourny begain",
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10.0),

                Container(
                  width: double.infinity,
                  height: 200,
                  child: Image.asset(
                    "assets/images/br2.webp",
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  widget.service,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(height: 20.0),

                // TextField for mobile number
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                   // color: const Color.fromARGB(255, 255, 255, 255),
                    //color: Color(0xFFb4817e),
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    controller: numberController,
                    keyboardType: TextInputType.phone,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter your mobile number",
                      hintStyle: TextStyle(color: Colors.black),
                      prefixIcon: Icon(Icons.phone, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 15),

                Container(
                  padding: EdgeInsets.only(top: 10.0),
                  height: 80,
                  decoration: BoxDecoration(
                    color: Color(0xFFb4817e),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Text(
                        "set date",
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                      SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _selectDate(context);
                            },
                            child: Icon(
                              Icons.calendar_month,
                              color: Colors.white,
                              size: 15,
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Text(
                            "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                Container(
                  padding: EdgeInsets.only(top: 10.0),
                  height: 80,
                  decoration: BoxDecoration(
                    color: Color(0xFFb4817e),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Text(
                        "set a Time",
                        style: TextStyle(fontSize: 15, color: Colors.black),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _selectTime(context);
                            },
                            child: Icon(
                              Icons.alarm,
                              color: Colors.white,
                              size: 15.0,
                            ),
                          ),
                          SizedBox(width: 10.0),
                          Text(
                            _selectedTime.format(context),
                            style: TextStyle(
                              fontSize: 15.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: () async {
                     if (numberController.text.isEmpty) {
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Please enter your mobile number",
          style: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(16),
        duration: Duration(seconds: 3),
      ),
    );
    return; // आगे processing नहीं होगी जब तक number खाली है
  }
                    
                    Map<String, dynamic> addUserBookingmap = {
                      "Service": widget.service,
                      "Date":
                          "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}".toString(),
                      "Time": _selectedTime.format(context).toString(),
                      "Username": name,
                      "Email": email,
                      "Number": numberController.text, // added number
                    };
                    await DatabaseMethod().addUserBooking(addUserBookingmap).then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Row(
                            children: [
                              Icon(Icons.check_circle, color: Colors.white),
                              SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  "Services have been booked successfully!",
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                          backgroundColor: Colors.green,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          margin: EdgeInsets.all(16),
                          duration: Duration(seconds: 6),
                        ),
                      );
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                    decoration: BoxDecoration(
                      color: Color(0xFFdf711a),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        "BOOK NOW",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      
                    ),
                    
                  ),
                ),
                SizedBox(height: 10,)
              ],
            ),
            
          ),
          
        ),
        
      ),
      
    );
    
  }
}
