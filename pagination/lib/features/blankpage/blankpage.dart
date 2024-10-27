import 'package:flutter/material.dart';

class BlankPage extends StatelessWidget {
  final String pageName;

  const BlankPage({super.key, required this.pageName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pageName),
      ),
      body: Center(
        child: Text(
          'This is the $pageName page.',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

