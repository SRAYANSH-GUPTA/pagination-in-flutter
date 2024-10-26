import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'searchmodel.dart'; // Ensure your model classes are imported



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

  @override
  void initState() {
    super.initState();
    _fetchLectures(); // Fetch lectures on init
  }

  Future<SearchResponse?> fetchLectures({int startIndex = 1}) async {
  const apiKey = 'AIzaSyDgyjGH9bB1EV0vLRVUgZchTaDemRLFmGw'; // Replace with your actual API key
  const cx = 'c3098012a10bf496a'; // Replace with your actual CX
  const query = 'ship'; // Use the query you want
  const numResults = 10; // Number of results per page

  final url = Uri.parse(
    'https://www.googleapis.com/customsearch/v1?key=$apiKey&cx=$cx&q=$query&num=$numResults&start=$startIndex'
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
    if (!_hasMoreResults) return; // Don't fetch if no more results available

    final searchResponse = await fetchLectures(startIndex: (_currentPage - 1) * 10 + 1);
    if (searchResponse != null) {
      setState(() {
        _items.addAll(searchResponse.items); // Add fetched items to the list
        // Check if there are fewer results than expected
        if (searchResponse.items.length < 10) {
          _hasMoreResults = false; // No more results to fetch
        }
      });
    } else {
      _hasMoreResults = false; // Handle null response gracefully
    }
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
    if (!_isLoadingMore && _hasMoreResults) {
      setState(() {
        _isLoadingMore = true;
        _currentPage++;
      });
      await _fetchLectures();
      setState(() {
        _isLoadingMore = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lecture Search'),
      ),
      body: ListView.builder(
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
          return ListTile(
            title: Text(item.title),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () {
                    _showLinkDialog(item.link); // Show the link in a dialog
                  },
                  child: Text(
                    item.displayLink,
                    style: const TextStyle(color: Colors.blue), // Make the link look clickable
                  ),
                ),
                Text(item.snippet),
              ],
            ),
            onTap: () {
              print('Opening: ${item.link}');
            },
          );
        },
      ),
    );
  }
}

