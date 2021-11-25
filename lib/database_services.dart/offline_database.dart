import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:test_app/models/news.dart';

class SQLiteDbProvider {
  SQLiteDbProvider._();
  static final SQLiteDbProvider db = SQLiteDbProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "BookMarkNews.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE BookMarkNews( id INTEGER PRIMARY KEY, author TEXT, title TEXT,  content TEXT,  imageUrl TEXT,readMoreUrl TEXT, date TEXT)');
    });
  }

  Future<List<News>> getAllNews() async {
    final db = await database;
    List<Map<String, dynamic>> results =
        await db.query("BookMarkNews", columns: News.columns);
    List<News> dataList = [];
    for (var result in results) {
      News data = News.fromMap(result);
      dataList.add(data);
    }
    return dataList;
  }

  insert(News data) async {
    final db = await database;

    var result = await db.rawInsert(
        "INSERT Into BookMarkNews (author,title,content,imageUrl,readMoreUrl,date)"
        " VALUES (?, ?, ?, ?,?,?)",
        [
          data.author,
          data.title,
          data.content,
          data.imageUrl,
          data.readMoreUrl,
          data.date
        ]);
    return result;
  }

  delete(String title) async {
    final db = await database;

    db.delete('BookMarkNews', where: "title =?", whereArgs: [title]);
  }
}
