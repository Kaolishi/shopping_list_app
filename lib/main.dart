// Entry point for the Shopping List application.

import 'package:flutter/material.dart';
import 'package:shopping_list_app/widgets/grocery_list.dart';

/// The main entry point of the application.
///
/// This function is called when the app starts and initializes the Flutter
/// framework by calling [runApp] with the root widget [MyApp].
void main() {
  runApp(const MyApp());
}

/// The root widget of the shopping list application.
///
/// [MyApp] is a [StatelessWidget] that serves as the top-level widget
/// for the entire application. It configures:
/// - Application title and metadata
/// - Global theme and color scheme
/// - Initial route and home screen

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  /// Returns a [Widget] representing the complete application structure.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Application metadata
      title: 'Flutter Groceries',

      // Theme configuration with dark mode and custom colors
      theme: ThemeData.dark().copyWith(
        // Generate color scheme from seed color with dark brightness
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 147, 229, 250),
          brightness: Brightness.dark,
          surface: const Color.fromARGB(255, 42, 51, 59),
        ),
        // Override scaffold background for consistent app-wide background
        scaffoldBackgroundColor: const Color.fromARGB(255, 50, 58, 60),
      ),

      // Set the initial screen to display the grocery list
      home: const GroceryList(),
    );
  }
}
