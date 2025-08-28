import 'package:hive/hive.dart';
import 'dart:typed_data';

part 'book.g.dart';

@HiveType(typeId: 0)
class Book extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  String author;

  @HiveField(2)
  String description;

  @HiveField(3)
  double price;

  @HiveField(4)
  String? category;

  @HiveField(5)
  Uint8List? imageBytes;

  @HiveField(6)
  DateTime createdAt;

  Book({
    required this.title,
    required this.author,
    required this.description,
    required this.price,
    required this.category,
    this.imageBytes,
    required this.createdAt,
  });
}
