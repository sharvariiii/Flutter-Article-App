// Custom widget to display an article as a styled card with favorite toggle
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/article.dart';
import '../state/article_provider.dart';
import '../screens/article_detail_screen.dart';

class ArticleCard extends StatefulWidget {
  final Article article; // Article data passed to this card

  const ArticleCard({super.key, required this.article});

  @override
  State<ArticleCard> createState() => _ArticleCardState();
}

class _ArticleCardState extends State<ArticleCard>
    with SingleTickerProviderStateMixin {
  late bool isFavorite; // Tracks if the article is marked as favorite
  late AnimationController _controller; // Controls bounce animation

  @override
  void initState() {
    super.initState();

    // Initialize favorite state from provider
    final provider = Provider.of<ArticleProvider>(context, listen: false);
    isFavorite = provider.favorites.contains(widget.article.id);

    // Set up animation controller for heart icon bounce effect
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  // Toggles favorite state, shows bounce animation and snackbar feedback
  void _toggleFavorite(BuildContext context) async {
    final provider = Provider.of<ArticleProvider>(context, listen: false);

    // Update provider's favorite state
    await provider.toggleFavorite(widget.article.id);

    // Update local favorite state
    setState(() {
      isFavorite = !isFavorite;
    });

    // Run bounce animation
    _controller.forward().then((_) => _controller.reverse());

    // Display appropriate message and color
    final message =
        isFavorite ? 'Added to favorites' : 'Removed from favorites';
    final bgColor = isFavorite
        ? const Color(0xFF4CAF50) // Green
        : const Color(0xFFE53935); // Red

    // Show snackbar with action feedback
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: bgColor,
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // Clean up animation controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(2, 2),
          ),
        ],
      ),

      // ListTile displays article content and favorite icon
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),

        // Display article title
        title: Text(
          widget.article.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),

        // Display a snippet of the article body
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            widget.article.body.length > 80
                ? '${widget.article.body.substring(0, 80)}...'
                : widget.article.body,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),

        // Favorite icon with bounce animation
        trailing: ScaleTransition(
          scale: Tween<double>(begin: 1.0, end: 1.1).animate(
            CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
          ),
          child: IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.grey,
            ),
            onPressed: () => _toggleFavorite(context),
            tooltip: isFavorite ? 'Remove from favorites' : 'Add to favorites',
          ),
        ),

        // On tap, navigate to article detail screen
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ArticleDetailScreen(article: widget.article),
            ),
          );
        },
      ),
    );
  }
}
