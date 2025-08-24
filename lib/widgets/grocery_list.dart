/// A widget that displays a list of grocery items with add/remove functionality.
///
/// This file contains the [GroceryList] widget which serves as the main screen
/// for viewing and managing grocery items. Users can add new items via navigation
/// to a form screen and remove items by swiping to dismiss.

import 'package:flutter/material.dart';
import 'package:shopping_list_app/models/grocery_item.dart';
import 'package:shopping_list_app/widgets/new_item.dart';

/// A stateful widget that displays and manages a list of grocery items.
///
/// This widget creates a [Scaffold] with an [AppBar] and dynamic content that shows:
/// - An empty state message when no items are present
/// - A scrollable list of grocery items when items exist
/// - Add functionality via app bar action button
/// - Remove functionality via swipe-to-dismiss gestures
///
/// Each item is displayed with:
/// - A colored container representing the item's category
/// - The item's name as the title
/// - The quantity as trailing text
///
/// State management:
/// - Maintains a local list of [GroceryItem] objects
/// - Updates UI when items are added or removed
/// - Handles navigation to and from the new item form
class GroceryList extends StatefulWidget {
  /// Creates a [GroceryList] widget.
  ///
  /// The [key] parameter is used to control how one widget replaces another
  /// widget in the tree.
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

/// The state class for [GroceryList] that manages the grocery items list.
///
/// This class handles:
/// - Maintaining the list of grocery items
/// - Adding new items from the form screen
/// - Removing items via swipe gestures
/// - Building the appropriate UI based on list state
class _GroceryListState extends State<GroceryList> {
  /// The list of grocery items currently displayed.
  ///
  /// This list starts empty and is populated when users add items
  /// through the new item form. Items can be removed by swiping.
  final List<GroceryItem> _groceryItems = [];

  /// Navigates to the new item form and handles the returned result.
  ///
  /// This method:
  /// 1. Pushes the [NewItem] screen onto the navigation stack
  /// 2. Waits for a [GroceryItem] to be returned from the form
  /// 3. Adds the new item to the list if one was created
  /// 4. Updates the UI to reflect the changes
  ///
  /// If the user cancels the form or doesn't save an item,
  /// [newItem] will be null and no changes are made.
  void _addItem() async {
    // Navigate to new item form and wait for result
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(builder: (context) => const NewItem()),
    );

    // Exit early if user cancelled or didn't save an item
    if (newItem == null) {
      return;
    }

    // Add the new item to the list and trigger UI rebuild
    setState(() {
      _groceryItems.add(newItem);
    });
  }

  /// Removes a specific grocery item from the list.
  ///
  /// This method is called when a user swipes to dismiss an item.
  /// It removes the specified [item] from [_groceryItems].
  ///
  /// Note: The UI update is handled by the [Dismissible] widget,
  /// so [setState] is not needed here.
  ///
  /// Parameters:
  /// - [item]: The [GroceryItem] to remove from the list
  void _removeItem(GroceryItem item) {
    _groceryItems.remove(item);
  }

  /// Builds the widget's UI structure.
  ///
  /// This method creates a [Scaffold] with:
  /// - An [AppBar] containing the title and add button
  /// - Dynamic body content based on the list state:
  ///   - Empty state: Centered message "Wow... such empty"
  ///   - With items: Scrollable list with dismissible items
  ///
  /// Each list item is wrapped in a [Dismissible] widget to enable
  /// swipe-to-delete functionality. The list items display:
  /// - Category color indicator (leading)
  /// - Item name (title)
  /// - Quantity (trailing)
  ///
  /// Returns a [Widget] representing the complete grocery list screen.
  @override
  Widget build(BuildContext context) {
    // Default content for empty state
    Widget content = const Center(
      child: Text('Wow... such empty'),
    );

    // Build list content if items exist
    if (_groceryItems.isNotEmpty) {
      content = ListView.builder(
        // Total number of items in the list
        itemCount: _groceryItems.length,
        // Builder function that creates a dismissible ListTile for each item
        itemBuilder: (context, index) => Dismissible(
          // Unique key for each dismissible item (required for proper animation)
          key: ValueKey(_groceryItems[index].id),
          // Callback when item is swiped away
          onDismissed: (direction) {
            _removeItem(_groceryItems[index]);
          },
          // The actual list item content
          child: ListTile(
            // Display the grocery item name
            title: Text(_groceryItems[index].name),
            // Leading widget: colored container representing the category
            leading: Container(
              width: 24,
              height: 24,
              // Use the category's associated color
              color: _groceryItems[index].category.color,
            ),
            // Trailing widget: display the quantity as text
            trailing: Text(_groceryItems[index].quantity.toString()),
          ),
        ),
      );
    }

    return Scaffold(
      // App bar with title and add button
      appBar: AppBar(
        title: const Text('Your Groceries'),
        // Action buttons in the app bar
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      // Main body content (either empty state or list)
      body: content,
    );
  }
}
