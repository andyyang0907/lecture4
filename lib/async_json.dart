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
    id: (j['id'] as num?)?.toInt() ?? 0,
    title: j['title'] as String? ?? '',
    category: j['category'] as String? ?? '',
    borrowCount: (j['borrowCount'] as num?)?.toInt() ?? 0,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'category': category,
    'borrowCount': borrowCount,
  };
}

Future<List<Book>> loadBooks(String path) async {
  final content = await File(path).readAsString();
  final List<dynamic> raw = jsonDecode(content) as List<dynamic>;
  final books = <Book>[];
  for (var i = 0; i < raw.length; i++) {
    try {
      books.add(Book.fromJson(raw[i] as Map<String, dynamic>));
    } catch (e) {
      print('第 ${i + 1} 条数据解析失败，已跳过：$e');
    }
  }
  return books;
}
