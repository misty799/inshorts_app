import 'package:test_app/models/data.dart';
import 'package:test_app/models/news.dart';

abstract class DataEvent {}

class FetchData extends DataEvent {
  final String category;
  FetchData({this.category});
}

class AddBookMark extends DataEvent {
  final News news;
  AddBookMark(this.news);
}

class FetchBookMark extends DataEvent {}

class DeleteBookMark extends DataEvent {
  String title;
  DeleteBookMark({this.title});
}
