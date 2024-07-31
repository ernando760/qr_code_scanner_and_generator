import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedFlipIconButtonWidget extends StatefulWidget {
  const AnimatedFlipIconButtonWidget(
      {super.key, required this.onPressed, required this.child});
  final VoidCallback? onPressed;
  final Widget child;
  @override
  State<AnimatedFlipIconButtonWidget> createState() =>
      _AnimatedFlipIconButtonWidgetState();
}

class _AnimatedFlipIconButtonWidgetState
    extends State<AnimatedFlipIconButtonWidget> {
  double _rotationAngle = 0.0;

  void _startRotation() {
    setState(() {
      _rotationAngle += (2 * pi);
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: widget.onPressed != null
            ? () {
                widget.onPressed!.call();
                _startRotation();
              }
            : null,
        icon: AnimatedRotation(
          turns: _rotationAngle / (2 * pi),
          duration: const Duration(milliseconds: 600),
          child: widget.child,
        ));
  }
}
