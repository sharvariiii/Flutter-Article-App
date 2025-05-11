import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/article_provider.dart';
import '../models/article.dart';
import '../widgets/article_card.dart';
import '../services/api_service.dart';
import 'package:lottie/lottie.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final ApiService _api =
      ApiService(); // Instance of API service to fetch articles
  late Future<List<Article>> _articles; // Future to hold fetched articles

  @override
  void initState() {
    super.initState();
    // Load all articles from the API once when the screen initializes
    _articles = _api.fetchArticles();
  }

  @override
  Widget build(BuildContext context) {
    // Access the list of favorited article IDs from the provider
    final favorites = Provider.of<ArticleProvider>(context).favorites;

    return Scaffold(
      // App bar with centered title and custom styling
      appBar: AppBar(
        title: const Text(
          'Favorites',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF5E60CE),
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),

      // Body uses FutureBuilder to fetch and display articles
      body: FutureBuilder<List<Article>>(
        future: _articles,
        builder: (context, snapshot) {
          // Show spinner while waiting for data
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Show error if something goes wrong during fetch
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          // Filter only articles whose IDs exist in the favorites list
          final favoriteArticles = snapshot.data!
              .where((article) => favorites.contains(article.id))
              .toList();

          // If no favorites, show empty state animation and message
          if (favoriteArticles.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/animations/empty.json',
                    width: 120,
                    height: 120,
                    repeat: true,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'No favorites yet!',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF5E60CE),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          // Show list of favorite articles with pull-to-refresh
          return RefreshIndicator(
            onRefresh: () async {
              // Re-fetch articles and update state
              final articles = await _api.fetchArticles();
              setState(() {
                _articles = Future.value(articles);
              });
            },
            child: ListView.builder(
              itemCount: favoriteArticles.length,
              padding: const EdgeInsets.only(bottom: 80),
              itemBuilder: (context, index) {
                // Display each article using a custom card widget
                return ArticleCard(article: favoriteArticles[index]);
              },
            ),
          );
        },
      ),
    );
  }
}
