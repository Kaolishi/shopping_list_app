# Shopping List App

A Flutter application for managing grocery shopping lists with Firebase backend.

## Features

- ✅ Add grocery items with name, quantity, and category
- ✅ Categorized items with color coding  
- ✅ Swipe to delete items
- ✅ Real-time synchronization with Firebase
- ✅ Material Design dark theme
- ✅ Form validation and error handling
- ✅ Loading states and user feedback

## Setup Instructions

### Prerequisites
- Flutter SDK (3.8.1 or higher)
- Dart SDK
- Firebase account

### Firebase Setup
1. Create a new Firebase project at [https://console.firebase.google.com/](https://console.firebase.google.com/)
2. Enable Firebase Realtime Database
3. Set up database rules for your security requirements
4. Copy your Firebase database URL

### Configuration
1. Clone this repository
2. Run `flutter pub get` to install dependencies
3. **IMPORTANT**: Update the Firebase URL in `lib/config/app_config.dart`:
   ```dart
   static const String firebaseBaseUrl = 'your-actual-firebase-url.firebasedatabase.app';
   ```
4. Run the app with `flutter run`

## Project Structure

```
lib/
├── config/
│   └── app_config.dart          # App configuration (Firebase URL)
├── data/
│   ├── categories.dart          # Category definitions and colors
│   └── dummy_items.dart         # Sample data (for reference)
├── models/
│   ├── catagory.dart           # Category model
│   └── grocery_item.dart       # Grocery item model
└── widgets/
    ├── grocery_list.dart       # Main list screen
    └── new_item.dart          # Add item form
```

## Security Note

This repository does not contain sensitive Firebase credentials. You must configure your own Firebase project and update the configuration file before running the app.

## Technologies Used

- **Flutter**: Cross-platform mobile development framework
- **Dart**: Programming language
- **Firebase Realtime Database**: Backend data storage
- **HTTP Package**: API communication
- **Material Design**: UI components and theming

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Ensure no sensitive data is committed
5. Submit a pull request

## License

This project is for educational purposes.
