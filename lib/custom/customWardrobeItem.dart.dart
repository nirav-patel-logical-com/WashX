import 'package:flutter/material.dart';
import 'package:wash_x/models/WashItemCare.dart';
import 'package:wash_x/models/washItem.dart';
import 'package:wash_x/models/washItemBrand.dart';
import 'package:wash_x/models/washItemColor.dart';

const Duration _kExpand = const Duration(milliseconds: 200);

class CustomWardrobeExpansionTile extends StatefulWidget {
  const CustomWardrobeExpansionTile({
    Key key,
    this.onExpansionChanged,
    this.index,
    this.callback,
    this.callbackExpandTile,
    this.item,
    this.state,
    
    this.initiallyExpanded: false,
  })  : assert(initiallyExpanded != null),
        super(key: key);

  final VoidCallback callback;
  final VoidCallback callbackExpandTile;
  final WashItem item;

  ///get index
  final int index;

  /// the value false.
  final ValueChanged<bool> onExpansionChanged;

  /// Specifies if the list tile is initially expanded (true) or collapsed (false, the default).
  final bool initiallyExpanded;
  final CustomWardrobeExpansionTileState state;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return state;
  }
//  @override
  //CustomWardrobeExpansionTileState createState() => state;
}

class CustomWardrobeExpansionTileState
    extends State<CustomWardrobeExpansionTile>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  CurvedAnimation _easeInAnimation;

  bool _isExpanded = true;

  bool isExpanded() {
    return _isExpanded;
  }

  changeExpansion(bool value) {
    _isExpanded = !value;
    _handleTap();
  }

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(duration: _kExpand, vsync: this);
    _easeInAnimation =
        new CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _isExpanded =
        PageStorage.of(context)?.readState(context) ?? widget.initiallyExpanded;
    if (_isExpanded) _controller.value = 1.0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded)
        _controller.forward();
      else
        _controller.reverse().then((value) {
          setState(() {
            // Rebuild without widget.children.
          });
        });
      PageStorage.of(context)?.writeState(context, _isExpanded);
    });
    if (widget.onExpansionChanged != null)
      widget.onExpansionChanged(_isExpanded);
  }

  @override
  Widget build(BuildContext context) {
    final bool closed = !_isExpanded && _controller.isDismissed;
    return new Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      alignment: Alignment.center,
      margin: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
          boxShadow: [
            new BoxShadow(
              offset: Offset(1.0, 1.5),
              blurRadius: 1.0,
              spreadRadius: 1.5,
              color: Colors.grey[300],
            )
          ]),
      child: new AnimatedBuilder(
        animation: _controller.view,
        builder: _buildChildren,
        child: closed ? null : _buildChild(),
      ),
    );
  }

  Widget _buildChildren(BuildContext context, Widget child) {
    return new Container(
      constraints: BoxConstraints(minHeight: 35.0),
        child: new Stack(
      children: <Widget>[
        new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            !_isExpanded
                ? IconTheme.merge(
                    data: new IconThemeData(),
                    child: new InkWell(
                      onTap: widget.callbackExpandTile,
                      child: _buildHeader(),
                    ),
                  )
                : new Container(),
            new ClipRect(
              child: new Align(
                heightFactor: _easeInAnimation.value,
                child: ConstrainedBox(
                  constraints: BoxConstraints(),
                  child: new Container(
                    height: 210.0,
                    child: new InkWell(
                      onTap: _handleTap,
                      child: child,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        new Positioned(
          top: 0.0,
          right: 0.0,
          child:new Container(
            padding: EdgeInsets.only(top: 5.0),
            color: Colors.white,
            child:  _buildTrailing(),
          ),
        )
      ],
    ));
  }

  Widget _buildHeader() {
    return new Row(
      children: <Widget>[
        new Padding(
            padding: EdgeInsets.only(right: 10.0, bottom: 2.5),
            child: new Stack(
              children: <Widget>[
                new Container(
                  padding: EdgeInsets.only(right: 3.0, top: 3.0),
                  child: new Container(
                    width: 30.0,
                    height: 30.0,
                    decoration: BoxDecoration(
                      boxShadow: [
                        new BoxShadow(
                          blurRadius: 1.0,
                          spreadRadius: 1.5,
                          color: Colors.grey[350],
                        )
                      ],
                      shape: BoxShape.circle,
                    ),
                    child: new CircleAvatar(
                      backgroundColor: Colors.black,
                      backgroundImage: NetworkImage(widget.item.image),
                    ),
                  ),
                ),
              ],
            )),
        new Text(widget.item.name),
        new Expanded(
          child: new Container(),
        ),
      ],
    );
  }

  Widget _buildTrailing() {
    return new InkWell(
      onTap: _isExpanded ? _handleTap : widget.callbackExpandTile,
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 4.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25.0),
                boxShadow: [
                  new BoxShadow(
                    color: Colors.grey[350],
                    blurRadius: 0.5,
                    spreadRadius: 1.0,
                  )
                ]),
            child: new Text(
              "\$" + widget.item.price,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 10.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          new Container(
            padding:
                EdgeInsets.only(left: 10.0, right: 10.0, bottom: 3.0, top: 3.0),
            decoration: BoxDecoration(
                boxShadow: [
                  new BoxShadow(
                      color: Colors.grey[300],
                      blurRadius: 1.5,
                      spreadRadius: 2.0)
                ],
                shape: BoxShape.circle,
                color:
                    widget.item.isModified ? Colors.blue[700] : Colors.white),
            child: new Icon(
              Icons.more_vert,
              size: 15.0,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChild() {
    return new Container(
      padding: EdgeInsets.only(top: 5.0, left: 5.0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildChildRowFirst(),
          _buildChildRowSecond(),
          new Padding(
            padding: EdgeInsets.only(top: 15.0, bottom: 10.0),
            child: new Text(
              "CARE",
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0),
            ),
          ),
          new Expanded(
            child: new Container(
              // color: Colors.red,
              child: _buildChildRowThird(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChildRowFirst() {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Stack(
          children: <Widget>[
            new GestureDetector(
              onTap: widget.callback,
              child: new Container(
                margin: EdgeInsets.only(right: 10.0, top: 2.5),
                width: 55.0,
                height: 55.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,

                  boxShadow: [
                    new BoxShadow(
                        color: Colors.grey[350],
                        blurRadius: 2.5,
                        spreadRadius: 3.0)
                  ],
                  //  border: Border.all(color: Colors.grey[350])
                ),
                child: new CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(widget.item.image),
                ),
              ),
            ),
            widget.item.itemCount <= 0
                ? new Container()
                : new Positioned(
                    right: 0.0,
                    top: 0.0,
                    child: new Container(
                      alignment: Alignment.center,
                      width: 20.0,
                      height: 20.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          new BoxShadow(
                              color: Colors.grey[350],
                              blurRadius: 1.5,
                              spreadRadius: 2.0)
                        ],
                        //    border: Border.all(color: Colors.grey[350])
                      ),
                      child: new Text(
                        widget.item.itemCount.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.blue[700]),
                      ),
                    ),
                  )
          ],
        ),
        new Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Padding(
                padding: EdgeInsets.only(bottom: 5.0, top: 5.0),
                child: new Text(
                  widget.item.name.toUpperCase(),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new Container(
                    padding: EdgeInsets.all(2.5),
                    child: Icon(
                      brandList
                          .where((x) => x.name == widget.item.brand)
                          .first
                          .icon
                          .icon,
                      size: 20.0,
                    ),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        // boxShadow: [
                        //   new BoxShadow(
                        //       color: Colors.grey[350],
                        //       blurRadius: 1.5,
                        //       spreadRadius: 2.0)
                        // ]
                        border: Border.all(color: Colors.grey[350])),
                  ),
                  new Text(
                    " " + widget.item.brand,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.5),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildChildRowSecond() {
    return Theme(
      data: ThemeData(accentColor: Colors.white),
      child: new SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(top: 10.0),
        child: new ConstrainedBox(
          constraints: BoxConstraints(
              minWidth: MediaQuery.of(context).size.width - 35.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new Container(
                margin: EdgeInsets.only(right: 2.5),
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 2.5),
                alignment: Alignment.center,
                decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    border: Border.all(
                      color: Colors.grey[350],
                    )),
                child: new Text(
                  widget.item.category.toUpperCase(),
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w400),
                ),
              ),
              widget.item.basket == null || widget.item.basket.isEmpty
                  ? new Container()
                  : new Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15.0, vertical: 2.5),
                      margin: EdgeInsets.symmetric(horizontal: 2.5),
                      alignment: Alignment.center,
                      decoration: new BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          border: Border.all(
                            color: Colors.grey[350],
                          )),
                      child: new Text(
                        widget.item.basket.toUpperCase(),
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 12.5,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
              new Container(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 2.5),
                margin: EdgeInsets.symmetric(horizontal: 2.5),
                alignment: Alignment.center,
                decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    border: Border.all(
                      color: Colors.grey[350],
                    )),
                child: new Text(
                  "BASKET",
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 12.5,
                      fontWeight: FontWeight.w400),
                ),
              ),
              new Container(
                margin: EdgeInsets.symmetric(horizontal: 2.5),
                height: 22.5,
                width: 22.5,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colorsList
                      .where((x) => x.colorName == widget.item.color)
                      .first
                      .color,
                ),
              ),
              new Container(
                margin: EdgeInsets.symmetric(horizontal: 2.5),
                height: 22.5,
                width: 22.5,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.pinkAccent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChildRowThird() {
    return new ListView(
        padding: EdgeInsets.only(bottom: 10.0),
        scrollDirection: Axis.horizontal,
        children: List.generate(widget.item.care.length, (int index) {
          var itemm = careList[widget.item.care[index]];
          return new Container(
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.only(
                left: index == 0 ? 0.0 : 5.0,
                right: index == widget.item.care.length ? 0.0 : 5.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(color: Colors.grey[350]),
            ),
            child: new Icon(
              itemm.icon.icon,
              size: 45.0,
            ),
          );
        }));
  }
}
