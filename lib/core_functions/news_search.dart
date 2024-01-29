import 'package:flutter/material.dart';
import 'package:matter_news/core_functions/news_home.dart';

class NewsSearch extends StatefulWidget {
  @override
  _NewsSearchState createState() => _NewsSearchState();
}

class _NewsSearchState extends State<NewsSearch> {
  TextEditingController _searchController = TextEditingController();

  void _onSearch() {
    String query = _searchController.text;
    // Add your search functionality here
    print('Search query: $query');
    // Implement your search logic or navigate to the search results screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('About'),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: const Color.fromARGB(255, 255, 255, 255),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewsHome()),
            );
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Move circle avatar and text up
        children: [
          const CircleAvatar(
            radius: 100,
            backgroundImage: AssetImage('assets/icon.png'),
          ),
          const SizedBox(height: 20),
          const Text(
            "Hello There!\n MatterNews basic android native news app created using Flutter & newsapi.org REST API.It gives realtime news around the world in a few minutes. This application made for university coursework.\n\n Created by: Lavan Edirisinghe\n K2324132 / E190362\n\n\n\n\n",
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: NewsSearch(),
  ));
}