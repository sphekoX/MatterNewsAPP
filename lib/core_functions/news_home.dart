import 'package:flutter/material.dart';
import 'package:matter_news/core_functions/news_search.dart';
import 'package:matter_news/core_functions/news_web_view.dart';
import 'package:news_api_flutter_package/model/article.dart';
import 'package:news_api_flutter_package/news_api_flutter_package.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsHome extends StatefulWidget {
  const NewsHome({super.key});

  @override
  State<NewsHome> createState() => _NewsHomeState();
}

Future<void> _Refresh() {
  return Future.delayed(Duration(seconds: 2));
}

class _NewsHomeState extends State<NewsHome> {
  late Future<List<Article>> future;
  String? searchTerm;
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();
  List<String> categoryItems = [
    "General",
    "Business",
    "Entertainment",
    "Health",
    "Science",
    "Sports",
    "Technology", 
  ];

    late String selectedCategory;

  @override
  void initState() {
    selectedCategory = categoryItems[0];
    future = getNewsData();

    super.initState();
  }

  Future<List<Article>> getNewsData() async {
    NewsAPI newsAPI = NewsAPI("6e9b60708dc54d5d9a6b304925b4f597");
    return await newsAPI.getTopHeadlines(
      country: "us",
      query: searchTerm,
      category: selectedCategory,
      pageSize: 50,
    );
  }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isSearching ? searchAppBar() : appBar(),
      body: SafeArea(
          child: Column(
        children: [
          _buildCategories(),
          Expanded(
            child: FutureBuilder(
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text("Error loading the news"),
                  );
                } else {
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    return _buildNewsListView(snapshot.data as List<Article>);
                  } else {
                    return const Center(
                      child: Text("No news available"),
                    );
                  }
                }
              },
              future: future,
            ),
          )
        ],
      )),
    );
  }

  searchAppBar() {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        color: const Color.fromARGB(255, 255, 255, 255),
        onPressed: () {
          setState(() {
            isSearching = false;
            searchTerm = null;
            searchController.text = "";
            future = getNewsData();
          });
        },
      ),
      title: TextField(
        controller: searchController,
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        decoration: const InputDecoration(
          hintText: "Type Anything to Search",
          hintStyle: TextStyle(color: Color.fromARGB(255, 121, 121, 121)),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
        ),
      ),
      actions: [
        IconButton(
          color: const Color.fromARGB(255, 255, 255, 255),
            onPressed: () {
              setState(() {
                searchTerm = searchController.text;
                future = getNewsData();
              });
            },
            icon: const Icon(Icons.search)),      
      ],
    );
  }

  
  

appBar() {
    return AppBar(
      backgroundColor: Color.fromARGB(255, 22, 22, 22),
      title: Text("Latest News ", style: GoogleFonts.tinos().copyWith(color: Color.fromARGB(255, 253, 253, 253),)), // Use copyWith to apply the color style to the GoogleFonts style
      actions: [
        IconButton(
          color: const Color.fromARGB(255, 255, 255, 255),
          onPressed: () {
            setState(() {
              isSearching = true;
            });
          },
          icon: const Icon(Icons.search),
        ),
        IconButton(
          color: const Color.fromARGB(255, 255, 255, 255),
          onPressed: (){ Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => NewsSearch()),
                                    );
             },
          icon: const Icon(Icons.info_outline),
        ),
      ],
    );
  }




  Widget _buildNewsListView(List<Article> articleList) {
    return ListView.builder(
      itemBuilder: (context, index) {
        Article article = articleList[index];
        return _buildNewsItem(article);
      },
      itemCount: articleList.length,
    );
  }

  Widget _buildNewsItem(Article article) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewsWebView(url: article.url!),
            ));
      },
      child: Card(
        elevation: 4,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 80,
                width: 80,
                child: Image.network(
                  article.urlToImage ?? "",
                  fit: BoxFit.fitHeight,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.image_not_supported);
                  },
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title!,
                    maxLines: 2,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    article.source.name!,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return Container(
      height: 50,
      margin: const EdgeInsets.only(top: 10, bottom: 20),
      child: RefreshIndicator(
        onRefresh: _Refresh,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(5),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  selectedCategory = categoryItems[index];
                  future = getNewsData();
                });
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                categoryItems[index] == selectedCategory
                    ? Color.fromARGB(255, 44, 69, 255).withOpacity(0.9)
                    : Color.fromARGB(255, 44, 44, 44),                 
              ),              
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),        
                    
              ),
              
              child: Text(categoryItems[index])
            ),
          );
        },
        itemCount: categoryItems.length,
        scrollDirection: Axis.horizontal,
      ),
    ),
    );
  }

}