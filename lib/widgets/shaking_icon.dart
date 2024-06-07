import 'dart:async';
import 'dart:math';

import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:streaming_ui/pages/base_page.dart';
import 'package:streaming_ui/pages/profile_page.dart';
import 'package:uicons/uicons.dart';

import '../constants.dart';

class ShakingIcon extends StatefulWidget {
  final Icon icon;
  final Duration duration;

  const ShakingIcon({
    super.key,
    required this.icon,
    required this.duration,
  });

  @override
  ShakingIconState createState() => ShakingIconState();
}

class ShakingIconState extends State<ShakingIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _animation = Tween<double>(begin: -1, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
      ),
    );

    Future.delayed(const Duration(milliseconds: 500), () {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        return Transform.rotate(
          angle: _animation.value,
          child: widget.icon,
        );
      },
    );
  }
}
