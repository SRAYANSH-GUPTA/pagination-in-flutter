import 'package:flutter/material.dart';
import 'package:gradients_elevation_buttons/gradients_elevation_buttons.dart';
import '../searchfield/searchview.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ImageIcon(
     AssetImage("assets/lab.jpg"),
     color: Colors.red,
     size: 24,
),
        actions: [
          IconButton(
            onPressed: () {
              // Action for notifications
            },
            icon: const Icon(Icons.notifications_none),
          ),
          IconButton(
            onPressed: () {
              // Action for profile
            },
            icon: const Icon(Icons.person),
          ),
        ],
      ),
      body: SafeArea( // Keep the SafeArea
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 0.0, left: 60.0, right: 60.0),
              child: Image.asset('assets/google.jpg'),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GradientElevatedButtons( // Corrected from GradientElevatedButtons to GradientElevatedButton
                backgroundGradient: LinearGradient(
                  colors: [
                    const Color.fromARGB(255, 205, 225, 235),
                    const Color.fromARGB(255, 231, 206, 206)
                  ],
                ),
                strokeGradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color.fromARGB(255, 238, 209, 209),
                    const Color.fromARGB(255, 243, 205, 205)
                  ],
                ),
                onPressed: () {
                  // Action to navigate to LectureSearchPage
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchPage()),
                  );
                },
                borderWidth: 2.0,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: 250,
                    child: Row( // Center the icon and text
                      children: [
                        Icon(Icons.search),
                        const SizedBox(width: 8), // Add space between the icon and text
                        const Text('Search'),
                      ],
                    ),
                  ),
                ),
                borderRadius: 60.0,
                elevation: 8.0,
              ),
            ),
            // New buttons below the elevated button
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Action for first button
                  },
                  child: Icon(Icons.image_search),
                ),
                const SizedBox(width: 10), // Space between buttons
                ElevatedButton(
                  onPressed: () {
                    // Action for second button
                  },
                  child: Icon(Icons.translate),
                ),
                const SizedBox(width: 10), // Space between buttons
                ElevatedButton(
                  onPressed: () {
                    // Action for second button
                  },
                  child: Icon(Icons.school_outlined),
                ),
                const SizedBox(width: 10), // Space between buttons
                ElevatedButton(
                  onPressed: () {
                    // Action for second button
                  },
                  child: Icon(Icons.music_note),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
