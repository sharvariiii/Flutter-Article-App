import 'package:flutter/material.dart';
import '../models/article.dart';
import '../services/api_service.dart';
import '../widgets/article_card.dart';
import '../widgets/search_bar.dart';
import 'package:lottie/lottie.dart';

// Home screen of the app
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiService _api = ApiService(); // To fetch articles from API
  late Future<List<Article>> _futureArticles; // Future for article loading
  List<Article> _allArticles = []; // Stores all fetched articles
  List<Article> _filteredArticles = []; // Stores search-filtered articles

  @override
  void initState() {
    super.initState();
    // Load data with a loading animation on screen start
    _futureArticles = _simulateLoading();
  }

  // Shows loading for 2 seconds, then fetches articles
  Future<List<Article>> _simulateLoading() async {
    await Future.delayed(Duration(seconds: 2)); // Delay to show loading
    try {
      List<Article> articles = await _api.fetchArticles(); // Fetch from API
      setState(() {
        _allArticles = articles; // Save all articles
        _filteredArticles = articles; // Initially show all
      });
      return articles;
    } catch (error) {
      // print("Error fetching data: $error");
      return []; // Return empty list if API call fails
    }
  }

  // Filters articles based on user search input
  void _onSearch(String query) {
    setState(() {
      _filteredArticles = _allArticles.where((article) {
        return article.title.toLowerCase().contains(query.toLowerCase()) ||
            article.body.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    const primaryBlue = Color(0xFF5E60CE); // App's primary theme color

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App title
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
              child: Center(
                child: Text(
                  'Articles',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: primaryBlue,
                      ),
                ),
              ),
            ),

            // Custom animated search bar
            AnimatedSearchBar(onChanged: _onSearch),

            // Main content area
            Expanded(
              child: FutureBuilder<List<Article>>(
                future: _futureArticles,
                builder: (context, snapshot) {
                  // Show loading animation while waiting for data
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Lottie.asset(
                        'assets/animations/loading.json',
                        width: 120,
                        height: 182,
                        repeat: true,
                      ),
                    );
                  }

                  // Show error message if data fetching fails
                  if (snapshot.hasError) {
                    //print('Error: ${snapshot.error}');
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset(
                              'assets/animations/empty.json',
                              width: 120,
                              height: 120,
                              repeat: true,
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'Error loading articles. Please try again.',
                              style: TextStyle(
                                color: Color(0xFF5E60CE),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  // Once data is loaded
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      // Articles already saved in _simulateLoading
                    } else {
                      // No data found
                      _allArticles = [];
                      _filteredArticles = [];
                    }
                  }

                  // No results match the search
                  if (_filteredArticles.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset(
                              'assets/animations/empty.json',
                              width: 120,
                              height: 120,
                              repeat: true,
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'No articles match your search.',
                              style: TextStyle(
                                color: Color(0xFF5E60CE),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  // Show list of filtered articles
                  return RefreshIndicator(
                    onRefresh: () async {
                      final articles = await _api.fetchArticles();
                      setState(() {
                        _allArticles = articles;
                        _filteredArticles = articles;
                      });
                    },
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(bottom: 80),
                      itemCount: _filteredArticles.length,
                      itemBuilder: (context, index) {
                        return ArticleCard(article: _filteredArticles[index]);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
