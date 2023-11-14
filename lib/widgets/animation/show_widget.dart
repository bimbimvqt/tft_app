import 'dart:async';

import 'package:flutter/material.dart';

class ShowWidget extends StatefulWidget {
  final Widget child;
  final int? delay;
  final bool hasSlideTransition;
  final bool hasFadeTransition;
  final Offset transitionOffset;
  final Offset endTransitionOffset;
  final Curve animationCurve;
  final int durationMilis;

  final AxisDirection direction;

  const ShowWidget(
      {required this.child,
      this.delay,
      this.hasSlideTransition = true,
      this.durationMilis = 400,
      this.hasFadeTransition = true,
      this.transitionOffset = const Offset(0, 0.25),
      this.endTransitionOffset = Offset.zero,
      this.direction = AxisDirection.up,
      this.animationCurve = Curves.linearToEaseOut});

  @override
  _ShowWidgetState createState() => _ShowWidgetState();
}

class _ShowWidgetState extends State<ShowWidget> with TickerProviderStateMixin {
  late AnimationController? _animController;
  late Animation<Offset> _animOffset;

  @override
  void initState() {
    super.initState();

    _animController = AnimationController(vsync: this, duration: Duration(milliseconds: widget.durationMilis));

    _animOffset = _getAnimOffset();

    if (widget.delay == null) {
      _animController!.forward();
    } else {
      Timer(Duration(milliseconds: widget.delay!), () {
        _animController?.forward();
      });
    }
  }

  Animation<Offset> _getAnimOffset() {
    final curve = CurvedAnimation(curve: widget.animationCurve, parent: _animController!);
    late Animation<Offset> animOffset;

    switch (widget.direction) {
      case AxisDirection.up:
        animOffset = Tween<Offset>(begin: widget.transitionOffset, end: widget.endTransitionOffset).animate(curve);
        break;
      case AxisDirection.down:
        animOffset = Tween<Offset>(begin: const Offset(0.0, -0.25), end: Offset.zero).animate(curve);
        break;
      case AxisDirection.left:
        animOffset = Tween<Offset>(begin: const Offset(0.25, 0.0), end: Offset.zero).animate(curve);
        break;
      case AxisDirection.right:
        animOffset = Tween<Offset>(begin: const Offset(-0.25, 0.0), end: Offset.zero).animate(curve);
        break;
      default:
        Tween<Offset>(begin: const Offset(0.0, 0.25), end: Offset.zero).animate(curve);
    }

    return animOffset;
  }

  @override
  void dispose() {
    _animController?.dispose();
    _animController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.hasSlideTransition) {
      return FadeTransition(
        opacity: _animController!,
        child: widget.child,
      );
    }

    if (!widget.hasFadeTransition) {
      return SlideTransition(
        position: _animOffset,
        child: widget.child,
      );
    }
    return FadeTransition(
      opacity: _animController!,
      child: SlideTransition(
        position: _animOffset,
        child: widget.child,
      ),
    );
  }
}
