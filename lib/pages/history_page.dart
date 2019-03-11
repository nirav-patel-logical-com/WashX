import 'package:flutter/material.dart';
import 'package:wash_x/custom/custom_expansion_tile.dart';
import 'package:wash_x/enum.dart';
import 'package:wash_x/models/history-model.dart';

class History extends StatefulWidget {
  final Function callback;

  History(this.callback);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> with SingleTickerProviderStateMixin {
  PersistentBottomSheetController bottomSheetController;
  List<Widget> historyItems = new List();
  Widget currentPage;
  List<HistoryModel> _items = <HistoryModel>[
    HistoryModel(
        strTitle: 'Colored Wash',
        strPrice: "\$28.08",
        strStatus: 'INCOMPLITED',
        strDate: 'June 12',
        cardColor: Colors.red),
    HistoryModel(
        strTitle: 'Colored Wash',
        strPrice: "\$28.08",
        strStatus: 'COMPLITED',
        strDate: 'June 12',
        cardColor: Colors.green),
    HistoryModel(
        strTitle: 'Colored Wash',
        strPrice: "\$28.08",
        strStatus: 'INCOMPLITED',
        strDate: 'June 12',
        cardColor: Colors.green),
    HistoryModel(
        strTitle: 'Colored Wash',
        strPrice: "\$28.08",
        strStatus: 'COMPLITED',
        strDate: 'June 12',
        cardColor: Colors.green),
    HistoryModel(
        strTitle: 'Colored Wash',
        strPrice: "\$28.08",
        strStatus: 'COMPLITED',
        strDate: 'June 12',
        cardColor: Colors.green),
    HistoryModel(
        strTitle: 'Colored Wash',
        strPrice: "\$28.08",
        strStatus: 'COMPLITED',
        strDate: 'June 12',
        cardColor: Colors.green),
    HistoryModel(
        strTitle: 'Colored Wash',
        strPrice: "\$28.08",
        strStatus: 'COMPLITED',
        strDate: 'June 12',
        cardColor: Colors.green),
    HistoryModel(
        strTitle: 'Colored Wash',
        strPrice: "\$28.08",
        strStatus: 'COMPLITED',
        strDate: 'June 12',
        cardColor: Colors.green),
    HistoryModel(
        strTitle: 'Colored Wash',
        strPrice: "\$28.08",
        strStatus: 'COMPLITED',
        strDate: 'June 12',
        cardColor: Colors.green),
    HistoryModel(
        strTitle: 'Colored Wash',
        strPrice: "\$28.08",
        strStatus: 'COMPLITED',
        strDate: 'June 12',
        cardColor: Colors.green),
    HistoryModel(
        strTitle: 'Colored Wash',
        strPrice: "\$28.08",
        strStatus: 'COMPLITED',
        strDate: 'June 12',
        cardColor: Colors.green),
    HistoryModel(
        strTitle: 'Colored Wash',
        strPrice: "\$28.08",
        strStatus: 'COMPLITED',
        strDate: 'June 12',
        cardColor: Colors.green),
    HistoryModel(
        strTitle: 'Colored Wash',
        strPrice: "\$28.08",
        strStatus: 'COMPLITED',
        strDate: 'June 12',
        cardColor: Colors.green),
    HistoryModel(
        strTitle: 'Colored Wash',
        strPrice: "\$28.08",
        strStatus: 'COMPLITED',
        strDate: 'June 12',
        cardColor: Colors.green),
    HistoryModel(
        strTitle: 'Colored Wash',
        strPrice: "\$28.08",
        strStatus: 'COMPLITED',
        strDate: 'June 12',
        cardColor: Colors.green),
    HistoryModel(
        strTitle: 'Colored Wash',
        strPrice: "\$28.08",
        strStatus: 'COMPLITED',
        strDate: 'June 12',
        cardColor: Colors.green),
    HistoryModel(
        strTitle: 'Colored Wash',
        strPrice: "\$28.08",
        strStatus: 'COMPLITED',
        strDate: 'June 12',
        cardColor: Colors.green),
    HistoryModel(
        strTitle: 'Colored Wash',
        strPrice: "\$28.08",
        strStatus: 'COMPLITED',
        strDate: 'June 12',
        cardColor: Colors.green),
    HistoryModel(
        strTitle: 'Colored Wash',
        strPrice: "\$28.08",
        strStatus: 'COMPLITED',
        strDate: 'June 12',
        cardColor: Colors.green),
    HistoryModel(
        strTitle: 'Colored Wash',
        strPrice: "\$28.08",
        strStatus: 'COMPLITED',
        strDate: 'June 12',
        cardColor: Colors.green),
    HistoryModel(
        strTitle: 'Colored Wash',
        strPrice: "\$28.08",
        strStatus: 'COMPLITED',
        strDate: 'June 12',
        cardColor: Colors.green),
    HistoryModel(
        strTitle: 'Colored Wash',
        strPrice: "\$28.08",
        strStatus: 'COMPLITED',
        strDate: 'June 12',
        cardColor: Colors.green),
    HistoryModel(
        strTitle: 'Colored Wash',
        strPrice: "\$28.08",
        strStatus: 'COMPLITED',
        strDate: 'June 12',
        cardColor: Colors.green),
    HistoryModel(
        strTitle: 'Colored Wash',
        strPrice: "\$28.08",
        strStatus: 'COMPLITED',
        strDate: 'June 12',
        cardColor: Colors.green),
    HistoryModel(
        strTitle: 'Colored Wash',
        strPrice: "\$28.08",
        strStatus: 'INCOMPLITED',
        strDate: 'June 12',
        cardColor: Colors.red),
    HistoryModel(
        strTitle: 'Colored Wash',
        strPrice: "\$28.08",
        strStatus: 'COMPLITED',
        strDate: 'June 12',
        cardColor: Colors.green),
    HistoryModel(
        strTitle: 'Colored Wash',
        strPrice: "\$28.08",
        strStatus: 'COMPLITED',
        strDate: 'June 12',
        cardColor: Colors.green),
    HistoryModel(
        strTitle: 'Colored Wash',
        strPrice: "\$28.08",
        strStatus: 'COMPLITED',
        strDate: 'June 12',
        cardColor: Colors.green),
    HistoryModel(
        strTitle: 'Colored Wash',
        strPrice: "\$28.08",
        strStatus: 'INCOMPLITED',
        strDate: 'June 12',
        cardColor: Colors.red),
    HistoryModel(
        strTitle: 'Colored Wash',
        strPrice: "\$28.08",
        strStatus: 'COMPLITED',
        strDate: 'June 12',
        cardColor: Colors.green),
    HistoryModel(
        strTitle: 'Colored Wash',
        strPrice: "\$28.08",
        strStatus: 'COMPLITED',
        strDate: 'June 12',
        cardColor: Colors.green),
    HistoryModel(
        strTitle: 'Colored Wash',
        strPrice: "\$28.08",
        strStatus: 'COMPLITED',
        strDate: 'June 12',
        cardColor: Colors.green),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < _items.length; i++) {
      historyItems.add(Card(
        elevation: 5.0,
        child: Container(
          decoration: new BoxDecoration(
              border: new Border(
                  bottom: BorderSide(color: _items[i].cardColor, width: 3.0))),
          padding:
              EdgeInsets.only(left: 15.0, right: 10.0, top: 15.0, bottom: 15.0),
          child: CustomExpansionTile(
              header: Row(
                children: <Widget>[
                  Image.asset(
                    "images/ic_basket.png",
                    height: 40.0,
                    color: Colors.grey,
                  ),
                  Padding(padding: EdgeInsets.only(left: 8.0)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          _items[i].strTitle,
                          style:
                              TextStyle(color: Colors.black54, fontSize: 12.0),
                        ),
                        Padding(padding: EdgeInsets.only(top: 4.0)),
                        Text(
                          _items[i].strPrice,
                          style:
                              TextStyle(color: Colors.black54, fontSize: 10.0),
                        ),
                      ],
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(left: 8.0)),
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Text(
                          _items[i].strStatus,
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 12.0,
                              fontWeight: FontWeight.w600),
                        ),
                        Padding(padding: EdgeInsets.only(top: 4.0)),
                        Text(
                          _items[i].strDate,
                          style:
                              TextStyle(color: Colors.black54, fontSize: 10.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              children: Container(
                margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(6.0),
                            margin: new EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: new BorderRadius.only(
                                  topLeft: new Radius.circular(20.0),
                                  bottomLeft: new Radius.circular(20.0),
                                  topRight: new Radius.circular(20.0),
                                  bottomRight: new Radius.circular(20.0),
                                ),
                                boxShadow: [
                                  new BoxShadow(
                                    color: Colors.black.withOpacity(0.5),
                                    offset: Offset(1.0, 1.0),
                                    blurRadius: 1.0,
                                  )
                                ]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(right: 8.0),
                                  child: Image.asset(
                                    "images/ic_basket.png",
                                    height: 20.0,
                                    color: Colors.grey,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      _items[i].strTitle,
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 10.0),
                                    ),
                                    Padding(padding: EdgeInsets.only(top: 4.0)),
                                    Text(
                                      _items[i].strPrice,
                                      style: TextStyle(
                                          color: Colors.black54, fontSize: 8.0),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(left: 15.0)),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(6.0),
                            margin: new EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: new BorderRadius.only(
                                  topLeft: new Radius.circular(20.0),
                                  bottomLeft: new Radius.circular(20.0),
                                  topRight: new Radius.circular(20.0),
                                  bottomRight: new Radius.circular(20.0),
                                ),
                                boxShadow: [
                                  new BoxShadow(
                                    color: Colors.black.withOpacity(0.5),
                                    offset: Offset(1.0, 1.0),
                                    blurRadius: 1.0,
                                  )
                                ]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(right: 8.0),
                                  child: Image.asset(
                                    "images/ic_basket.png",
                                    height: 20.0,
                                    color: Colors.grey,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      _items[i].strTitle,
                                      style: TextStyle(
                                          color: Colors.black54,
                                          fontSize: 10.0),
                                    ),
                                    Padding(padding: EdgeInsets.only(top: 4.0)),
                                    Text(
                                      _items[i].strPrice,
                                      style: TextStyle(
                                          color: Colors.black54, fontSize: 8.0),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(
                              left: 10.0, right: 10.0, bottom: 6.0, top: 6.0),
                          margin: new EdgeInsets.all(4.0),
                          child: InkResponse(
                            child: Text(
                              "REPORT AND ISSUE",
                              style: new TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            onTap: () {},
                            highlightShape: BoxShape.rectangle,
                            highlightColor: Colors.black54,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.only(
                              left: 10.0, right: 10.0, bottom: 6.0, top: 6.0),
                          margin: new EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: new BorderRadius.only(
                                topLeft: new Radius.circular(20.0),
                                bottomLeft: new Radius.circular(20.0),
                                topRight: new Radius.circular(20.0),
                                bottomRight: new Radius.circular(20.0),
                              ),
                              boxShadow: [
                                new BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 1.0,
                                )
                              ]),
                          child: InkWell(
                            child: Text(
                              "ALL GOOD",
                              style: new TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            onTap: () {
                              _showItemSheet();
                            },
                            highlightColor: Colors.black54,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              )),
        ),
      ));
    }

    return Scaffold(
      key: currentPageKey,
      body: new Column(
        children: <Widget>[
          Expanded(
              child: Container(
            margin: EdgeInsets.all(10.0),
            child: ListView(
              children: historyItems,
            ),
          )),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              InkResponse(
                onTap: () {
                  this.widget.callback(PageType.WASHPAGE);
                },
                child: Icon(Icons.arrow_back),
              ),
              new Container(
                alignment: Alignment.center,
                child: new PreferredSize(
                  preferredSize: const Size.fromHeight(10.0),
                  child: Theme(
                    data: Theme.of(context).copyWith(
                          accentColor: Colors.blue.withOpacity(0.4),
                        ),
                    child: Container(
                        margin: const EdgeInsets.all(10.0),
                        child: new Text(
                          'HISTORY',
                          style: new TextStyle(
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent),
                        )),
                  ),
                ),
              ),
              InkResponse(
                onTap: () {
                  _showItemSheet();
                },
                child: Icon(Icons.more_vert),
              )
            ],
          ),
        ],
      ),
    );
  }

  final currentPageKey = new GlobalKey<ScaffoldState>();

  _showItemSheet() {
    bottomSheetController = currentPageKey.currentState
        .showBottomSheet<Null>((BuildContext context) {
      return new Container(
          margin: EdgeInsets.only(top: 5.0),
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          width: MediaQuery.of(context).size.width,
          decoration: new BoxDecoration(
              color: Colors.white,
              //    border: Border.all(color: Colors.transparent),
              boxShadow: [
                new BoxShadow(
                    blurRadius: 5.0,
                    //spreadRadius: 3.0,
                    color: Colors.grey)
              ],
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0))),
          child: new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Container(
                  width: 50.0,
                  height: 10.0,
                  decoration: new BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  )),
              new Container(
                padding: const EdgeInsets.all(10.0),
                margin: EdgeInsets.only(bottom: 40.0, top: 20.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    new Row(
                      children: <Widget>[
                        new Flexible(
                          child: new Column(
                            children: <Widget>[
                              new Container(
                                child: new Text('Report An Issue',
                                    softWrap: true,
                                    textDirection: TextDirection.ltr,
                                    style: new TextStyle(fontSize: 16.0)),
                              ),
                              new SizedBox(
                                height: 4.0,
                              ),
                              new Container(
                                child: new Text(
                                    "we are sorry you having issue, please contact us and we will resolved your issue ASAP",
                                    softWrap: true,
                                    textDirection: TextDirection.ltr,
                                    style: new TextStyle(fontSize: 12.0)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ));
    });
  }
}
