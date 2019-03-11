import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  TabController _tabController;
  int _currentIndex = 0;
  VoidCallback _showBottomSheetCallBack;

  @override
  void initState() {
    super.initState();
    _showBottomSheetCallBack = _showBottomSheet;
    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showBottomSheet() {
    setState(() {
      _showBottomSheetCallBack = null;
    });

    _scaffoldKey.currentState
        .showBottomSheet((context) {
      return new StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              margin: new EdgeInsets.only(top: 20.0),
              child: new Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  new TabBarView(
                    controller: _tabController,
                    children: <Widget>[
                      new Container(
                        color: Colors.white,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            new Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(16.0),
                                      topLeft: Radius.circular(16.0))),
                              padding: EdgeInsets.only(top: 0.5),
                              child: new Container(
                                padding: EdgeInsets.all(20.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(16.0),
                                        topRight: Radius.circular(16.0))),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      child: Card(
                                        margin: const EdgeInsets.all(15.0),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(
                                                "How to change your password?",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontSize: 15.0,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(
                                                "\nWhen you change your password, make sure you \nhave the old one ready so you can change \nbefore if is disregarded",
                                                style: TextStyle(
                                                  fontSize: 12.0,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Card(
                                        margin: const EdgeInsets.all(15.0),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(
                                                "How to change your password?",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontSize: 15.0,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(
                                                "\nWhen you change your password, make sure you \nhave the old one ready so you can change \nbefore if is disregarded",
                                                style: TextStyle(
                                                  fontSize: 12.0,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: Card(
                                        margin: const EdgeInsets.all(15.0),
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(
                                                "How to change your password?",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontSize: 15.0,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Text(
                                                "\nWhen you change your password, make sure you \nhave the old one ready so you can change \nbefore if is disregarded",
                                                style: TextStyle(
                                                  fontSize: 12.0,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        new Center(
                                            child: Column(
                                              children: <Widget>[
                                                Container(
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.rectangle,
                                                        borderRadius:
                                                        BorderRadius.all(Radius
                                                            .circular(5.0))),
                                                    child: Icon(Icons.apps)),
                                              ],
                                            )),
                                        new Center(
                                            child: Column(
                                              children: <Widget>[
                                                Container(
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.rectangle,
                                                        borderRadius:
                                                        BorderRadius.all(Radius
                                                            .circular(5.0))),
                                                    child: Icon(Icons.search)),
                                              ],
                                            ))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      new Container(
                        child: new Text('Tab 2'),
                      ),
                      new Container(
                        child: new Text('Tab 3'),
                      )
                    ],
                  ),
                  new Positioned(
                    bottom: 0.0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      width: MediaQuery.of(context).size.width,
                      height: 50.0,
                      color: Colors.white,
                      child: new Container(
                        alignment: Alignment.center,
                        child: new PreferredSize(
                          preferredSize: const Size.fromHeight(10.0),
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              accentColor: Colors.blue.withOpacity(0.4),
                            ),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.center,
                                  child: TabPageSelector(
                                    controller: _tabController,
                                    color: Colors.blue.withOpacity((0.4)),
                                    selectedColor: Colors.blueAccent,
                                    indicatorSize: 8.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
    })
        .closed
        .whenComplete(() {
      if (mounted) {
        setState(() {
          _showBottomSheetCallBack = _showBottomSheet;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      key: _scaffoldKey,
      body: new Padding(
        padding: const EdgeInsets.all(20.0),
        child: new Center(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new RaisedButton(
                  onPressed: _showBottomSheetCallBack,
                  child: new Text("Help Center"),
                ),
              ],
            )),
      ),
    );
  }
}
