import 'dart:io';

import 'package:async_json/async_json.dart';
import 'package:path/path.dart' as p;

Future<void> main(List<String> arguments) async {
  final dataPath = p.join(Directory.current.path, 'data', 'books.json');

  final books = await loadBooks(dataPath);

  print('=== 图书统计 ===');
  print('总数: ${books.length}');

  final categoryCount = <String, int>{};
  for (final b in books) {
    categoryCount[b.category] = (categoryCount[b.category] ?? 0) + 1;
  }
  print('\n各类目数量:');
  categoryCount.forEach((cat, count) => print('  $cat: $count'));

  final sorted = [...books]
    ..sort((a, b) => b.borrowCount.compareTo(a.borrowCount));
  print('\n借阅量 Top3:');
  for (var i = 0; i < sorted.length && i < 3; i++) {
    final b = sorted[i];
    print('  ${i + 1}. 《${b.title}》- 借阅 ${b.borrowCount} 次');
  }
}
