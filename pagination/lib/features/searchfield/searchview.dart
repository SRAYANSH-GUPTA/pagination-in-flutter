import 'package:flutter/material.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import '../../globalvar.dart' as globals; // Import the globals file
import '../search/searchviewandviewmodel.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          buildFloatingSearchBar(context), // Pass context here
        ],
      ),
    );
  }

  Widget buildFloatingSearchBar(BuildContext context) { // Accept context here
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      hint: 'Search...',
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),
      onSubmitted: (query) {
        globals.searchq = query; // Store the search query in the global variable
        Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LectureSearchPage()),
                  );
        print('Search query stored: ${globals.searchq}');
      },
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: Container(
              height: 50,
              alignment: Alignment.center,
              child: const Text('Search for items above'),
            ),
          ),
        );
      },
    );
  }
}
