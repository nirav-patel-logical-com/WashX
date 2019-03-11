import 'package:flutter/material.dart';

class CustomWashNewTile extends StatefulWidget {
  CustomWashNewTile(
      {this.icon, this.item, this.priceLabel, this.isSelected, this.onPressed, this.onPressedDot});
  final Icon icon;
  final String item;
  final bool isSelected;
  final String priceLabel;
  final VoidCallback onPressed;
  final VoidCallback onPressedDot;

  @override
  _CustomWashNewTileState createState() =>
      _CustomWashNewTileState();
}

class _CustomWashNewTileState extends State<CustomWashNewTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 2.5),
         // height: 40.0,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 0,
                child: widget.icon,
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(widget.item),
                  ),
                ),
              ),
              Container(
                height: 25.0,
                child: OutlineButton(
                  child: Text(widget.priceLabel),
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0),
                    ),
                  ),onPressed: (){
                },
                ),
              ),
              Expanded(
                flex: 0,
                child: GestureDetector(
                    onTap: () {
                     // widget.isSelected = !widget.isSelected;
                      setState(() {});
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        height: 25.0,
                        width: 25.0,
                        child: /*CircleAvatar(
                          backgroundColor: widget.isSelected ? Colors.blue : Colors.grey,
                          child: Icon(
                            Icons.edit,
                            color: Colors.black,
                          ),
                        ),*/
                       InkWell(
                         child:  Material(
                           borderRadius: BorderRadius.all(Radius.circular(25.0)),
                           elevation: 1.0,
                           color: widget.isSelected ? Colors.blue : Colors.white,
                           child: Icon(
                             Icons.more_vert,
                             color: Colors.black,
                           ),
                         ),
                         onTap: widget.onPressedDot,
                       ),
                      ),
                    )),
              ),
              /*ActionChip(
                label: Text("WASH"),
                onPressed: widget.onPressed,
                backgroundColor: Colors.blue,
              )*/
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Container(
                  height: 25.0,
                  child: RaisedButton(
                    elevation: 1.0,
                    child: Text(
                      "WASH",
                      style: TextStyle(
                        color: Colors.blue
                      ),
                    ),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25.0))),
                    onPressed: widget.onPressed,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
