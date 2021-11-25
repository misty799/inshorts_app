import 'dart:async';
import 'dart:convert';

import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:test_app/bloc/data_event.dart';
import 'package:test_app/database_services.dart/offline_database.dart';
import 'package:test_app/models/news.dart';
import 'package:http/http.dart' as http;

class DataBloc extends Bloc {
  int page = 1;

  List<News> newsDataList = [];
  List<News> bookMarkList = [];

  StreamController<DataEvent> dataEventController =
      StreamController<DataEvent>.broadcast();

  StreamSink<DataEvent> get dataEventSink => dataEventController.sink;

  Stream<DataEvent> get _dataEventStream => dataEventController.stream;
  StreamController<List<News>> newsController =
      StreamController<List<News>>.broadcast();
  StreamSink<List<News>> get newsSink => newsController.sink;
  Stream<List<News>> get newsStream => newsController.stream;
  StreamController<List<News>> _bookmarkDataController =
      StreamController<List<News>>.broadcast();
  StreamSink<List<News>> get bookmarkDataSink => _bookmarkDataController.sink;
  Stream<List<News>> get bookmarkDataStream => _bookmarkDataController.stream;
  StreamController<String> errorController =
      StreamController<String>.broadcast();
  StreamSink<String> get errorSink => errorController.sink;
  Stream<String> get errorStream => errorController.stream;

  DataBloc() {
    _dataEventStream.listen(mapEventToState);
  }
  Future<void> mapEventToState(DataEvent event) async {
    if (event is FetchData) {
      newsDataList = [];
      try {
        final response = await http.get(Uri.parse(
            'https://inshortsapi.vercel.app/news?category=${event.category}'));
        if (response.statusCode == 200) {
          final map = json.decode(response.body);

          for (var element in map['data']) {
            newsDataList.add(News.fromMap(element));
          }
          newsSink.add(newsDataList);
        } else {
          throw Exception('failed to load data');
        }
      } catch (e) {
        print(e);
      }
    } else if (event is AddBookMark) {
      SQLiteDbProvider.db.insert(event.news);
    } else if (event is FetchBookMark) {
      bookMarkList = await SQLiteDbProvider.db.getAllNews();
      bookmarkDataSink.add(bookMarkList);
    } else if (event is DeleteBookMark) {
      SQLiteDbProvider.db.delete(event.title);
    }
  }

  @override
  void dispose() {
    dataEventController.close();
    _bookmarkDataController.close();
  }
}
