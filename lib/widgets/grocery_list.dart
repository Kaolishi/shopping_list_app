// A widget that displays a list of grocery items.

import 'package:flutter/material.dart';
import 'package:shopping_list_app/data/dummy_items.dart';
import 'package:shopping_list_app/widgets/new_item.dart';

/// A stateless widget that displays a list of grocery items in a scrollable view.
///
/// This widget creates a [Scaffold] with an [AppBar] and a [ListView] that shows
/// grocery items from the dummy data. Each item is displayed with:
/// - A colored container representing the item's category
/// - The item's name as the title
/// - The quantity as trailing text

class GroceryList extends StatefulWidget {
  /// Creates a [GroceryList] widget.
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  void _addItem() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => const NewItem()));
  }

  // Builds the widget's UI structure.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar with static title
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [IconButton(onPressed: _addItem, icon: const Icon(Icons.add))],
      ),
      // Main body containing the scrollable list of grocery items
      body: ListView.builder(
        // Total number of items in the list
        itemCount: groceryItems.length,
        // Builder function that creates a ListTile for each grocery item
        itemBuilder: (context, index) => ListTile(
          // Display the grocery item name
          title: Text(groceryItems[index].name),
          // Leading widget: colored container representing the category
          leading: Container(
            width: 24,
            height: 24,
            // Use the category's associated color
            color: groceryItems[index].category.color,
          ),
          // Trailing widget: display the quantity as text
          trailing: Text(groceryItems[index].quantity.toString()),
        ),
      ),
    );
  }
}
