import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'screens/favorites_screen.dart';
import 'state/article_provider.dart';

void main() {
  runApp(
    // MultiProvider allows managing multiple state providers
    MultiProvider(
      providers: [
        // Register ArticleProvider and load saved favorites on app start
        ChangeNotifierProvider(
          create: (_) => ArticleProvider()..loadFavorites(),
        ),
      ],
      child: const ArticleApp(), // Launch the main app widget
    ),
  );
}

// The root widget of the app
class ArticleApp extends StatelessWidget {
  const ArticleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Article App',

      // Set the light theme for the app
      theme: ThemeData(
        primaryColor: const Color(0xFF5E60CE),
        scaffoldBackgroundColor: const Color(0xFFF9FAFB),
        cardColor: const Color(0xFFFFFFFF),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF1C1C1E),
          elevation: 0,
        ),
        iconTheme: const IconThemeData(color: Color(0xFF5E60CE)),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Color(0xFF1C1C1E)),
          titleMedium: TextStyle(fontWeight: FontWeight.bold),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Color(0xFF5E60CE),
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.white,
        ),
      ),

      // The initial screen of the app with bottom navigation
      home: const MainTabController(),
    );
  }
}

// Widget to handle bottom navigation between screens
class MainTabController extends StatefulWidget {
  const MainTabController({super.key});

  @override
  State<MainTabController> createState() => _MainTabControllerState();
}

class _MainTabControllerState extends State<MainTabController> {
  int _currentIndex = 0; // Tracks which tab is selected

  // List of screens corresponding to each bottom tab
  final List<Widget> _screens = const [
    HomeScreen(), // First tab: Home screen
    FavoritesScreen(), // Second tab: Favorites screen
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Show the screen based on the selected tab
      body: _screens[_currentIndex],

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // Highlight selected tab
        onTap: (index) {
          // Update selected tab when user taps
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          // Home tab icon and label
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),

          // Favorites tab icon with badge
          BottomNavigationBarItem(
            icon: Stack(
              children: [
                const Icon(Icons.favorite), // Base icon

                // Badge overlay showing number of favorite articles
                Positioned(
                  right: 0,
                  child: Consumer<ArticleProvider>(
                    builder: (context, provider, _) {
                      // Only show badge if there are favorite items
                      return provider.favorites.isEmpty
                          ? const SizedBox() // Hide if no favorites
                          : Container(
                              padding: const EdgeInsets.all(2), // Badge padding
                              decoration: const BoxDecoration(
                                color: Colors.red, // Badge color
                                shape: BoxShape.circle,
                              ),
                              constraints: const BoxConstraints(
                                minWidth: 16,
                                minHeight: 16,
                              ),
                              child: Text(
                                provider.favorites.length.toString(), // Count
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            );
                    },
                  ),
                ),
              ],
            ),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
