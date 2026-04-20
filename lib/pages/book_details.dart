import 'dart:typed_data';
import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'package:booknest/db/book.dart';
import 'package:booknest/pages/homepage.dart';
import 'package:booknest/utility/section/footer_section.dart';
import 'package:booknest/pages/similar_books.dart';

import '../provider/cart_provider.dart';

int deliveryCharge = 0;

// 🎨 Color Constants (Cinematic Theme)
const Color bgDark = Color(0xFF0B0A10);
const Color bgMid = Color(0xFF14121C);
const Color bgSoft = Color(0xFF2B2438);

const Color primaryPurple = Color(0xFF7C4DFF);
const Color textPrimary = Color(0xFFFFFFFF);
const Color textBody = Color(0xFFD6D4E0);
const Color textMuted = Color(0xFF9B97AE);

// Section-to-UI mapping
final sectionTextMap = {
  'New Arrivals': {
    'titleText': 'New Arrivals\n',
    'capText': 'Find Your Next Great Read Among Our New Arrivals',
  },
  'Best Selling': {'titleText': 'Best Selling\n', 'capText': 'Discover Our Most-Loved Books'},
  'Cinematic Adaptations': {
    'titleText': 'Cinematic Adaptations\n',
    'capText': 'Books That Inspired Blockbuster Films',
  },
};

String getSectionTitle(String? category) {
  return sectionTextMap[category]?['titleText'] ?? (category ?? '') + '\n';
}

String getSectionCapText(String? category) {
  return sectionTextMap[category]?['capText'] ?? '';
}

class BookDetailsPage extends StatelessWidget {
  final VoidCallback? onThemeChanged;
  final String title;
  final Uint8List? imageBytes;
  final double price;
  final String titleText;
  final String capText;
  final String author;
  final String description;
  final String genre;

  const BookDetailsPage({
    super.key,
    required this.title,
    required this.genre,
    this.imageBytes,
    required this.price,
    required this.capText,
    required this.titleText,
    required this.author,
    required this.description,
    this.onThemeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final currentBook = Book(
      title: title,
      genre: genre,
      author: author,
      description: description,
      price: price,
      category: capText,
      imageBytes: imageBytes,
      createdAt: DateTime.now(),
    );

    return Homepage(
      onThemeChanged: onThemeChanged,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [bgSoft, bgMid, bgDark],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                // Title
                Container(
                  height: 100,
                  alignment: Alignment.centerLeft,
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: titleText,
                          style: const TextStyle(
                            fontSize: 28,
                            color: textPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: '$capText\n',
                          style: const TextStyle(fontSize: 20, color: textMuted),
                        ),
                      ],
                    ),
                  ),
                ),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // LEFT CONTENT
                    Expanded(
                      flex: 2,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child:
                                imageBytes != null && imageBytes!.isNotEmpty
                                    ? Image.memory(
                                      imageBytes!,
                                      width: 220,
                                      height: 380,
                                      fit: BoxFit.cover,
                                    )
                                    : const Icon(Icons.image_not_supported, size: 100),
                          ),
                          const SizedBox(width: 20),

                          Expanded(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(minHeight: 380),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Text(
                                      title,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.headlineMedium?.copyWith(color: textPrimary),
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    genre,
                                    style: const TextStyle(fontSize: 16, color: Color(0xFFF2B84B)),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        '/author-books',
                                        arguments: author,
                                      );
                                    },
                                    child: Text(
                                      author,
                                      style: const TextStyle(
                                        color: primaryPurple,
                                        fontSize: 15,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 12),

                                  ExpandableScrollableText(
                                    text: description,
                                    collapsedLines: 6,
                                    height: 160,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 20),

                    // RIGHT CARD
                    Expanded(
                      flex: 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: primaryPurple.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.white.withOpacity(0.15)),
                            ),
                            child: Column(
                              children: [
                                _priceRow("Subtotal:", "Rs.$price"),
                                const SizedBox(height: 8),
                                _priceRow("Delivery:", "$deliveryCharge"),
                                const Divider(),
                                _priceRow("Total:", "Rs.${price + deliveryCharge}", isBold: true),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    _outlinedButton(context, "Add to Cart", () {
                                      Provider.of<CartProvider>(
                                        context,
                                        listen: false,
                                      ).addItem(title, author, price, imageBytes);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text("Added to cart")),
                                      );
                                    }),
                                    const SizedBox(width: 10),
                                    _outlinedButton(context, "View Cart", () {
                                      Navigator.pushNamed(context, '/usercart');
                                    }),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Similar books section (genre-based recommendations)
                SimilarBooksSection(
                  currentBook: currentBook,
                  onBookTap: (book) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => BookDetailsPage(
                              title: book.title,
                              genre: book.genre,
                              imageBytes: book.imageBytes,
                              price: book.price,
                              titleText: getSectionTitle(book.category),
                              capText: getSectionCapText(book.category),
                              author: book.author,
                              description: book.description,
                            ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
      footer: FooterSection(),
    );
  }

  Widget _priceRow(String label, String value, {bool isBold = false}) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            color: textBody,
            fontSize: isBold ? 17 : 15,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            color: textPrimary,
            fontSize: isBold ? 17 : 15,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _outlinedButton(BuildContext context, String text, VoidCallback onTap) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: BorderSide(color: Colors.white.withOpacity(0.3)),
        ),
      ),
      child: Text(text, style: const TextStyle(color: textPrimary)),
    );
  }
}

// ================= EXPANDABLE scroll TEXT =================

class ExpandableScrollableText extends StatefulWidget {
  final String text;
  final int collapsedLines;
  final double height;

  const ExpandableScrollableText({
    super.key,
    required this.text,
    this.collapsedLines = 4,
    this.height = 200,
  });

  @override
  State<ExpandableScrollableText> createState() => _ExpandableScrollableTextState();
}

class _ExpandableScrollableTextState extends State<ExpandableScrollableText> {
  bool expanded = false;
  bool _hintAnimateCollapsed = false;
  bool _hintAnimateModal = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Collapsed: show a few lines with fade overlay (no internal scroll)
        Stack(
          children: [
            Text(
              widget.text,
              maxLines: widget.collapsedLines,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.justify,
              style: const TextStyle(color: textBody, height: 1.5),
            ),
            // Gradient/fade at bottom to give blurry effect
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: 48,
              child: IgnorePointer(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Theme.of(context).scaffoldBackgroundColor.withOpacity(0.95),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        // Centered See more button opens a modal with scrollable full text
        Center(
          child: GestureDetector(
            onTap: () async {
              setState(() {
                _hintAnimateModal = true;
              });
              await showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                builder: (context) {
                  return DraggableScrollableSheet(
                    expand: false,
                    initialChildSize: 0.5,
                    minChildSize: 0.3,
                    maxChildSize: 0.95,
                    builder: (context, controller) {
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Container(
                                width: 40,
                                height: 4,
                                margin: const EdgeInsets.only(bottom: 12),
                                decoration: BoxDecoration(
                                  color: Colors.grey[400],
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                            Expanded(
                              child: SingleChildScrollView(
                                controller: controller,
                                physics: const BouncingScrollPhysics(),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.text,
                                      textAlign: TextAlign.justify,
                                      style: const TextStyle(color: textBody, height: 1.6),
                                    ),
                                    const SizedBox(height: 20),
                                    VisibilityDetector(
                                      key: const Key('modal-hint'),
                                      onVisibilityChanged: (info) {
                                        if (info.visibleFraction > 0.05 && !_hintAnimateModal) {
                                          setState(() {
                                            _hintAnimateModal = true;
                                          });
                                        }
                                      },
                                      child: Align(
                                        alignment: Alignment.centerRight,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 6,
                                          ),
                                          decoration: BoxDecoration(
                                            color: primaryPurple.withOpacity(0.06),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child:
                                              _hintAnimateModal
                                                  ? AnimatedTextKit(
                                                    repeatForever: true,
                                                    pause: Duration.zero,
                                                    animatedTexts: [
                                                      ColorizeAnimatedText(
                                                        'This is just a glimpse—discover the complete journey in the book.',
                                                        textStyle: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight: FontWeight.w600,
                                                        ),
                                                        colors: [
                                                          primaryPurple,
                                                          primaryPurple.withOpacity(0.7),
                                                          textPrimary,
                                                        ],
                                                      ),
                                                    ],
                                                  ).animate().slide(
                                                    begin: const Offset(0, 0.2),
                                                    end: Offset.zero,
                                                    duration: 600.ms,
                                                  )
                                                  : const Text(
                                                    'This is just a glimpse—discover the complete journey in the book.',
                                                    textAlign: TextAlign.right,
                                                    style: TextStyle(
                                                      color: primaryPurple,
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              );
              // reset animation flag after sheet closes
              setState(() {
                _hintAnimateModal = false;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: primaryPurple.withOpacity(0.08),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'See more',
                style: TextStyle(color: primaryPurple, fontWeight: FontWeight.w600, fontSize: 14),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
