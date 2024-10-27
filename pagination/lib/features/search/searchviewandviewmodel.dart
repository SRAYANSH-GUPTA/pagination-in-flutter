import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'searchmodel.dart'; // Ensure your model classes are imported
import '../../globalvar.dart' as globals;
import 'package:gradients_elevation_buttons/gradients_elevation_buttons.dart';
import '../searchfield/searchview.dart';

class LectureSearchPage extends StatefulWidget {
  const LectureSearchPage({super.key});

  @override
  _LectureSearchPageState createState() => _LectureSearchPageState();
}

class _LectureSearchPageState extends State<LectureSearchPage> {
  int _currentPage = 1; // Track the current page
  final List<Item> _items = []; // List to store fetched items
  bool _isLoadingMore = false; // To track loading state for pagination
  bool _hasMoreResults = true; // Flag to track if more results are available
  bool _isLoadingInitial = true; // Flag for initial loading state

  @override
  void initState() {
    super.initState();
    _fetchLectures(); // Fetch lectures on init
  }

  Future<SearchResponse?> fetchLectures({int startIndex = 1}) async {
    const apiKey = 'AIzaSyDgyjGH9bB1EV0vLRVUgZchTaDemRLFmGw'; // Replace with your actual API key
    const cx = 'c3098012a10bf496a'; // Replace with your actual CX
    final query = globals.searchq; // Use the query you want
    const numResults = 10; // Number of results per page

    final url = Uri.parse(
      'https://www.googleapis.com/customsearch/v1?key=$apiKey&cx=$cx&q=$query&num=$numResults&start=$startIndex',
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        print('API Response: $data');
        
        final searchResponse = SearchResponse.fromJson(data);
        return searchResponse; // Return the parsed SearchResponse
      } else {
        print('Request failed with status: ${response.statusCode}');
        print('Response body: ${response.body}');
        return null; // Return null in case of error
      }
    } catch (e) {
      print('An error occurred: $e');
      return null; // Return null in case of exception
    }
  }

  Future<void> _fetchLectures() async {
    if (!_hasMoreResults || _isLoadingMore) return; // Don't fetch if no more results available or already loading

    setState(() {
      _isLoadingMore = true; // Set loading state
    });

    final searchResponse = await fetchLectures(startIndex: (_currentPage - 1) * 10 + 1);
    if (searchResponse != null) {
      setState(() {
        _items.addAll(searchResponse.items); // Add fetched items to the list
        // Check if there are fewer results than expected
        if (searchResponse.items.length < 10) {
          _hasMoreResults = false; // No more results to fetch
        }
        _isLoadingInitial = false; // Set initial loading to false
      });
    } else {
      _hasMoreResults = false; // Handle null response gracefully
    }

    setState(() {
      _isLoadingMore = false; // Reset loading state
    });
  }

  void _showLinkDialog(String url) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Link'),
          content: Text(url),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _loadMore() async {
    if (_hasMoreResults) {
      _currentPage++;
      await _fetchLectures();
    }
  }

  Widget _buildCategoryButton(BuildContext context, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ElevatedButton(
        onPressed: () {
          // Define what happens when the button is pressed
          print('Selected Category: $label');
        },
        child: Text(label),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.flaky_sharp),
        ),
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.only(left: 45, top: 10),
            child: Image.asset(
              'assets/google.jpg',
              height: 45,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: GradientElevatedButtons(
              backgroundGradient: LinearGradient(
                colors: [
                  const Color.fromARGB(255, 255, 255, 255),
                  const Color.fromARGB(255, 255, 255, 255),
                ],
              ),
              strokeGradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color.fromARGB(255, 255, 255, 255),
                  const Color.fromARGB(255, 255, 255, 255),
                ],
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchPage()),
                );
              },
              borderWidth: 1.0,
              borderRadius: 60.0,
              elevation: 8.0,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  width: 250,
                  height: 20,
                  child: Row(
                    children: [
                      const Icon(Icons.search),
                      const SizedBox(width: 8),
                      Text(globals.searchq),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            child: Padding(padding: EdgeInsets.all(10.0),
              child: SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildCategoryButton(context, "All"),
                    _buildCategoryButton(context, "Images"),
                    _buildCategoryButton(context, "News"),
                    _buildCategoryButton(context, "Videos"),
                    _buildCategoryButton(context, "Shopping"),
                    _buildCategoryButton(context, "Web"),
                    _buildCategoryButton(context, "Maps"),
                    _buildCategoryButton(context, "Short Videos"),
                    _buildCategoryButton(context, "Books"),
                    _buildCategoryButton(context, "Flights"),
                    _buildCategoryButton(context, "Finance"),
                    _buildCategoryButton(context, "Search tools"),
                    _buildCategoryButton(context, "Feedback"),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: _isLoadingInitial
                ? const Center(child: CircularProgressIndicator()) // Show loading initially
                : ListView.builder(
                    itemCount: _items.length + 1, // Include one more for the loading indicator
                    itemBuilder: (context, index) {
                      if (index == _items.length) {
                        // Loading more indicator
                        if (_isLoadingMore) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (!_hasMoreResults) {
                          return const Center(child: Text('No more results available.'));
                        } else {
                          return TextButton(
                            onPressed: _loadMore,
                            child: const Text('Load More'),
                          );
                        }
                      }

                      // Display the item
                      final item = _items[index];
                      return Padding(padding: EdgeInsets.all(10.0),
                        child: Container(decoration: BoxDecoration(
                            shape: BoxShape.rectangle, // BoxShape.circle or BoxShape.retangle
                            //color: const Color(0xFF66BB6A),
                            boxShadow: [BoxShadow(
                              color: const Color.fromARGB(26, 255, 255, 255),
                              blurRadius: 5.0,
                            ),]
                          ),
                          child: ListTile(
                            title: Text(item.title),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    _showLinkDialog(item.link);
                                  },
                                  child: Text(
                                    item.displayLink,
                                    style: const TextStyle(color: Colors.blue),
                                  ),
                                ),
                                Text(item.snippet),
                              ],
                            ),
                            onTap: () {
                              print('Opening: ${item.link}');
                            },
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
