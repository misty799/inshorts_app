import 'package:flutter/material.dart';
import 'package:test_app/bloc/data_bloc.dart';
import 'package:test_app/bloc/data_event.dart';
import 'package:test_app/models/news.dart';

class DataTileWidget extends StatefulWidget {
  const DataTileWidget(
      {Key key, this.data, this.index, this.dataBloc, this.bookMarked})
      : super(key: key);

  final News data;
  final int index;
  final DataBloc dataBloc;
  final bool bookMarked;

  @override
  _DataTileWidgetState createState() => _DataTileWidgetState();
}

class _DataTileWidgetState extends State<DataTileWidget> {
  @override
  Widget build(BuildContext context) {
    widget.dataBloc.dataEventSink.add(FetchBookMark());
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(children: [
            Image.network(
              widget.data.imageUrl,
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fill,
            ),
            if (!widget.bookMarked)
              Positioned(
                  right: 0,
                  child: Container(
                    color: Colors.white,
                    child: IconButton(
                        onPressed: () {
                          widget.dataBloc.dataEventSink
                              .add(AddBookMark(widget.data));
                        },
                        icon: Icon(
                          Icons.bookmark_add_outlined,
                          size: 30,
                          color: Colors.black,
                        )),
                  )),
            if (widget.bookMarked)
              Positioned(
                  right: 0,
                  child: Container(
                    color: Colors.white,
                    child: IconButton(
                        onPressed: () {
                          widget.dataBloc.dataEventSink
                              .add(DeleteBookMark(title: widget.data.title));
                        },
                        icon: Icon(
                          Icons.bookmark_remove,
                          size: 30,
                          color: Colors.black,
                        )),
                  )),
          ]),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              widget.data.title,
              style: TextStyle(fontSize: 20, height: 1.5),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 14.0, left: 14.0, right: 14.0),
            child: RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                  text: widget.data.content,
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w300,
                      fontSize: 16,
                      height: 1.5),
                  children: [
                    if (widget.data.readMoreUrl != null)
                      const TextSpan(
                          text: "swipe left to readmore >>",
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.w600))
                  ]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Text(
              "published on : " + widget.data.date,
              style: TextStyle(color: Colors.grey),
            ),
          )
        ],
      ),
    );
  }
}
