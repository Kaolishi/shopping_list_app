/// A form widget for creating new grocery items.
///
/// This file contains the [NewItem] widget which provides a form interface
/// for users to create new grocery items. The form includes fields for item
/// name, quantity, and category selection with proper validation and state management.

import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:shopping_list_app/config/app_config.dart';
import 'package:shopping_list_app/data/categories.dart';
import 'package:shopping_list_app/models/catagory.dart';
import 'package:shopping_list_app/models/grocery_item.dart';

/// A stateful widget that provides a form for creating new grocery items.
///
/// This widget creates a form with the following fields:
/// - Item name: Text input with validation (1-50 characters)
/// - Quantity: Numeric input with validation (positive integers only)
/// - Category: Dropdown selection from available categories
///
/// The form includes validation, reset functionality, and returns a
/// [GroceryItem] object when saved successfully. If the user cancels
/// or navigates back without saving, null is returned.
///
/// Navigation behavior:
/// - On successful save: Pops with created [GroceryItem]
/// - On cancel/back: Pops with null
class NewItem extends StatefulWidget {
  /// Creates a [NewItem] form widget.
  ///
  /// The [key] parameter is used to control how one widget replaces another
  /// widget in the tree.
  const NewItem({super.key});

  @override
  State<NewItem> createState() {
    return _NewItemState();
  }
}

/// The state class for [NewItem] that manages form data and validation.
///
/// This class handles:
/// - Form validation and state management
/// - User input storage and processing
/// - Category selection and display
/// - Form submission and data creation
class _NewItemState extends State<NewItem> {
  /// Global key for the form to access validation and save methods.
  ///
  /// This key provides access to the [FormState] which allows validation
  /// of all form fields and saving of their current values.
  final _formKey = GlobalKey<FormState>();

  /// The name entered by the user for the grocery item.
  ///
  /// This value is updated when the form is saved and must be
  /// between 1 and 50 characters long after trimming whitespace.
  var _enteredName = '';

  /// The quantity entered by the user for the grocery item.
  ///
  /// Defaults to 1 and must be a positive integer. This value
  /// is updated when the form is saved.
  int _enteredQuantity = 1;

  /// The currently selected category for the grocery item.
  ///
  /// Defaults to vegetables category and can be changed through
  /// the dropdown selector. This determines the color coding
  /// and organization of the item in the main list.
  var _selectedCategory = categories[Categories.vegetables]!;

  var _isSending = false;

  /// Validates and saves the form, then creates a new grocery item.
  ///
  /// This method:
  /// 1. Validates all form fields using their validators
  /// 2. Saves the current form state to update instance variables
  /// 3. Creates a new [GroceryItem] with the entered data
  /// 4. Pops the navigation stack, returning the created item
  ///
  /// If validation fails, the method returns early and shows
  /// validation error messages to the user.
  ///
  /// The created item uses the current timestamp as a unique ID.
  void _saveItem() async {
    // Validate all form fields
    if (_formKey.currentState!.validate()) {
      // Save form state to update instance variables
      _formKey.currentState!.save();
      setState(() {
        _isSending = true;
      });
      // Create and return new grocery item
      final url = AppConfig.buildFirebaseUrl('shopping-list.json');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(
          {
            'name': _enteredName,
            'quantity': _enteredQuantity,
            'category': _selectedCategory.name,
          },
        ),
      );

      final Map<String, dynamic> responseData = json.decode(response.body);

      if (!context.mounted) {
        return;
      }

      Navigator.of(context).pop(
        GroceryItem(
          id: responseData['name'],
          name: _enteredName,
          quantity: _enteredQuantity,
          category: _selectedCategory,
        ),
      );
    }
  }

  /// Builds the form interface for creating a new grocery item.
  ///
  /// This method creates a [Scaffold] containing:
  /// - An [AppBar] with "New Item" title and back navigation
  /// - A [Form] with three main sections:
  ///   1. Name input field with character limit and validation
  ///   2. Horizontal row with quantity input and category dropdown
  ///   3. Action buttons for reset and save operations
  ///
  /// Form validation rules:
  /// - Name: Required, 1-50 characters after trimming
  /// - Quantity: Required, positive integer only
  /// - Category: Required (dropdown ensures valid selection)
  ///
  /// Returns a [Widget] representing the complete new item form screen.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // App bar with form title
      appBar: AppBar(
        title: const Text('New Item'),
      ),
      // Form body with padding for better visual spacing
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Name input field with validation
              TextFormField(
                maxLength: 50, // Character limit with counter
                decoration: const InputDecoration(
                  label: Text('Name'),
                ),
                // Validation: Check length and emptiness
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length <= 1 ||
                      value.trim().length > 50) {
                    return 'Must be between 1 and 50 characters long! ';
                  }
                  return null; // Valid input
                },
                // Save trimmed value when form is saved
                onSaved: (value) {
                  _enteredName = value!;
                },
              ),

              // Horizontal row for quantity and category inputs
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Quantity input field (takes half the width)
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        label: Text('Quantity'),
                      ),
                      // Numeric keyboard for better user experience
                      keyboardType: const TextInputType.numberWithOptions(),
                      // Show current quantity as initial value
                      initialValue: _enteredQuantity.toString(),
                      // Validation: Ensure positive integer
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            int.tryParse(value) == null ||
                            int.tryParse(value)! <= 0) {
                          return 'Invalid number! ';
                        }
                        return null; // Valid input
                      },
                      // Parse and save quantity when form is saved
                      onSaved: (value) {
                        _enteredQuantity = int.parse(value!);
                      },
                    ),
                  ),

                  // Spacing between quantity and category fields
                  const SizedBox(width: 8),

                  // Category dropdown selector (takes half the width)
                  Expanded(
                    child: DropdownButtonFormField(
                      value: _selectedCategory,
                      // Build dropdown items from available categories
                      items: [
                        for (final category in categories.entries)
                          DropdownMenuItem(
                            value: category.value,
                            // Display category with color indicator and name
                            child: Row(
                              children: [
                                // Colored square representing category
                                Container(
                                  width: 16,
                                  height: 16,
                                  color: category.value.color,
                                ),
                                const SizedBox(width: 6),
                                // Category name
                                Text(category.value.name),
                              ],
                            ),
                          ),
                      ],
                      // Update selected category when user makes selection
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),

              // Spacing before action buttons
              const SizedBox(height: 12),

              // Action buttons row (reset and save)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Reset button - clears all form fields
                  TextButton(
                    onPressed: _isSending
                        ? null
                        : () {
                            _formKey.currentState!.reset();
                          },
                    child: const Text('Reset'),
                  ),

                  // Save button - validates and creates item
                  ElevatedButton(
                    onPressed: _isSending ? null : _saveItem,
                    child: _isSending
                        ? const SizedBox(
                            height: 16,
                            width: 16,
                            child: CircularProgressIndicator(),
                          )
                        : const Text('Add Item'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
