import 'package:booknest/db/book.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
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
  bool isUploading = false;

  final List<String> categories = ['Best Selling', 'New Arrivals', 'Cinematic'];
  String? selectedCategory;

  Future<void> pickImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image, withData: true);

    if (result != null && result.files.first.bytes != null) {
      setState(() {
        imageBytes = result.files.first.bytes!;
      });
    }
  }

  Future<void> uploadBook() async {
    if (!_formKey.currentState!.validate() || imageBytes == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text("Fill all fields and select an image")));
      return;
    }

    setState(() => isUploading = true);

    try {
      final bookBox = Hive.box<Book>('books');

      final book = Book(
        title: titleController.text.trim(),
        author: authorController.text.trim(),
        description: descriptionController.text.trim(),
        price: double.parse(priceController.text.trim()),
        category: selectedCategory,
        imageBytes: imageBytes,
        createdAt: DateTime.now(),
      );

      await bookBox.add(book);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Book saved locally")));

      titleController.clear();
      authorController.clear();
      priceController.clear();
      descriptionController.clear();

      setState(() {
        imageBytes = null;
        selectedCategory = null;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Save failed: $e")));
    }

    setState(() => isUploading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin - Add New Book')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Book Title'),
                validator: (value) => value!.isEmpty ? 'Enter book title' : null,
              ),
              TextFormField(
                controller: authorController,
                decoration: InputDecoration(labelText: 'Author'),
                validator: (value) => value!.isEmpty ? 'Enter author name' : null,
              ),
              TextFormField(
                controller: priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Price'),
                validator: (value) => value!.isEmpty ? 'Enter price' : null,
              ),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
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
                decoration: InputDecoration(labelText: 'Category'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: pickImage,
                child: Text(imageBytes == null ? 'Pick Book Cover Image' : 'Image Selected'),
              ),
              if (imageBytes != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Image.memory(imageBytes!, height: 150),
                ),
              SizedBox(height: 20),
              isUploading
                  ? CircularProgressIndicator()
                  : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(onPressed: uploadBook, child: Text('Save Book')),
                      OutlinedButton(
                        onPressed: () {
                          titleController.clear();
                          authorController.clear();
                          priceController.clear();
                          descriptionController.clear();
                          setState(() {
                            imageBytes = null;
                            selectedCategory = null;
                          });
                        },
                        child: Text('Cancel'),
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
