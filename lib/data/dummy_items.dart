// DEPRICATED
// Sample grocery items for development and testing purposes.
//
// This file contains dummy data used to populate the shopping list during
// development and demonstration.

import 'package:shopping_list_app/data/categories.dart';
import 'package:shopping_list_app/models/catagory.dart';
import 'package:shopping_list_app/models/grocery_item.dart';

/// A predefined list of sample grocery items for development and testing.
///
/// Usage example:
/// ListView.builder(
///   itemCount: groceryItems.length,
///   itemBuilder: (context, index) => Text(groceryItems[index].name),
/// )

final groceryItems = [
  // Dairy category example - common household staple
  GroceryItem(
    id: 'a',
    name: 'Milk',
    quantity: 1,
    category: categories[Categories.dairy]!, // Non-null assertion safe here
  ),

  // Fruit category example - multiple quantity item
  GroceryItem(
    id: 'b',
    name: 'Bananas',
    quantity: 5, // Realistic quantity for bananas
    category: categories[Categories.fruit]!,
  ),

  // Meat category example - premium single item
  GroceryItem(
    id: 'c',
    name: 'Beef Steak',
    quantity: 1,
    category: categories[Categories.meat]!,
  ),
];
