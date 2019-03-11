import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wash_x/custom/dragable_scrallview.dart';
import 'package:wash_x/enum.dart';
import 'package:wash_x/models/contactModel.dart';

class ContactList extends StatefulWidget {
  final Function callback;

  ContactList(this.callback);

  @override
  _ContactListState createState() => _ContactListState();
}

class _ContactListState extends State<ContactList>
    with TickerProviderStateMixin {
  ScrollController _semicircleController = ScrollController();

  List<ContactModels> _items = <ContactModels>[
    ContactModels(
      contactImage:
          'https://images.pexels.com/photos/91227/pexels-photo-91227.jpeg?cs=srgb&dl=black-and-white-fun-happy-91227.jpg&fm=jpg',
      contactName: 'Ani Cam',
      isInvited: true,
      isOpen: false,
    ),
    ContactModels(
      contactImage:
          'https://images.pexels.com/photos/91227/pexels-photo-91227.jpeg?cs=srgb&dl=black-and-white-fun-happy-91227.jpg&fm=jpg',
      contactName: 'Dart Mrtine',
      isInvited: false,
      isOpen: false,
    ),
    ContactModels(
      contactImage:
          'https://images.pexels.com/photos/91227/pexels-photo-91227.jpeg?cs=srgb&dl=black-and-white-fun-happy-91227.jpg&fm=jpg',
      contactName: 'Dac',
      isInvited: true,
      isOpen: false,
    ),
    ContactModels(
      contactImage:
          'https://images.pexels.com/photos/91227/pexels-photo-91227.jpeg?cs=srgb&dl=black-and-white-fun-happy-91227.jpg&fm=jpg',
      contactName: 'Cat Rose',
      isInvited: false,
      isOpen: false,
    ),
    ContactModels(
      contactImage:
          'https://images.pexels.com/photos/91227/pexels-photo-91227.jpeg?cs=srgb&dl=black-and-white-fun-happy-91227.jpg&fm=jpg',
      contactName: 'Edy',
      isInvited: false,
      isOpen: false,
    ),
    ContactModels(
      contactImage:
          'https://images.pexels.com/photos/91227/pexels-photo-91227.jpeg?cs=srgb&dl=black-and-white-fun-happy-91227.jpg&fm=jpg',
      contactName: 'Funny',
      isInvited: false,
      isOpen: false,
    ),
    ContactModels(
      contactImage:
          'https://images.pexels.com/photos/91227/pexels-photo-91227.jpeg?cs=srgb&dl=black-and-white-fun-happy-91227.jpg&fm=jpg',
      contactName: 'Gloft',
      isInvited: false,
      isOpen: false,
    ),
    ContactModels(
      contactImage:
          'https://images.pexels.com/photos/91227/pexels-photo-91227.jpeg?cs=srgb&dl=black-and-white-fun-happy-91227.jpg&fm=jpg',
      contactName: 'Heros',
      isInvited: true,
      isOpen: false,
    ),
    ContactModels(
      contactImage:
          'https://images.pexels.com/photos/91227/pexels-photo-91227.jpeg?cs=srgb&dl=black-and-white-fun-happy-91227.jpg&fm=jpg',
      contactName: 'Infit',
      isInvited: false,
      isOpen: false,
    ),
    ContactModels(
      contactImage:
          'https://images.pexels.com/photos/91227/pexels-photo-91227.jpeg?cs=srgb&dl=black-and-white-fun-happy-91227.jpg&fm=jpg',
      contactName: 'Joker',
      isInvited: false,
      isOpen: false,
    ),
    ContactModels(
      contactImage:
          'https://images.pexels.com/photos/91227/pexels-photo-91227.jpeg?cs=srgb&dl=black-and-white-fun-happy-91227.jpg&fm=jpg',
      contactName: 'Koted',
      isInvited: false,
      isOpen: false,
    ),
    ContactModels(
      contactImage:
          'https://images.pexels.com/photos/91227/pexels-photo-91227.jpeg?cs=srgb&dl=black-and-white-fun-happy-91227.jpg&fm=jpg',
      contactName: 'Lencion',
      isInvited: false,
      isOpen: false,
    ),
    ContactModels(
      contactImage:
          'https://images.pexels.com/photos/91227/pexels-photo-91227.jpeg?cs=srgb&dl=black-and-white-fun-happy-91227.jpg&fm=jpg',
      contactName: 'Mendy Marcus',
      isInvited: false,
      isOpen: false,
    ),
    ContactModels(
      contactImage:
          'https://images.pexels.com/photos/91227/pexels-photo-91227.jpeg?cs=srgb&dl=black-and-white-fun-happy-91227.jpg&fm=jpg',
      contactName: 'Nokey',
      isInvited: false,
      isOpen: false,
    ),
    ContactModels(
      contactImage:
          'https://images.pexels.com/photos/91227/pexels-photo-91227.jpeg?cs=srgb&dl=black-and-white-fun-happy-91227.jpg&fm=jpg',
      contactName: 'Optimus',
      isInvited: false,
      isOpen: false,
    ),
    ContactModels(
      contactImage:
          'https://images.pexels.com/photos/91227/pexels-photo-91227.jpeg?cs=srgb&dl=black-and-white-fun-happy-91227.jpg&fm=jpg',
      contactName: 'Perow',
      isInvited: true,
      isOpen: false,
    ),
    ContactModels(
      contactImage:
          'https://images.pexels.com/photos/91227/pexels-photo-91227.jpeg?cs=srgb&dl=black-and-white-fun-happy-91227.jpg&fm=jpg',
      contactName: 'Quibic',
      isInvited: false,
      isOpen: false,
    ),
    ContactModels(
      contactImage:
          'https://images.pexels.com/photos/91227/pexels-photo-91227.jpeg?cs=srgb&dl=black-and-white-fun-happy-91227.jpg&fm=jpg',
      contactName: 'Rosted',
      isInvited: false,
      isOpen: false,
    ),
    ContactModels(
      contactImage:
          'https://images.pexels.com/photos/91227/pexels-photo-91227.jpeg?cs=srgb&dl=black-and-white-fun-happy-91227.jpg&fm=jpg',
      contactName: 'Sanul',
      isInvited: false,
      isOpen: false,
    ),
    ContactModels(
      contactImage:
          'https://images.pexels.com/photos/91227/pexels-photo-91227.jpeg?cs=srgb&dl=black-and-white-fun-happy-91227.jpg&fm=jpg',
      contactName: 'Senkl',
      isInvited: true,
      isOpen: false,
    ),
    ContactModels(
      contactImage:
          'https://images.pexels.com/photos/91227/pexels-photo-91227.jpeg?cs=srgb&dl=black-and-white-fun-happy-91227.jpg&fm=jpg',
      contactName: 'Somer',
      isInvited: false,
      isOpen: false,
    ),
    ContactModels(
      contactImage:
          'https://images.pexels.com/photos/91227/pexels-photo-91227.jpeg?cs=srgb&dl=black-and-white-fun-happy-91227.jpg&fm=jpg',
      contactName: 'Sarom',
      isInvited: false,
      isOpen: false,
    ),
    ContactModels(
      contactImage:
          'https://images.pexels.com/photos/91227/pexels-photo-91227.jpeg?cs=srgb&dl=black-and-white-fun-happy-91227.jpg&fm=jpg',
      contactName: 'Sinul',
      isInvited: false,
      isOpen: false,
    ),
    ContactModels(
      contactImage:
          'https://images.pexels.com/photos/91227/pexels-photo-91227.jpeg?cs=srgb&dl=black-and-white-fun-happy-91227.jpg&fm=jpg',
      contactName: 'Tocsine',
      isInvited: false,
      isOpen: false,
    ),
    ContactModels(
      contactImage:
          'https://images.pexels.com/photos/91227/pexels-photo-91227.jpeg?cs=srgb&dl=black-and-white-fun-happy-91227.jpg&fm=jpg',
      contactName: 'Ucon',
      isInvited: false,
      isOpen: false,
    ),
    ContactModels(
      contactImage:
          'https://images.pexels.com/photos/91227/pexels-photo-91227.jpeg?cs=srgb&dl=black-and-white-fun-happy-91227.jpg&fm=jpg',
      contactName: 'Vox',
      isInvited: true,
      isOpen: false,
    ),
  ];
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    animation = Tween(begin: 5.0, end: 16.0).animate(controller)
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      });
    // controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Column(
        children: <Widget>[
          Expanded(
              child: DraggableScrollbar.arrows(
            alwaysVisibleScrollThumb: true,
            labelTextBuilder: (double offset) => Text(
                  _items[offset ~/ 50 < _items.length
                          ? offset ~/ 50
                          : _items.length - 1]
                      .contactName
                      .substring(0, 1),
                  style: TextStyle(color: Colors.white),
                ),
            controller: _semicircleController,
            backgroundColor: Colors.blueAccent,
            child: ListView.builder(
              controller: _semicircleController,
              itemCount: _items.length,
              itemBuilder: (context, index) {
                ContactModels mContact = _items[index];

                return AnimatedSize(
                  vsync: this,
                  // height: mContact.isOpen ? 120.0 : 60.0,
                  duration: Duration(milliseconds: 650),
                  child: Card(
                    elevation: mContact.isOpen ? 3.0 : 0.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    margin: EdgeInsets.all(5.0),
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(5.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new CircleAvatar(
                                backgroundImage:
                                    new NetworkImage(mContact.contactImage),
                                radius: 15.0,
                              ),
                              Expanded(
                                  child: Container(
                                child: Text(
                                  mContact.contactName,
                                  style: TextStyle(
                                      color: Colors.black87, fontSize: 12.0),
                                ),
                                margin: EdgeInsets.only(left: 5.0),
                              )),
                              mContact.isInvited
                                  ? Container(
                                      margin: EdgeInsets.only(right: 8.0),
                                      child: Text(
                                        "ALREDY A MEMBER",
                                        style: TextStyle(
                                            color: Colors.black38,
                                            fontSize: 12.0),
                                      ),
                                    )
                                  : Container(
                                      margin: EdgeInsets.only(right: 8.0),
                                      height: 25.0,
                                      width: 80.0,
                                      alignment: Alignment.centerRight,
                                      child: RaisedButton(
                                        onPressed: () {
                                          if (mContact.isOpen) {
                                            mContact.isOpen = false;
                                            controller.reverse();
                                          } else {
                                            mContact.isOpen = true;
                                            controller.forward();
                                          }
                                          setState(() {});
                                        },
                                        child: new Text(
                                          mContact.isOpen ? "CLOSE" : "INVITE",
                                          style: TextStyle(
                                              color: Colors.blueAccent,
                                              fontSize: 12.0),
                                        ),
                                        color: Colors.white,
                                        shape: StadiumBorder(
                                            // side: BorderSide(color: Colors.grey[300], width: 2.0)
                                            ),
                                      ),
                                    )
                            ],
                          ),
                          mContact.isOpen
                              ? Container(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              child: Icon(
                                                Icons.message,
                                                size: 16.0,
                                                color: Colors.blue,
                                              ),
                                              padding: EdgeInsets.all(5.0),
                                              margin: EdgeInsets.only(bottom: 4.0),
                                              decoration: new BoxDecoration(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        25.0),
                                                border: new Border.all(
                                                  width: 1.0,
                                                  color: Colors.black12,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              "MESSANGER",
                                              style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.black87,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 10.0),
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              child: Icon(
                                                Icons.message,
                                                size: 16.0,
                                                color: Colors.blue,
                                              ),
                                              padding: EdgeInsets.all(5.0),
                                              margin: EdgeInsets.only(bottom: 4.0),
                                              decoration: new BoxDecoration(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        25.0),
                                                border: new Border.all(
                                                  width: 1.0,
                                                  color: Colors.black12,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              "WHATSAPP",
                                              style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.black87,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 20.0),
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              child: Icon(
                                                Icons.message,
                                                size: 16.0,
                                                color: Colors.blue,
                                              ),
                                              padding: EdgeInsets.all(5.0),
                                              margin: EdgeInsets.only(bottom: 4.0),
                                              decoration: new BoxDecoration(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        25.0),
                                                border: new Border.all(
                                                  width: 1.0,
                                                  color: Colors.black12,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              "EMAIL",
                                              style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.black87,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 20.0),
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              child: Icon(
                                                Icons.message,
                                                size: 16.0,
                                                color: Colors.blue,
                                              ),
                                              padding: EdgeInsets.all(5.0),
                                              margin: EdgeInsets.only(bottom: 4.0),
                                              decoration: new BoxDecoration(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        25.0),
                                                border: new Border.all(
                                                  width: 1.0,
                                                  color: Colors.black12,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              "TEXT",
                                              style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.black87,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 20.0),
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              child: Icon(
                                                Icons.message,
                                                size: 16.0,
                                                color: Colors.blue,
                                              ),
                                              padding: EdgeInsets.all(5.0),
                                              margin: EdgeInsets.only(bottom: 4.0),
                                              decoration: new BoxDecoration(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        25.0),
                                                border: new Border.all(
                                                  width: 1.0,
                                                  color: Colors.black12,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              "EMAIL",
                                              style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.black87,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  margin: EdgeInsets.all(5.0),
                                )
                              : Container(
                                  height: 0.0,
                                  width: 0.0,
                                )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              InkResponse(
                onTap: () {
                  this.widget.callback(PageType.GIFTWASH);
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
                          'CONTACT',
                          style: new TextStyle(
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent),
                        )),
                  ),
                ),
              ),
              InkResponse(
                onTap: () {},
                child: Icon(Icons.more_vert),
              )
            ],
          ),
        ],
      ),
    );
 
  }
}
