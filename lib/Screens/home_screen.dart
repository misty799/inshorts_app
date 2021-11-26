import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:test_app/Screens/bookmark_screen.dart';
import 'package:test_app/Screens/home_drawer.dart';
import 'package:test_app/Utils/data_tile_widget.dart';
import 'package:test_app/bloc/data_event.dart';
import 'package:test_app/bloc/data_bloc.dart';
import 'package:test_app/models/news.dart';
import 'package:test_app/models/user.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _itemPositionListener = ItemPositionsListener.create();
  final _scrollController = ItemScrollController();
  bool isLoading = false;
  String errorText = '';

  DataBloc _dataBloc;
  List<News> datalist = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _dataBloc = BlocProvider.of<DataBloc>(context);

    _dataBloc.dataEventSink.add(FetchData(category: "national"));

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: HomeDrawer(),
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Discover",
          ),
          actions: [
            PopupMenuButton(
                icon: Icon(Icons.more_horiz_rounded),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      child: const Text("all"),
                      value: 1,
                      onTap: () {
                        _dataBloc.dataEventSink.add(FetchData(category: 'all'));
                      },
                    ),
                    PopupMenuItem(
                      child: Text("national"),
                      value: 2,
                      onTap: () {
                        _dataBloc.dataEventSink
                            .add(FetchData(category: 'national'));
                      },
                    ),
                    PopupMenuItem(
                      child: Text("business"),
                      value: 3,
                      onTap: () {
                        _dataBloc.dataEventSink
                            .add(FetchData(category: 'business'));
                      },
                    ),
                    PopupMenuItem(
                      child: Text("sports"),
                      value: 4,
                      onTap: () {
                        _dataBloc.dataEventSink
                            .add(FetchData(category: 'sports'));
                      },
                    ),
                    PopupMenuItem(
                      child: Text("world"),
                      value: 5,
                      onTap: () {
                        _dataBloc.dataEventSink
                            .add(FetchData(category: 'world'));
                      },
                    ),
                    PopupMenuItem(
                      child: Text("politics"),
                      value: 6,
                      onTap: () {
                        _dataBloc.dataEventSink
                            .add(FetchData(category: 'politics'));
                      },
                    ),
                    PopupMenuItem(
                      child: Text("technology"),
                      value: 7,
                      onTap: () {
                        _dataBloc.dataEventSink
                            .add(FetchData(category: 'technology'));
                      },
                    ),
                    PopupMenuItem(
                      child: Text("startup"),
                      value: 8,
                      onTap: () {
                        _dataBloc.dataEventSink
                            .add(FetchData(category: 'startup'));
                      },
                    ),
                    PopupMenuItem(
                      child: Text("entertainment"),
                      value: 9,
                      onTap: () {
                        _dataBloc.dataEventSink
                            .add(FetchData(category: 'entertainment'));
                      },
                    ),
                    PopupMenuItem(
                      child: Text("miscellaneous"),
                      value: 10,
                      onTap: () {
                        _dataBloc.dataEventSink
                            .add(FetchData(category: 'miscellaneous'));
                      },
                    ),
                    PopupMenuItem(
                      child: Text("hatke"),
                      value: 11,
                      onTap: () {
                        _dataBloc.dataEventSink
                            .add(FetchData(category: 'htake'));
                      },
                    ),
                    PopupMenuItem(
                      child: Text("science"),
                      value: 12,
                      onTap: () {
                        _dataBloc.dataEventSink
                            .add(FetchData(category: 'science'));
                      },
                    ),
                  ];
                }),
            IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return BookMarkScreen();
                  }));
                },
                icon: const Icon(
                  Icons.bookmark_outline,
                ))
          ],
        ),
        body: StreamBuilder(
          stream: _dataBloc.newsStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final list = snapshot.data as List<News>;
              return ScrollablePositionedList.builder(
                  itemPositionsListener: _itemPositionListener,
                  itemScrollController: _scrollController,
                  itemCount: list.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, i) {
                    News data = list[i];
                    return GestureDetector(
                      onVerticalDragEnd: (details) {
                        if (details.primaryVelocity == 0) return;
                        double velocity = details.primaryVelocity;
                        if (velocity < 0 && i < list.length - 1) {
                          _scrollController.scrollTo(
                              index: i + 1,
                              duration: Duration(seconds: 1),
                              curve: Curves.decelerate);
                        } else if (i > 0) {
                          _scrollController.scrollTo(
                              index: i - 1,
                              duration: Duration(seconds: 1),
                              curve: Curves.decelerate);
                        }
                      },
                      onHorizontalDragEnd: (DragEndDetails details) {
                        if (details.primaryVelocity == 0) return;
                        if (details.primaryVelocity.compareTo(0) == -1) {
                          launch(data.readMoreUrl);
                        }
                      },
                      child: DataTileWidget(
                          data: data,
                          index: i,
                          dataBloc: _dataBloc,
                          bookMarked: false),
                    );
                  });
            } else {
              return Center(
                  child: SpinKitThreeBounce(
                color: Colors.blue,
              ));
            }
          },
        ));
  }
}
