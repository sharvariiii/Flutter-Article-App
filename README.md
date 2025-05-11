# Flutter-Article-App

A Flutter app that fetches and displays a list of articles from a public
API.
## Features
- List of articles
- Search functionality
- Detail view
- Responsive UI
## Setup Instructions
1. Clone the repo:
git clone <your-repo-link>
cd flutter_article_app
2. Install dependencies:
flutter pub get
3. Run the app:
flutter run
## Tech Stack
- Flutter SDK: 3.24.5
- State Management: Provider
- HTTP Client: [http/dio]
- Persistence: shared_preferences
## State Management Explanation
- State Management:StatefulWidget (setState)
This implementation uses Flutter’s built-in StatefulWidget and setState() for state management. UI updates (like showing/hiding the clear icon or handling text input) are triggered by calling setState(), which rebuilds the widget tree locally. Data flows from the input field to the parent widget through the onChanged callback.

## Known Issues / Limitations
-Scalability: Using setState() is simple but becomes harder to maintain as the app grows in complexity.
- Global Access: There's no global state sharing, so communication between multiple widgets/pages isn’t possible without lifting the state up or using other state managers like Provider or Riverpod.
- UI Behavior: The debounced input delay (300ms) might feel slightly laggy for fast typists.

## Screenshots

