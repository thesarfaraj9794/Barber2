import 'package:flutter/material.dart';

class HairStylePage extends StatelessWidget {
  const HairStylePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
     // color: const Color.fromARGB(255, 184, 70, 5), // light grey background
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Hair Styles",
            style: TextStyle(
              fontSize: 23.0,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(221, 240, 39, 173),
            ),
          ),
          const SizedBox(height: 10.0),
          const Text(
            "Find your perfect style",
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
          const SizedBox(height: 15.0),

          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                buildHairStyleCard("assets/images/hear/sort.jpg", "Hair Cut", "₹70"),
                buildHairStyleCard("assets/images/hear/long.jpeg", "Side Fade", "₹70"),
                buildHairStyleCard("assets/images/hear/fade1.webp", "Modern Look", "₹80"),
                buildHairStyleCard("assets/images/hear/top2.jpg", "Long Hair", "₹70"),
                buildHairStyleCard("assets/images/hear/top3.jpg", "Spiky Style", "₹60"),
                buildHairStyleCard("assets/images/hear/taper.jpg", "Spiky Style", "₹60"),
                buildHairStyleCard("assets/images/hear/fade.webp", "Spiky Style", "₹60"),
                buildHairStyleCard("assets/images/hear/sort.jpg", "Spiky Style", "₹70"),
                 buildHairStyleCard("assets/images/hear/long.jpeg", "Spiky Style", "₹70"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHairStyleCard(String imagePath, String name, String price) {
    return Container(
      width: 130,
      margin: const EdgeInsets.only(right: 18),
      child: Stack(
        children: [
          // 🔹 Card with diagonal bottom
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
            ),
          ),
          // 🔹 Bottom overlay
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 55,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  Text(
                    price,
                    style: const TextStyle(
                        color: Colors.greenAccent,
                        fontWeight: FontWeight.w600,
                        fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
