import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:wash_x/helpcentre/articles_list.dart';

class StaggerAnimation extends StatelessWidget {
  StaggerAnimation(
      {Key key, this.buttonController, this.gotoRoute})
      : buttonZoomOutAnimation = new Tween(
          begin: 0.0,
          end: 850.0,
        ).animate(
          new CurvedAnimation(parent: buttonController, curve: Curves.easeOut),
        ),
        buttonBottomtoCenterAnimation = new AlignmentTween(
          begin: Alignment.bottomCenter,
          end: Alignment.center,
        ).animate(
          new CurvedAnimation(
            parent: buttonController,
            curve: new Interval(
              0.50,
              1.0,
              curve: Curves.easeOut,
            ),
          ),
        ),
        super(key: key);

  final Animation<double> buttonController;
  final Animation buttonZoomOutAnimation;
  final Animation<Alignment> buttonBottomtoCenterAnimation;


  var gotoRoute;

  Widget _buildAnimation(BuildContext context, Widget child) {
    timeDilation = 0.4;

    return (new Padding(
        padding: buttonZoomOutAnimation.value < 400
            ? new EdgeInsets.all(35.0)
            : new EdgeInsets.all(0.0),
        child: new Container(
            alignment: buttonBottomtoCenterAnimation.value,
            child: new InkWell(
              child: new Container(
                width: buttonZoomOutAnimation.value,
                height: buttonZoomOutAnimation.value,
                alignment: buttonBottomtoCenterAnimation.value,
                /* decoration: new BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    border: Border.all(
                      color: Colors.grey[350],
                    ),)*/
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(
                      color: Colors.grey[350],
                    )),
                /* shape: buttonZoomOutAnimation.value < 400
                        ? BoxShape.circle
                        : BoxShape.rectangle),*/
                /*   decoration: BoxDecoration(
                  color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: Colors.grey[350],
                    )),*/
              ),
            ))));
  }

  @override
  Widget build(BuildContext context) {
    buttonController.addListener(() {
      // if (controller.isCompleted) Navigator.pushNamed(context, "/login");    //options
      // if (controller.isCompleted) Navigator.of(context).pop();       //options
      if (buttonController.isCompleted) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ArticlesList()),
        );
      }
    });
    return new AnimatedBuilder(
      builder: _buildAnimation,
      animation: buttonController,
    );
  }
}
