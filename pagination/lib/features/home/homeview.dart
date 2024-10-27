import 'package:flutter/material.dart';
import 'package:gradients_elevation_buttons/gradients_elevation_buttons.dart';
import '../searchfield/searchview.dart';
import '../blankpage/blankpage.dart';

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
        title: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const BlankPage(pageName: 'Search Labs')),
            );
          },
          child: const ImageIcon(
            AssetImage("assets/lab.jpg"),
            color: Colors.red,
            size: 24,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BlankPage(pageName: 'Notifications')),
              );
            },
            icon: const Icon(Icons.notifications_none),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BlankPage(pageName: 'Profile')),
              );
            },
            icon: const Icon(Icons.person),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 0.0, left: 60.0, right: 60.0),
              child: Image.asset('assets/google.jpg'),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GradientElevatedButtons( // Corrected class name
                backgroundGradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 205, 225, 235),
                    Color.fromARGB(255, 231, 206, 206),
                  ],
                ),
                strokeGradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromARGB(255, 238, 209, 209),
                    Color.fromARGB(255, 243, 205, 205),
                  ],
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchPage()),
                  );
                },
                borderWidth: 2.0,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SizedBox(
                    width: 250,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.search),
                        SizedBox(width: 8),
                        Text('Search'),
                      ],
                    ),
                  ),
                ),
                borderRadius: 60.0,
                elevation: 8.0,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const BlankPage(pageName: 'Image search')),
                    );
                  },
                  child: const Icon(Icons.image_search),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const BlankPage(pageName: 'Translate')),
                    );
                  },
                  child: const Icon(Icons.translate),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const BlankPage(pageName: 'Homework')),
                    );
                  },
                  child: const Icon(Icons.school_outlined),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const BlankPage(pageName: 'Music')),
                    );
                  },
                  child: const Icon(Icons.music_note),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
