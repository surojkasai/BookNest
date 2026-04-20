import 'package:booknest/utility/algorithms/content_based.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:booknest/db/book.dart';

class SimilarBooksSection extends StatefulWidget {
  final Book currentBook;
  final void Function(Book)? onBookTap;

  const SimilarBooksSection({super.key, required this.currentBook, this.onBookTap});

  @override
  State<SimilarBooksSection> createState() => _SimilarBooksSectionState();
}

class _SimilarBooksSectionState extends State<SimilarBooksSection> {
  int? _hoveredIndex;

  @override
  Widget build(BuildContext context) {
    final bookBox = Hive.box<Book>('books');
    final allBooks = bookBox.values.toList();

    final similarBooks = recommendBooks(widget.currentBook, allBooks);

    if (similarBooks.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const Text(
          "Similar Books You May Like",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),

        SizedBox(
          height: 220,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: similarBooks.length,
            itemBuilder: (context, index) {
              final book = similarBooks[index];
              final isHovered = _hoveredIndex == index;
              final scale = isHovered ? 1.15 : 1.0;

              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: MouseRegion(
                  onEnter: (_) => setState(() => _hoveredIndex = index),
                  onExit: (_) => setState(() => _hoveredIndex = null),
                  child: GestureDetector(
                    onTap: () {
                      if (widget.onBookTap != null) {
                        widget.onBookTap!(book);
                      }
                    },
                    child: AnimatedScale(
                      scale: scale,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOutCubic,
                      child: Column(
                        children: [
                          Container(
                            width: 120,
                            height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.grey.shade300,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(isHovered ? 0.4 : 0.2),
                                  blurRadius: isHovered ? 16 : 8,
                                  offset: isHovered ? const Offset(0, 8) : const Offset(0, 4),
                                ),
                              ],
                            ),
                            child:
                                book.imageBytes != null
                                    ? ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.memory(book.imageBytes!, fit: BoxFit.cover),
                                    )
                                    : const Icon(Icons.book, size: 40),
                          ),
                          const SizedBox(height: 5),
                          SizedBox(
                            width: 120,
                            child: Text(
                              book.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: isHovered ? FontWeight.w600 : FontWeight.normal,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
