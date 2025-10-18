import 'package:flutter/material.dart';

class HorizontalStretchDetector extends StatefulWidget {
  final Widget child;
  final double maxDrag; // longueur max
  final VoidCallback onFullStretch; // action à déclencher à 100%
  final VoidCallback onStartStretch; // action à déclencher à +10%
  final VoidCallback onStopStretch; // action à déclencher à -10%

  const HorizontalStretchDetector({
    Key? key,
    required this.child,
    required this.onStartStretch,
    required this.onFullStretch,
    required this.onStopStretch,
    this.maxDrag = 200.0,
  }) : super(key: key);

  @override
  _HorizontalStretchDetectorState createState() =>
      _HorizontalStretchDetectorState();
}

class _HorizontalStretchDetectorState extends State<HorizontalStretchDetector> {
  double dragX = 0.0;
  bool beginDrag = false;

  @override
  Widget build(BuildContext context) {
    double progress = (dragX / widget.maxDrag).clamp(0.0, 1.0);

    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        setState(() {
          dragX += details.delta.dx;
          if (dragX < 0) dragX = 0;
          if (beginDrag && progress < 0.1) {
            beginDrag = false;
            widget.onStopStretch();
          } else if (!beginDrag && progress > 0.1) {
            beginDrag = true;
            widget.onStartStretch();
          }
        });
      },
      onHorizontalDragEnd: (_) {
        if (progress >= 1.0) {
          widget.onFullStretch();
          beginDrag = false;
        }
        setState(() {
          dragX = 0;
        });
      },
      child: widget.child,
    );
  }
}
