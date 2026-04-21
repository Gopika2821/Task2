import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GalleryScreen(),
    );
  }
}

class GalleryScreen extends StatelessWidget {

  final List<String> images = [
    'assets/img1.jpg',
    'assets/img2.jpg',
    'assets/img3.jpg',
    'assets/img4.jpg',
    'assets/img5.jpg',
    'assets/img6.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GOPIKA Photos"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // 🔹 Top Horizontal Cards
            SizedBox(
              height: 180,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  buildTopCard("1 Year ago", 'assets/img1.jpg'),
                  buildTopCard("Today", 'assets/img2.jpg'),
                  buildTopCard("Few days ago", 'assets/img3.jpg'),
                ],
              ),
            ),

            // 🔹 Section 1
            buildSection("Sat 10 Jun", "Kancheepuram"),
            buildGrid(),

            // 🔹 Section 2
            buildSection("Sat 08 Jun", "Chennai"),
            buildGrid(),

            // 🔹 Section 3
            buildSection("Sat 08 Jun", "Chengalpattu"),
            buildGrid(),
          ],
        ),
      ),
    );
  }

  Widget buildTopCard(String title, String img) {
    return Container(
      width: 140,
      margin: EdgeInsets.all(8),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(img, fit: BoxFit.cover, height: 180),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          )
        ],
      ),
    );
  }

  Widget buildSection(String date, String location) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(date, style: TextStyle(fontSize: 16)),
                Text(location, style: TextStyle(color: Colors.grey)),
              ]),
          Icon(Icons.check_circle, color: Colors.green)
        ],
      ),
    );
  }

  Widget buildGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: images.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(images[index], fit: BoxFit.cover),
          );
        },
      ),
    );
  }
}