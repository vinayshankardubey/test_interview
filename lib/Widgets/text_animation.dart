import 'dart:async';
import 'package:flutter/material.dart';

class ShowUp extends StatefulWidget {
  final Widget child;
  final int delay;
  final AnimationController animController;
  final Animation<Offset> animOffset;

  ShowUp({required this.child, required this.delay, required this.animController, required this.animOffset});

  @override
  _ShowUpState createState() => _ShowUpState();
}

class _ShowUpState extends State<ShowUp> with TickerProviderStateMixin {






  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      child: SlideTransition(
        position: widget.animOffset,
        child: widget.child,
      ),
      opacity: widget.animController,
    );
  }
}