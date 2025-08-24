// Category system for organizing grocery items.
//
// This file defines the category structure used throughout the shopping list
// application. It includes an enumeration of all available categories and
// a [Category] class that associates display names with colors.

import 'package:flutter/widgets.dart';

/// Enumeration of all available grocery item categories.
///
/// This enum defines the complete set of categories that grocery items
/// can be assigned to.
///
/// The categories are designed to cover common grocery shopping needs:
/// - Food categories: [vegetables], [fruit], [meat], [dairy], [carbs], [sweets], [spices]
/// - Non-food categories: [convenience], [hygiene], [other]
enum Categories {
  vegetables,
  fruit,
  meat,
  dairy,
  carbs,
  sweets,
  spices,
  convenience,
  hygiene,
  other,
}

/// Represents a grocery item category with display information.
///
/// This class is immutable and designed to be used with the
/// [Categories] enum to create a complete category system.
///
/// Example usage:
/// const vegetableCategory = Category(
///   'Vegetables',
///   Color.fromARGB(255, 0, 255, 128),
/// );

class Category {
  /// Creates a new [Category] with the specified name and color.
  /// Parameters:
  /// - [name]: The display name for this category (e.g., "Vegetables")
  /// - [color]: The color associated with this category for UI representation
  const Category(this.name, this.color);

  final String name;
  final Color color;
}
