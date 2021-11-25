import 'package:test_app/models/news.dart';

class Data {
  String category;
  List<News> data;
  Data.fromMap(Map<String, dynamic> map) {
    category = map['category'];
    data = map['data'];
  }
}
