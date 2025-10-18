import 'package:flutter/material.dart';

class RadialStretchDetector extends StatefulWidget {
  final Widget child;
  final double maxDistance;
  final void Function(double progress, double direction)? onDragProgress;
  final VoidCallback? onFullStretch; // action à déclencher à 100%
  final VoidCallback? onReleased; // action à déclencher à 100%

  const RadialStretchDetector({
    Key? key,
    required this.child,
    this.maxDistance = 100.0,
    this.onDragProgress,
    this.onReleased,
    this.onFullStretch,
  }) : super(key: key);

  @override
  _RadialStretchDetectorState createState() => _RadialStretchDetectorState();
}

class _RadialStretchDetectorState extends State<RadialStretchDetector> {
  Offset dragPosition = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onPanUpdate: (details) {
        setState(() {
          dragPosition += details.delta;
        });

        // Distance radiale depuis le centre
        final double distance = dragPosition.distance;
        final double progress = (distance / widget.maxDistance).clamp(0.0, 1.0);

        widget.onDragProgress?.call(progress, dragPosition.direction);
      },
      onPanEnd: (_) {
        if (dragPosition.distance >= widget.maxDistance) {
          widget.onFullStretch?.call();
        } else
          widget.onReleased?.call();
        setState(() {
          dragPosition = Offset.zero; // Reset position
        });
      },
      child: widget.child,
    );
  }
}
