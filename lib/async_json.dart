import 'dart:convert';
import 'dart:io';

class Book {
  final int id;
  final String title;
  final String category;
  final int borrowCount;

  Book({
    required this.id,
    required this.title,
    required this.category,
    required this.borrowCount,
  });

  factory Book.fromJson(Map<String, dynamic> j) => Book(
    id: (j['id'] as num).toInt(),
    title: j['title'] as String,
    category: j['category'] as String,
    borrowCount: (j['borrowCount'] as num).toInt(),
  );
}

Future<List<Book>> loadBooks(String path) async {
  final content = await File(path).readAsString();
  final List<dynamic> raw = jsonDecode(content) as List<dynamic>;
  return raw.map((e) => Book.fromJson(e as Map<String, dynamic>)).toList();
}
