import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'searchmodel.dart'; // Ensure your model classes are imported
import '../../globalvar.dart' as globals;
import 'package:gradients_elevation_buttons/gradients_elevation_buttons.dart';
import '../searchfield/searchview.dart';
import '../blankpage/blankpage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LectureSearchPage extends StatefulWidget {
  const LectureSearchPage({super.key});

  @override
  _LectureSearchPageState createState() => _LectureSearchPageState();
}

class _LectureSearchPageState extends State<LectureSearchPage> {
  int _currentPage = 1; 
  final List<Item> _items = []; 
  bool _isLoadingMore = false; 
  bool _hasMoreResults = true; 
  bool _isLoadingInitial = true; 

  @override
  void initState() {
    super.initState();
    _fetchLectures(); // Fetch lectures on init
  }

  Future<SearchResponse?> fetchLectures({int startIndex = 1}) async {
    final apiKey = dotenv.env['apiKey']; 
    final cx = dotenv.env['cx']; 
    final query = globals.searchq; 
    const numResults = 10; 

    final url = Uri.parse(
      'https://www.googleapis.com/customsearch/v1?key=$apiKey&cx=$cx&q=$query&num=$numResults&start=$startIndex',
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        print('API Response: $data');

        final searchResponse = SearchResponse.fromJson(data);
        return searchResponse; 
      } else {
        print('Request failed with status: ${response.statusCode}');
        print('Response body: ${response.body}');
        return null; 
      }
    } catch (e) {
      print('An error occurred: $e');
      return null; 
    }
  }

  Future<void> _fetchLectures() async {
    if (!_hasMoreResults || _isLoadingMore) return; 

    setState(() {
      _isLoadingMore = true; 
    });

    final searchResponse = await fetchLectures(startIndex: (_currentPage - 1) * 10 + 1);
    if (searchResponse != null) {
      setState(() {
        _items.addAll(searchResponse.items); 
      
        if (searchResponse.items.length < 10) {
          _hasMoreResults = false; 
        }
        _isLoadingInitial = false; 
      });
    } else {
      _hasMoreResults = false;
    }

    setState(() {
      _isLoadingMore = false; 
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
                Navigator.of(context).pop(); 
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
          icon: InkWell(onTap: ()
          {
           Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const BlankPage(pageName: 'Search Labs')),
                    );
          },
            child: Image.asset("assets/lab.jpg")),
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
            icon: InkWell(onTap: () => {
              Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const BlankPage(pageName: 'Profile')),
                    )
            },
              child: Icon(Icons.person)),
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
          Padding(
            padding: const EdgeInsets.all(10.0),
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
          Expanded(
            child: _isLoadingInitial
                ? const Center(child: CircularProgressIndicator()) 
                : ListView.builder(
                    itemCount: _items.length + 1, 
                    itemBuilder: (context, index) {
                      if (index == _items.length) {
                  
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

              
                      final item = _items[index];
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle, 
                            color: const Color.fromARGB(255, 255, 255, 255), 
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromARGB(26, 255, 255, 255),
                                blurRadius: 5.0,
                              ),
                            ],
                          ),
                          child: ListTile(
                            title: Text(item.title),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: item.pagemap.cseThumbnail.isNotEmpty
                                          ? NetworkImage(item.pagemap.cseThumbnail[0].src) 
                                          : const NetworkImage('https://via.placeholder.com/150'), 
                                    ),
                                    const SizedBox(width: 8), 
                                    TextButton(
                                      onPressed: () {
                                        _showLinkDialog(item.link);
                                      },
                                      child: Text(
                                        item.displayLink,
                                        style: const TextStyle(color: Colors.blue),
                                      ),
                                    ),
                                  ],
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
