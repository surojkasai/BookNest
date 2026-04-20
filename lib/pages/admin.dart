import 'package:booknest/db/book.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
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
  final genreController = TextEditingController();

  final ScrollController _formScrollController = ScrollController();

  Uint8List? imageBytes;
  bool isSaving = false;

  // 🎨 App theme colors
  final Color backgroundColor = const Color(0xFF0E0B16);
  final Color appBarColor = const Color(0xFF1B152A);
  final Color primaryText = const Color(0xFFEDE9FF);
  final Color secondaryText = const Color(0xFFB8B2D8);
  final Color accentPurple = const Color(0xFF7F5AF0);

  final List<String> categories = [
    'Best Selling',
    'New Arrivals',
    'Cinematic',
    'Cinematic Adaptation',
  ];
  String? selectedCategory;

  int? _editingBookKey;

  @override
  void dispose() {
    _formScrollController.dispose();
    titleController.dispose();
    authorController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    genreController.dispose();
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
    genreController.clear();
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
      selectedCategory = book.category;
      genreController.text = book.genre;
      imageBytes = book.imageBytes;
    });
    // Scroll to the top of the form
    _formScrollController.animateTo(
      0.0,
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
        print("Total books in hive: ${bookBox.values.length}");
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
        genre: genreController.text.trim(),
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
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('📚 Book Management'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: appBarColor,
      ),
      body: Column(
        children: [
          // Stats Section
          ValueListenableBuilder<Box<Book>>(
            valueListenable: Hive.box<Book>('books').listenable(),
            builder: (context, box, _) {
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [appBarColor, backgroundColor]),
                ),
                child: Column(
                  children: [
                    Text('Total Books', style: TextStyle(color: secondaryText, fontSize: 12)),
                    const SizedBox(height: 4),
                    Text(
                      '${box.length}',
                      style: TextStyle(
                        color: primaryText,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          // Side-by-side layout
          Expanded(
            child: Row(
              children: [
                // Left side: Add/Edit Book Form
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: appBarColor,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(color: Colors.black26, blurRadius: 8, offset: const Offset(0, 2)),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Form Header
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: accentPurple.withOpacity(0.1),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                _editingBookKey == null ? Icons.add_circle : Icons.edit,
                                color: accentPurple,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                _editingBookKey == null ? 'Add New Book' : 'Edit Book',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: primaryText,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Form Content
                        Expanded(child: _buildAddBookForm()),
                      ],
                    ),
                  ),
                ),
                // Right side: Manage Books List
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: appBarColor,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(color: Colors.black26, blurRadius: 8, offset: const Offset(0, 2)),
                      ],
                    ),
                    child: Column(
                      children: [
                        // List Header
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: accentPurple.withOpacity(0.1),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.list, color: accentPurple),
                              const SizedBox(width: 8),
                              Text(
                                'Manage Books',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: primaryText,
                                ),
                              ),
                              const Spacer(),
                              ValueListenableBuilder<Box<Book>>(
                                valueListenable: Hive.box<Book>('books').listenable(),
                                builder: (context, box, _) {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: accentPurple.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      '${box.length} books',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: primaryText,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        // Books List
                        Expanded(child: _buildManageBooksList()),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Build Add Book Form
  Widget _buildAddBookForm() {
    return Scrollbar(
      controller: _formScrollController,
      child: SingleChildScrollView(
        controller: _formScrollController,
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Image Picker Section
              Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: accentPurple.withOpacity(0.3), width: 2),
                  borderRadius: BorderRadius.circular(12),
                  color: appBarColor,
                ),
                child:
                    imageBytes == null
                        ? InkWell(
                          onTap: pickImage,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.cloud_upload, size: 52, color: secondaryText),
                              const SizedBox(height: 12),
                              Text(
                                'Tap to upload book cover',
                                style: TextStyle(color: secondaryText, fontSize: 14),
                              ),
                            ],
                          ),
                        )
                        : Stack(
                          children: [
                            Image.memory(imageBytes!, fit: BoxFit.cover, width: double.infinity),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: FloatingActionButton(
                                mini: true,
                                backgroundColor: Colors.red.shade400,
                                onPressed: () => setState(() => imageBytes = null),
                                child: const Icon(Icons.close),
                              ),
                            ),
                          ],
                        ),
              ),
              const SizedBox(height: 24),
              // Form Fields
              _buildTextField(
                controller: titleController,
                label: 'Book Title',
                icon: Icons.book,
                validator: (value) => value!.isEmpty ? 'Enter book title' : null,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: authorController,
                label: 'Author Name',
                icon: Icons.person,
                validator: (value) => value!.isEmpty ? 'Enter author name' : null,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: genreController,
                label: 'Genre',
                icon: Icons.category,
                validator: (value) => value!.isEmpty ? 'Enter genre' : null,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: priceController,
                label: 'Price (Rs.)',
                icon: Icons.currency_rupee,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Enter price';
                  if (double.tryParse(value!) == null) return 'Enter a valid number';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Category Dropdown
              DropdownButtonFormField<String>(
                value: selectedCategory,
                dropdownColor: appBarColor,
                decoration: InputDecoration(
                  labelText: 'Select Category',
                  labelStyle: TextStyle(color: secondaryText),
                  prefixIcon: Icon(Icons.collections, color: accentPurple),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: accentPurple.withOpacity(0.3)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: accentPurple.withOpacity(0.3)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: accentPurple),
                  ),
                  filled: true,
                  fillColor: backgroundColor,
                ),
                style: TextStyle(color: primaryText),
                items:
                    categories.map((cat) {
                      return DropdownMenuItem(
                        value: cat,
                        child: Text(cat, style: TextStyle(color: primaryText)),
                      );
                    }).toList(),
                onChanged: (value) => setState(() => selectedCategory = value),
                validator: (value) => value == null ? 'Select a category' : null,
              ),
              const SizedBox(height: 16),
              // Description
              TextFormField(
                controller: descriptionController,
                maxLines: 4,
                style: TextStyle(color: primaryText),
                decoration: InputDecoration(
                  labelText: 'Description',
                  labelStyle: TextStyle(color: secondaryText),
                  prefixIcon: Icon(Icons.description, color: accentPurple),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: accentPurple.withOpacity(0.3)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: accentPurple.withOpacity(0.3)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: accentPurple),
                  ),
                  filled: true,
                  fillColor: backgroundColor,
                ),
                validator: (value) => value!.isEmpty ? 'Enter description' : null,
              ),
              const SizedBox(height: 28),
              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: isSaving ? null : saveOrUpdateBook,
                      icon:
                          isSaving
                              ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                              : const Icon(Icons.check_circle),
                      label: Text(_editingBookKey == null ? 'Add Book' : 'Update Book'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: accentPurple,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: _clearForm,
                      icon: const Icon(Icons.clear),
                      label: const Text('Clear'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Build Manage Books List
  Widget _buildManageBooksList() {
    return ValueListenableBuilder<Box<Book>>(
      valueListenable: Hive.box<Book>('books').listenable(),
      builder: (context, box, _) {
        if (box.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.library_books, size: 48, color: secondaryText.withOpacity(0.5)),
                const SizedBox(height: 12),
                Text('No books yet', style: TextStyle(fontSize: 16, color: secondaryText)),
                const SizedBox(height: 8),
                Text(
                  'Add your first book using the form',
                  style: TextStyle(fontSize: 12, color: secondaryText.withOpacity(0.7)),
                ),
              ],
            ),
          );
        }

        final books = box.values.toList();
        final keys = box.keys.toList();

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: books.length,
          itemBuilder: (context, index) {
            final book = books[index];
            final bookKey = keys[index] as int;

            return Card(
              elevation: 1,
              margin: const EdgeInsets.symmetric(vertical: 4),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              child: InkWell(
                onTap: () => _editBook(book, bookKey),
                borderRadius: BorderRadius.circular(8),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      // Book Cover
                      if (book.imageBytes != null)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.memory(
                            book.imageBytes!,
                            width: 70,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        )
                      else
                        Container(
                          width: 70,
                          height: 100,
                          decoration: BoxDecoration(
                            color: accentPurple.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(Icons.image, color: secondaryText),
                        ),
                      const SizedBox(width: 12),
                      // Book Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              book.title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: primaryText,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  '/author-books',
                                  arguments: book.author,
                                );
                              },
                              child: Text(
                                'by ${book.author}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.blue.shade400,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: accentPurple.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Text(
                                    'Rs. ${book.price.toStringAsFixed(0)}',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: accentPurple,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    book.category ?? 'N/A',
                                    style: TextStyle(fontSize: 11, color: secondaryText),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Action Buttons
                      PopupMenuButton(
                        itemBuilder:
                            (context) => [
                              PopupMenuItem(
                                child: Row(
                                  children: const [
                                    Icon(Icons.edit, size: 18),
                                    SizedBox(width: 8),
                                    Text('Edit'),
                                  ],
                                ),
                                onTap:
                                    () => Future.delayed(
                                      Duration.zero,
                                      () => _editBook(book, bookKey),
                                    ),
                              ),
                              PopupMenuItem(
                                child: Row(
                                  children: const [
                                    Icon(Icons.delete, size: 18, color: Colors.red),
                                    SizedBox(width: 8),
                                    Text('Delete', style: TextStyle(color: Colors.red)),
                                  ],
                                ),
                                onTap:
                                    () => Future.delayed(Duration.zero, () => _deleteBook(bookKey)),
                              ),
                            ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  /// Helper widget for text fields
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: secondaryText),
        prefixIcon: Icon(icon, color: accentPurple),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: accentPurple.withOpacity(0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: accentPurple.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: accentPurple),
        ),
        filled: true,
        fillColor: backgroundColor,
      ),
      validator: validator,
    );
  }
}
