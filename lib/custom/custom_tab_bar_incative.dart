import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class CustomTabInactive extends Decoration {
  CustomTabInactive({this.tabCount, this.width});

  final int tabCount;
  final double width;
  static const MARGIN = 4.0;
  static const HEIGTH = 5.0;

  @override
  BoxPainter createBoxPainter([VoidCallback onChanged]) {
    return new _CustomPainter(tabCount, this, onChanged, width);
  }
}

class _CustomPainter extends BoxPainter {
  _CustomPainter(this.tabCount, this.decoration, VoidCallback onChanged, this.wide)
      : assert(decoration != null),
        super(onChanged);

  final CustomTabInactive decoration;
  final int tabCount;
  final double wide;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration != null);
    assert(configuration.size != null);

    //offset is the position from where the decoration should be drawn.
    //configuration.size tells us about the height and width of the tab.
    Rect rect;
    final Paint paint = Paint();
      double width = (wide/tabCount)-CustomTabInactive.MARGIN*2;//configuration.size.width-CustomTabIndicator.MARGIN*2;
      double top = configuration.size.height+CustomTabInactive.HEIGTH;
      paint.color = Colors.grey[350];
    paint.style = PaintingStyle.fill;
    for(int i = 0;i<tabCount;i++){
      rect = new Rect.fromLTWH(offset.dx+CustomTabInactive.MARGIN+(wide/tabCount)*i, offset.dy+43.0, width, CustomTabInactive.HEIGTH);
      canvas.drawRRect(RRect.fromRectAndRadius(rect, Radius.circular(5.0)), paint);
    }
  }
}