import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:wash_x/viewModels/WardrobeModel.dart';

class CameraWidget extends StatefulWidget {
  final List<CameraDescription> cameras;
  final WardrobeModel model;
  CameraWidget(this.cameras, this.model);
  @override
  _CameraWidgetState createState() => new _CameraWidgetState();
}

class _CameraWidgetState extends State<CameraWidget> {
  CameraController controller;
  @override
  void initState() {
    super.initState();
    controller =
        new CameraController(widget.cameras[0], ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return new Container();
    }
    return Stack(
      children: <Widget>[
        new Container(
          color: Colors.white,
            padding: EdgeInsets.only(bottom: 150.0),
            child: new CameraPreview(controller)),
        // new Positioned(
        //   bottom: 0.0,
        //   child: new Container(
        //     height: 150.0,
        //     decoration: BoxDecoration(
        //         color: Colors.white,
        //         borderRadius: BorderRadius.only(
        //             topLeft: Radius.circular(10.0),
        //             topRight: Radius.circular(10.0))),
        //     width: MediaQuery.of(context).size.width,
        //     child: new Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceAround,
        //       children: <Widget>[
        //         new Container(
        //           width: 35.0,
        //         ),
        //         new Container(
        //           height: 70.0,
        //           width: 70.0,
        //           decoration: BoxDecoration(boxShadow: [
        //             new BoxShadow(
        //                 blurRadius: 1.5,
        //                 spreadRadius: 1.0,
        //                 offset: Offset(0.0, 2.0),
        //                 color: Colors.grey[350])
        //           ], color: Colors.white, shape: BoxShape.circle),
        //           child: new IconButton(
        //             icon: Icon(
        //               Icons.add_photo_alternate,
        //               size: 50.0,
        //               color: Colors.black,
        //             ),
        //             onPressed: () => widget.model
        //                 .onTakePictureButtonPressed(controller, mounted),
        //           ),
        //         ),
        //         new Container(
        //           height: 35.0,
        //           width: 35.0,
        //           decoration: BoxDecoration(boxShadow: [
        //             new BoxShadow(
        //                 blurRadius: 1.5,
        //                 spreadRadius: 1.0,
        //                 offset: Offset(0.0, 2.0),
        //                 color: Colors.grey[350])
        //           ], color: Colors.white, shape: BoxShape.circle),
        //           child: new IconButton(
        //             icon: Icon(
        //               Icons.add_photo_alternate,
        //               size: 20.0,
        //               color: Colors.transparent,
        //             ),
        //             onPressed: () => widget.model
        //                 .onTakePictureButtonPressed(controller, mounted),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // )
      ],
    );
  }
}
