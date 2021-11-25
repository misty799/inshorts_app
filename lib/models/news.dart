import 'package:http/http.dart';

class News {
  String author;
  String title;
  String content;
  String imageUrl;
  String readMoreUrl;
  String date;

  static List<String> columns = [
    'author',
    'title',
    'content',
    'imageUrl',
    'readMoreUrl',
    'date'
  ];
  News.fromMap(Map<String, dynamic> map) {
    author = map['author'];
    title = map['title'];
    content = map['content'];
    imageUrl = map['imageUrl'];
    date = map['date'];
    readMoreUrl = map['readMoreUrl'];
  }
}
