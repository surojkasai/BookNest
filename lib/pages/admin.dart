import 'package:booknest/db/book.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart'; // Using hive_flutter for ValueListenableBuilder
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';

class AdminBookUploadPage extends StatefulWidget {
  @override
  _AdminBookUploadPageState createState() => _AdminBookUploadPageState();
}

class _AdminBookUploadPageState extends State<AdminBookUploadPage> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final authorController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();

  Uint8List? imageBytes;
  bool isSaving = false; // Renamed from isUploading for broader context

  final List<String> categories = [
    'Best Selling',
    'New Arrivals',
    'Cinematic',
    'Cinematic Adaptation',
  ]; // Added 'Cinematic Adaptation' if that's a distinct category
  String? selectedCategory;

  int? _editingBookKey; // Holds the Hive key of the book being edited

  @override
  void dispose() {
    titleController.dispose();
    authorController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  // Function to pick image
  Future<void> pickImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image, withData: true);

    if (result != null && result.files.first.bytes != null) {
      setState(() {
        imageBytes = result.files.first.bytes!;
      });
    }
  }

  // Function to clear the form
  void _clearForm() {
    titleController.clear();
    authorController.clear();
    priceController.clear();
    descriptionController.clear();
    setState(() {
      imageBytes = null;
      selectedCategory = null;
      _editingBookKey = null; // Clear editing state
    });
  }

  // Function to populate form for editing
  void _editBook(Book book, int bookKey) {
    setState(() {
      _editingBookKey = bookKey;
      titleController.text = book.title;
      authorController.text = book.author;
      priceController.text = book.price.toString();
      descriptionController.text = book.description;
      selectedCategory = book.category; // Assuming category is directly stored in Book
      imageBytes = book.imageBytes;
    });
    // Scroll to the top of the page to show the form
    // (You might need a ScrollController for more precise control if the form is long)
    Scrollable.ensureVisible(
      _formKey.currentContext!,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  // Function to delete a book
  Future<void> _deleteBook(int bookKey) async {
    final confirmed =
        await showDialog<bool>(
          context: context,
          builder:
              (context) => AlertDialog(
                title: const Text('Delete Book'),
                content: const Text('Are you sure you want to delete this book?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text('Delete'),
                  ),
                ],
              ),
        ) ??
        false;

    if (confirmed) {
      try {
        final bookBox = Hive.box<Book>('books');
        await bookBox.delete(bookKey);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Book deleted successfully!")));
        if (_editingBookKey == bookKey) {
          _clearForm(); // Clear form if the deleted book was being edited
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Deletion failed: $e")));
      }
    }
  }

  // Combined function for saving new book or updating existing one
  Future<void> saveOrUpdateBook() async {
    if (!_formKey.currentState!.validate() || imageBytes == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Fill all fields and select an image")));
      return;
    }

    setState(() => isSaving = true);

    try {
      final bookBox = Hive.box<Book>('books');

      final book = Book(
        title: titleController.text.trim(),
        author: authorController.text.trim(),
        description: descriptionController.text.trim(),
        price: double.parse(priceController.text.trim()),
        category: selectedCategory, // This is nullable String?
        imageBytes: imageBytes,
        createdAt: DateTime.now(), // For new books, current time. For edits, it might be original.
        // If you want to preserve original createdAt, you'd load it from _editingBook and pass it here.
      );

      if (_editingBookKey == null) {
        // Add new book
        await bookBox.add(book);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("New book saved locally!")));
      } else {
        // Update existing book
        await bookBox.put(_editingBookKey!, book);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text("Book updated successfully!")));
      }

      _clearForm(); // Clear the form after saving/updating
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Operation failed: $e")));
    }

    setState(() => isSaving = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_editingBookKey == null ? 'Admin - Add New Book' : 'Admin - Edit Book'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Book Upload/Edit Form
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: titleController,
                    decoration: const InputDecoration(labelText: 'Book Title'),
                    validator: (value) => value!.isEmpty ? 'Enter book title' : null,
                  ),
                  TextFormField(
                    controller: authorController,
                    decoration: const InputDecoration(labelText: 'Author'),
                    validator: (value) => value!.isEmpty ? 'Enter author name' : null,
                  ),
                  TextFormField(
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Price'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter price';
                      }
                      if (double.tryParse(value) == null) {
                        return 'Enter a valid number';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: descriptionController,
                    decoration: const InputDecoration(labelText: 'Description'),
                    maxLines: 3,
                    validator: (value) => value!.isEmpty ? 'Enter description' : null,
                  ),
                  DropdownButtonFormField<String>(
                    value: selectedCategory,
                    items:
                        categories.map((category) {
                          return DropdownMenuItem(value: category, child: Text(category));
                        }).toList(),
                    onChanged: (value) => setState(() => selectedCategory = value),
                    validator: (value) => value == null ? 'Please select a category' : null,
                    decoration: const InputDecoration(labelText: 'Category'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: pickImage,
                    child: Text(imageBytes == null ? 'Pick Book Cover Image' : 'Change Image'),
                  ),
                  if (imageBytes != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Image.memory(imageBytes!, height: 150),
                    ),
                  const SizedBox(height: 20),
                  isSaving
                      ? const CircularProgressIndicator()
                      : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: saveOrUpdateBook,
                            child: Text(_editingBookKey == null ? 'Add Book' : 'Update Book'),
                          ),
                          OutlinedButton(
                            onPressed: _clearForm,
                            child: Text(_editingBookKey == null ? 'Clear Form' : 'Cancel Edit'),
                          ),
                        ],
                      ),
                ],
              ),
            ),
            const Divider(height: 40, thickness: 2),
            // Display Existing Books List
            const Text(
              'Existing Books',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ValueListenableBuilder<Box<Book>>(
              valueListenable: Hive.box<Book>('books').listenable(),
              builder: (context, box, _) {
                if (box.isEmpty) {
                  return const Center(child: Text('No books added yet.'));
                }
                final books = box.values.toList();
                final keys = box.keys.toList(); // Get keys for deletion/update

                return ListView.builder(
                  shrinkWrap: true, // Important for ListView inside SingleChildScrollView
                  physics: const NeverScrollableScrollPhysics(), // To prevent double scrolling
                  itemCount: books.length,
                  itemBuilder: (context, index) {
                    final book = books[index];
                    final bookKey = keys[index] as int; // Hive keys are usually int for .add()

                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            if (book.imageBytes != null)
                              Image.memory(
                                book.imageBytes!,
                                width: 80,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    book.title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text('by ${book.author}', style: const TextStyle(fontSize: 14)),
                                  Text(
                                    'Rs. ${book.price.toStringAsFixed(2)}',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  if (book.category != null && book.category!.isNotEmpty)
                                    Text(
                                      'Category: ${book.category}',
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () => _editBook(book, bookKey),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deleteBook(bookKey),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
