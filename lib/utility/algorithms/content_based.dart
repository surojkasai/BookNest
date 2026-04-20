import 'package:booknest/db/book.dart';

List<Book> recommendBooks(Book currentBook, List<Book> allBooks) {
  // Content-based genre similarity scoring
  final normalize =
      (String? s) =>
          (s ?? '')
              .toLowerCase()
              .split(RegExp(r'[|,;/]'))
              .map((p) => p.trim())
              .where((p) => p.isNotEmpty)
              .toSet();

  final currentGenres = normalize(currentBook.genre);

  final scores = <Book, double>{};

  for (final b in allBooks) {
    if (b.title == currentBook.title) continue;

    double score = 0.0;

    // Genre overlap (primary signal)
    final genres = normalize(b.genre);
    final common = currentGenres.intersection(genres);
    if (common.isNotEmpty) {
      // give higher weight for more overlapping genres
      score += 5.0 * common.length;
    }

    // Exact genre string match (bonus)
    if (b.genre.toLowerCase() == currentBook.genre.toLowerCase()) {
      score += 8.0;
    }

    // Same author (secondary)
    if (b.author.toLowerCase() == currentBook.author.toLowerCase()) score += 2.5;

    // Same category (tertiary)
    if ((b.category ?? '').toLowerCase() == (currentBook.category ?? '').toLowerCase())
      score += 1.5;

    // Minimal score threshold to include
    if (score > 0) scores[b] = score;
  }

  // Sort books by score desc and return top 10
  final recommended = scores.keys.toList()..sort((a, b) => (scores[b]!.compareTo(scores[a]!)));

  return recommended.take(10).toList();
}
