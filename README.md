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
- State Management: setState
- Persistence: shared_preferences
## State Management Explanation
- State Management:StatefulWidget (setState)
This implementation uses Flutter’s built-in StatefulWidget and setState() for state management. UI updates (like showing/hiding the clear icon or handling text input) are triggered by calling setState(), which rebuilds the widget tree locally. Data flows from the input field to the parent widget through the onChanged callback.

## Known Issues / Limitations
- Scalability: Using setState() is simple but becomes harder to maintain as the app grows in complexity.
- Global Access: There's no global state sharing, so communication between multiple widgets/pages isn’t possible without lifting the state up or using other state managers like Provider or Riverpod.
- UI Behavior: The debounced input delay (300ms) might feel slightly laggy for fast typists.

## Screenshots

### **1. Loader, Home Page, Added to Favorites**
<table>
  <tr>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/0463b5ef-03f3-46b3-b234-3835058af2c2" alt="loader" width="250"/>
      <br><b>Loader</b>
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/f37a5c18-e066-423b-8ce8-c59a771c671e" alt="Home Page" width="250"/>
      <br><b>Home Page</b>
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/8ca09087-3902-46d3-a620-29eaeff5f78e" alt="Added to Favorites" width="250"/>
      <br><b>Added to Favorites</b>
    </td>
  </tr>
</table>

---

### **2. Removed from Favorites, Not Found, Found**
<table>
  <tr>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/faaba9f4-235a-44bc-a503-264583550549" alt="Removed from Favorites" width="250"/>
      <br><b>Removed from Favorites</b>
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/428e6876-af21-4cb4-a964-137952217e7c" alt="Not Found" width="250"/>
      <br><b>Not Found</b>
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/eb6a6872-098d-4ddd-82f6-f20307cd3909" alt="Found" width="250"/>
      <br><b>Found</b>
    </td>
  </tr>
</table>

---

### **3. No Favorites Yet, Article Details Page, Favorites Page**
<table>
  <tr>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/a174bcd4-dd45-4dc0-83c0-4d1df0edb9b1" alt="No Favorites Yet" width="250"/>
      <br><b>No Favorites Yet</b>
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/5f354ecd-8da2-4ea1-967a-eccb07c1ff91" alt="Article Details Page" width="250"/>
      <br><b>Article Details Page</b>
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/cb1f2234-16eb-451b-9a45-600b16032497" alt="Favorites Page" width="250"/>
      <br><b>Favorites Page</b>
    </td>
  </tr>
</table>

---
