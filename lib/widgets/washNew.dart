import 'package:flutter/material.dart';
import 'package:wash_x/custom/customWashNewTile.dart';
import 'package:wash_x/enum.dart';
import 'package:wash_x/helpers/my_flutter_app_icons.dart';
import 'package:groovin_widgets/groovin_widgets.dart';
import 'package:wash_x/models/washTypeModel.dart';
import 'package:wash_x/widgets/wash_type.dart';

class WashNew extends StatefulWidget {
  final VoidCallback callback;
  final VoidCallback callbackMain;

  WashNew({this.callback, this.callbackMain});

  @override
  WashNewState createState() => WashNewState();
}

class WashNewState extends State<WashNew> with TickerProviderStateMixin {
  TabController tabController;
  List<WashTypeModels> _items = <WashTypeModels>[
    WashTypeModels(
        washTypeName: "",
        isSelected: false,
        washTypeImage: "images/wash_t_1.png"),
    WashTypeModels(
        washTypeName: "",
        isSelected: false,
        washTypeImage: "images/wash_t_2.png"),
    WashTypeModels(
        washTypeName: "",
        isSelected: false,
        washTypeImage: "images/wash_t_3.png"),
    WashTypeModels(
        washTypeName: "",
        isSelected: false,
        washTypeImage: "images/wash_t_4.png"),
    WashTypeModels(
        washTypeName: "",
        isSelected: false,
        washTypeImage: "images/wash_t_5.png"),
    WashTypeModels(
        washTypeName: "",
        isSelected: false,
        washTypeImage: "images/wash_t_6.png"),
    WashTypeModels(
        washTypeName: "",
        isSelected: false,
        washTypeImage: "images/wash_t_7.png"),
  ];
  int currentIndex = 0;
  int currentIndexTab = 0;
  final mSearchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    tabController.addListener(_handleTabSelection);
  }

  var heightInitial = 350.0;
  var heightFull;
  var widthFull;
  bool _isPageFull = false;
  var height;

  ScrollController _scrollController = new ScrollController();

  void _handleTabSelection() {
    setState(() {
      currentIndexTab = tabController.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    heightFull = MediaQuery.of(context).size.height;
    widthFull = MediaQuery.of(context).size.width;
    height = _isPageFull ? heightFull : heightInitial;
    if (currentIndexTab == 1) {
      height = _isPageFull ? heightFull : (heightInitial - 80.0);
    } else if (currentIndexTab == 0) {
      FocusScope.of(context).requestFocus(new FocusNode());
    }

    return GestureDetector(
      onVerticalDragStart: (x) => _dragStart(x),
      onVerticalDragUpdate: (x) => _dragEnd(x),
      onVerticalDragDown: (x) => _dragDown(x),

      // onTap: () {
      //   debugPrint("*********************************************");
      //   _isPageFull = !_isPageFull;
      //   setState(() {});
      // },
      child: AnimatedSize(
        vsync: this,
        curve: Curves.linear,
        duration: new Duration(milliseconds: 650),
        child: Container(
          height: height,
          margin: EdgeInsets.only(top: 5.0),
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: _isPageFull
                  ? null
                  : [
                      BoxShadow(
                        color: Colors.grey[350],
                        blurRadius: 2.0,
                        spreadRadius: 2.0,
                      )
                    ]),
          width: MediaQuery.of(context).size.width,
          child: Column(children: [
            _isPageFull
                ? Container()
                : Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ModalDrawerHandle(),
                  ),
            // ),
            Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 8.0, right: 8.0),
                  height: height - 30.0,
                  width: MediaQuery.of(context).size.width,
                  child: TabBarView(
                    physics:
                        !_isPageFull ? NeverScrollableScrollPhysics() : null,
                    controller: tabController,
                    children: <Widget>[
                      _buildAutoContainer(),
                      _buildManualContainer(),
                    ],
                  ),
                ),
                Positioned(
                    bottom: 0.0,
                    right: 0.0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 10.0, right: 10.0),
                          height: 40.0,
                          width: 200.0,
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(25.0)),
                          child: TabBar(
                            labelColor: Colors.white,
                            unselectedLabelColor: Colors.blue,
                            isScrollable: false,
                            indicator: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(25.0)),
                            controller: tabController,
                            tabs: <Widget>[
                              Container(
                                height: 25.0,
                                alignment: Alignment.center,
                                child: Text(
                                  "AUTO",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 11.0),
                                ),
                              ),
                              Container(
                                height: 25.0,
                                alignment: Alignment.center,
                                child: Text(
                                  "MANUAL",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 11.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                        _isPageFull
                            ? AnimatedContainer(
                                duration: Duration(milliseconds: 800),
                                width: MediaQuery.of(context).size.width,
                                height: _isPageFull ? 52.0 : 0.0,
                                //color: Colors.white,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey[350],
                                          blurRadius: 2.0,
                                          spreadRadius: 2.0)
                                    ]),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    IconButton(
                                      icon: Icon(Icons.arrow_back),
                                      onPressed: widget.callback,
                                    ),
                                    Text(
                                      "WARDROBE",
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.more_vert),
                                      onPressed: widget.callback,
                                    ),
                                  ],
                                ),
                              )
                            : Container()
                      ],
                    ))
              ],
            )
          ]),
        ),
      ),
    );
    /*return Scaffold(
        resizeToAvoidBottomPadding: false,
     
        body:);*/
  }

  _buildAutoContainer() {
    return Container(
      margin: EdgeInsets.only(bottom: 50.0),
      child: ListView.builder(
          controller: _scrollController,
          physics: !_isPageFull ? NeverScrollableScrollPhysics() : null,
          itemCount: _washNewList.length,
          itemBuilder: (BuildContext context, int index) {
            var item = _washNewList[index];
            return CustomWashNewTile(
              icon: item.icon,
              isSelected: item.isSelected,
              item: item.item,
              priceLabel: item.price,
              onPressed:widget.callbackMain ,
              onPressedDot:  () {
                _washNewList[index].isSelected =
                !_washNewList[index].isSelected;
                if (_isPageFull) {
                  _isPageFull = true;
                } else {
                  _isPageFull = false;
                }
                setState(() {});
              }                ,
            );
          }),
    );
  }

  _buildManualContainer() {
    return IndexedStack(
      index: currentIndex,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 15.0, left: 3.0),
                child: Text(
                  "CREATE WASH",
                  style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 12.0,
                  ),
                ),
              ),
              TextField(
                controller: mSearchController,
                decoration: new InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
                  prefixIcon: new IconButton(
                    onPressed: null,
                    icon: new Icon(Icons.search),
                    color: Colors.black,
                  ),
                  labelText: "NAME",
                  labelStyle: new TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey,
                  ),
                  hintStyle: new TextStyle(
                      fontSize: 10.0, color: Colors.grey.withOpacity(0.1)),
                  border: new OutlineInputBorder(
                      gapPadding: 8.0,
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide:
                          new BorderSide(color: Colors.grey, width: 10.0)),
                ),
              ),
              Container(
                alignment: Alignment.topRight,
                child: RaisedButton(
                  onPressed: () {
                    currentIndex = 1;
                    FocusScope.of(context).requestFocus(new FocusNode());
                    setState(() {});
                  },
                  child: new Text(
                    "NEXT",
                    style: TextStyle(color: Colors.blueAccent, fontSize: 12.0),
                  ),
                  color: Colors.white,
                  shape: StadiumBorder(
                      // side: BorderSide(color: Colors.grey[300], width: 2.0)
                      ),
                ),
              )
            ],
          ),
        ),
        Container(
          width: widthFull,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              WashTypeList(
                items: _items,
              ),
              RaisedButton(
                onPressed: () {
                  currentIndex = 0;
                  setState(() {});
                },
                child: new Text(
                  "NEXT",
                  style: TextStyle(color: Colors.blueAccent, fontSize: 12.0),
                ),
                color: Colors.white,
                shape: StadiumBorder(
                    // side: BorderSide(color: Colors.grey[300], width: 2.0)
                    ),
              )
            ],
          ),
        ),
      ],
    );
  }

  var pos;

  void _dragStart(DragStartDetails details) {
    var tt = details.globalPosition;
    pos = tt.dy;
  }

  void _dragEnd(DragUpdateDetails det) {
    if (det.globalPosition.dy < pos - 10.0) {
      _isPageFull = true;
      setState(() {});
    }
  }

  void _dragDown(DragDownDetails det) {
    if (det.globalPosition.dy < pos / 2) {
      if (_scrollController.position.pixels == 0) {
        _isPageFull = false;
      }
      setState(() {});
    }
  }
}

List<WashNewItem> _washNewList = <WashNewItem>[
  WashNewItem(
      icon: Icon(MyFlutterApp.tshirt),
      isSelected: false,
      item: "T-Shirt",
      price: "10.0"),
  WashNewItem(
      icon: Icon(MyFlutterApp.shirt),
      isSelected: false,
      item: "Shirt",
      price: "12.5"),
  WashNewItem(
      icon: Icon(MyFlutterApp.skirt),
      isSelected: true,
      item: "Skirt",
      price: "11.0"),
  WashNewItem(
      icon: Icon(MyFlutterApp.shorts),
      isSelected: true,
      item: "Shorts",
      price: "10.0"),
  WashNewItem(
      icon: Icon(MyFlutterApp.pants),
      isSelected: false,
      item: "Pants",
      price: "15.0"),
  WashNewItem(
      icon: Icon(MyFlutterApp.tshirt),
      isSelected: false,
      item: "T-Shirt",
      price: "10.0"),
  WashNewItem(
      icon: Icon(MyFlutterApp.shirt),
      isSelected: false,
      item: "Shirt",
      price: "12.5"),
  WashNewItem(
      icon: Icon(MyFlutterApp.skirt),
      isSelected: true,
      item: "Skirt",
      price: "11.0"),
  WashNewItem(
      icon: Icon(MyFlutterApp.shorts),
      isSelected: true,
      item: "Shorts",
      price: "10.0"),
  WashNewItem(
      icon: Icon(MyFlutterApp.pants),
      isSelected: false,
      item: "Pants",
      price: "15.0"),
  WashNewItem(
      icon: Icon(MyFlutterApp.pants),
      isSelected: false,
      item: "Pants",
      price: "15.0"),
  WashNewItem(
      icon: Icon(MyFlutterApp.pants),
      isSelected: false,
      item: "Pants",
      price: "15.0"),
  WashNewItem(
      icon: Icon(MyFlutterApp.pants),
      isSelected: false,
      item: "Pants",
      price: "15.0"),
  WashNewItem(
      icon: Icon(MyFlutterApp.pants),
      isSelected: false,
      item: "Pants",
      price: "15.0"),
  WashNewItem(
      icon: Icon(MyFlutterApp.pants),
      isSelected: false,
      item: "Pants",
      price: "15.0"),
];

class WashNewItem {
  WashNewItem({this.icon, this.isSelected, this.item, this.price});

  Icon icon;
  bool isSelected;
  String item;
  String price;
}
