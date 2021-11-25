import 'package:flutter/material.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:test_app/Utils/data_tile_widget.dart';
import 'package:test_app/bloc/data_bloc.dart';
import 'package:test_app/bloc/data_event.dart';
import 'package:test_app/models/news.dart';

class BookMarkScreen extends StatefulWidget {
  const BookMarkScreen({Key key}) : super(key: key);

  @override
  _BookMarkScreenState createState() => _BookMarkScreenState();
}

class _BookMarkScreenState extends State<BookMarkScreen> {
  DataBloc _dataBloc;

  @override
  void didChangeDependencies() {
    _dataBloc = BlocProvider.of<DataBloc>(context);

    _dataBloc.dataEventSink.add(FetchBookMark());

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "BookMarked News",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: StreamBuilder<List<News>>(
        stream: _dataBloc.bookmarkDataStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final list = snapshot.data as List<News>;
            return ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, i) {
                  return DataTileWidget(
                      bookMarked: true,
                      data: list[i],
                      index: i,
                      dataBloc: _dataBloc);
                });
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
