/// A model class representing a grocery item in the shopping list.
///
/// This file defines the [GroceryItem] class which serves as the data model
/// for individual grocery items throughout the application. Each grocery item
/// contains information about its identity, name, quantity, and category.

import 'package:shopping_list_app/models/catagory.dart';

/// Represents a single grocery item with all its essential properties.
///
/// A [GroceryItem] is an immutable data class that encapsulates information
/// about a grocery item including its unique identifier, display name,
/// quantity needed, and the category it belongs to.
///
/// Example usage:
/// final item = GroceryItem(
///   id: 'milk_001',
///   name: 'Whole Milk',
///   quantity: 2,
///   category: categories[Categories.dairy]!,
/// );

class GroceryItem {
  /// Creates a new [GroceryItem] with the specified properties：
  /// - [id]: A unique identifier for the grocery item
  /// - [name]: The display name of the grocery item
  /// - [quantity]: The number of units needed (must be positive)
  /// - [category]: The category this item belongs to
  ///
  /// The constructor is const, allowing for compile-time optimization
  /// when creating instances with constant values.
  const GroceryItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.category,
  });

  final String id;
  final String name;
  final int quantity;
  final Category category;
}
