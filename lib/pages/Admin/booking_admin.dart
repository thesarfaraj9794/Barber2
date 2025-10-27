import 'dart:ui';
import 'package:url_launcher/url_launcher.dart';

import 'package:barber_booking_app/pages/onboarding.dart';
import 'package:barber_booking_app/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BookingAdmin extends StatefulWidget {
  const BookingAdmin({super.key});

  @override
  State<BookingAdmin> createState() => _BookingAdminState();
}

class _BookingAdminState extends State<BookingAdmin>
    with SingleTickerProviderStateMixin {
  Stream? bookingStream;
  bool isLoading = true;
  final TextEditingController _searchController = TextEditingController();

  getBookingsOnLoad() async {
    bookingStream = await DatabaseMethod().getBookings();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getBookingsOnLoad();
    super.initState();
  }

  Widget allBookings() {
    return StreamBuilder(
      stream: bookingStream,
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        var docs = snapshot.data.docs;
        String searchText = _searchController.text.toLowerCase();

        // 🔍 Filter bookings by name or service
        var filteredDocs = docs.where((doc) {
          String name = doc["Username"].toString().toLowerCase();
          String service = doc["Service"].toString().toLowerCase();
          return name.contains(searchText) || service.contains(searchText);
        }).toList();

        return ListView.builder(
          padding: const EdgeInsets.only(bottom: 20),
          itemCount: filteredDocs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot ds = filteredDocs[index];

            return TweenAnimationBuilder(
              duration: const Duration(milliseconds: 600),
              tween: Tween<double>(begin: 0, end: 1),
              builder: (context, double value, child) {
                return Transform.translate(
                  offset: Offset(0, (1 - value) * 30),
                  child: Opacity(opacity: value, child: child),
                );
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 10,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF621d3c).withOpacity(0.85),
                            const Color(0xFF311937).withOpacity(0.9),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  "assets/images/barber1.jpeg",
                                  height: 65,
                                  width: 65,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 15),
                              Expanded(
                                child: Text(
                                  ds["Service"],
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          const Divider(color: Colors.white38, thickness: 1),

                          infoRow(Icons.person, "Customer", ds["Username"]),
                          infoRow(Icons.phone, "Number", ds["Number"]),
                          infoRow(Icons.calendar_month, "Date", ds["Date"]),
                          infoRow(Icons.access_time, "Time", ds["Time"]),

                          const SizedBox(height: 10.0),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton.icon(
                              onPressed: () async {
                                await DatabaseMethod().DeleteBooking(ds.id);
                                String number = ds["Number"].toString().replaceAll(' ', '');
  if (!number.startsWith('+91')) {
    number = '+91$number';
  }

  // 3️⃣ Create encoded message
  String message = Uri.encodeComponent(
    "Hello ${ds["Username"]}, your booking for ${ds["Service"]} has been marked done successfully. Thank you!",
  );

  // 4️⃣ Build WhatsApp URL
  final Uri whatsappUrl = Uri.parse("https://wa.me/$number?text=$message");

  // 5️⃣ Show snackbar
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text("✅ Booking confirmed — opening WhatsApp..."),
      backgroundColor: Colors.green,
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 2),
    ),
  );

  // 6️⃣ Delay for smooth transition, then open WhatsApp
  Future.delayed(
    const Duration(seconds: 1),
    () async {
      try {
        // Check if WhatsApp can be opened
        if (await canLaunchUrl(whatsappUrl)) {
          await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("❌ WhatsApp not installed or cannot be opened!"),
            ),
          );
        }
      } catch (e) {
        print("Error launching WhatsApp: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("⚠️ Error launching WhatsApp")),
        );
      }
    },
  );
                              },
                              icon: const Icon(
                                Icons.check,
                                color: Colors.white,
                              ),
                              label: const Text(
                                "Mark Done",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFdf711a),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 6,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget infoRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, color: Colors.white70, size: 20),
          const SizedBox(width: 8),
          Text(
            "$title: ",
            style: const TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: Colors.white, fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF3E0),

      body: SafeArea(
        child: Column(
          children: [
            // 🔹 Header Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Onboarding(),
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.black87,
                      size: 26,
                    ),
                  ),
                  const Text(
                    "Bookings Dashboard",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      getBookingsOnLoad();
                    },
                    icon: const Icon(Icons.refresh, color: Colors.black87),
                  ),
                ],
              ),
            ),

            // 🔹 Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) => setState(() {}),
                  decoration: const InputDecoration(
                    hintText: "Search by name or service...",
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                  ),
                ),
              ),
            ),

            // 🔹 Bookings List
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : allBookings(),
            ),
          ],
        ),
      ),
    );
  }
}
