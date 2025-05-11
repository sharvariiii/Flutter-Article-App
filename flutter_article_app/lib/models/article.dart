// Data model for articles
class Article {
  final int id;
  final String title;
  final String body;

  // Constructor with required fields
  Article({required this.id, required this.title, required this.body});

  // Factory method to create an Article from JSON data
  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'], // Parse 'id' from JSON
      title: json['title'], // Parse 'title' from JSON
      body: json['body'], // Parse 'body' from JSON
    );
  }
}
