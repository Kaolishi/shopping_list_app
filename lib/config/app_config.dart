/// Application configuration constants.
/// 
/// This file contains configuration values used throughout the app.
/// For production apps, consider using environment variables or
/// secure configuration management.

class AppConfig {
  /// Firebase Realtime Database base URL
  /// 
  /// TODO: Replace with your actual Firebase URL before running the app
  /// In a production app, this should be loaded from environment
  /// variables or a secure configuration system.
  static const String firebaseBaseUrl = 'your-firebase-project.firebasedatabase.app';
  
  /// API endpoints
  static const String shoppingListEndpoint = 'shopping-list.json';
  
  /// Build a complete Firebase URL for the given endpoint
  static Uri buildFirebaseUrl(String endpoint) {
    return Uri.https(firebaseBaseUrl, endpoint);
  }
}
