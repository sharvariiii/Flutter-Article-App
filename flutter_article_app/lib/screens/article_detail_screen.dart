import 'package:flutter/material.dart';
import '../models/article.dart';

// Stateless widget that displays detailed content of a selected article
class ArticleDetailScreen extends StatelessWidget {
  final Article article; // Article object passed to the screen

  const ArticleDetailScreen({required this.article, super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const primaryBlue = Color(0xFF5E60CE);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Article Details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: primaryBlue,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0, // Removes shadow under the app bar
        iconTheme: const IconThemeData(color: primaryBlue),
      ),

      // Body with scrollable content
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),

        // Content is laid out in a vertical column
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Centered and underlined article title
            Center(
              child: Text(
                article.title,
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Black title for better readability
                  decoration: TextDecoration.underline, // Adds an underline
                ),
              ),
            ),
            const SizedBox(height: 24),

            Text(
              article.body,
              style: theme.textTheme.bodyLarge?.copyWith(
                height: 1.6,
                fontSize: 16,
              ),
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
