import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:streaming_ui/widgets/custom_nav_item.dart';
import 'package:streaming_ui/pages/home_page.dart';
import 'package:streaming_ui/constants.dart';
import 'package:uicons/uicons.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage>
    with SingleTickerProviderStateMixin {
  late Animation<Offset> _slide;
  late AnimationController _animationController;
  int _selectedIndex = 0;

  void _switchNavPage(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final pages = [
    const HomePage(),
    const Scaffold(),
    const Scaffold(),
    const Scaffold(),
    const Scaffold(),
  ];

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: kDefaultAnimationDuration);

    _slide = Tween(begin: const Offset(0, -1), end: const Offset(0, 0))
        .animate(_animationController);

    Future.delayed(kDefaultAnimationDuration * 2, () {
      _animationController.forward();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        body: pages[_selectedIndex],
        bottomNavigationBar: CustomSlideYAnimation(
          begin: 1,
          delayDuration: kDefaultAnimationDuration * 2,
          child: Container(
            clipBehavior: Clip.hardEdge,
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 35),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 45),
            decoration: BoxDecoration(
              color: const Color(0xff3d3c5c),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomNavItem(
                  icon: UIcons.regularRounded.home,
                  index: 0,
                  selectedIndex: _selectedIndex,
                  onTap: _switchNavPage,
                ),
                CustomNavItem(
                  icon: UIcons.regularRounded.gamepad,
                  index: 1,
                  selectedIndex: _selectedIndex,
                  onTap: _switchNavPage,
                ),
                const CenterNavButton(),
                CustomNavItem(
                  icon: UIcons.regularRounded.comment_alt,
                  index: 2,
                  selectedIndex: _selectedIndex,
                  onTap: _switchNavPage,
                ),
                CustomNavItem(
                  icon: UIcons.regularRounded.user,
                  index: 3,
                  selectedIndex: _selectedIndex,
                  onTap: _switchNavPage,
                ),
              ],
            ),
          ),
        ));
  }
}

class CustomSlideYAnimation extends StatefulWidget {
  const CustomSlideYAnimation({
    super.key,
    this.curve,
    required this.child,
    this.delayDuration,
    this.animationDuration,
    this.begin,
  });

  final Widget child;
  final Duration? delayDuration;
  final Duration? animationDuration;
  final Curve? curve;
  final double? begin;

  @override
  State<CustomSlideYAnimation> createState() => _CustomSlideYAnimationState();
}

class _CustomSlideYAnimationState extends State<CustomSlideYAnimation>
    with SingleTickerProviderStateMixin {
  late Animation<Offset> _slide;
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this,
        duration: widget.animationDuration ?? kDefaultAnimationDuration);

    _slide =
        Tween(begin: Offset(0, widget.begin ?? -1), end: const Offset(0, 0))
            .animate(
      widget.curve == null
          ? _animationController
          : CurvedAnimation(
              parent: _animationController,
              curve: widget.curve!,
            ),
    );

    Future.delayed(widget.delayDuration ?? Duration.zero, () {
      _animationController.forward();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(position: _slide, child: widget.child);
  }
}

class CenterNavButton extends StatefulWidget {
  const CenterNavButton({
    super.key,
  });

  @override
  State<CenterNavButton> createState() => _CenterNavButtonState();
}

class _CenterNavButtonState extends State<CenterNavButton>
    with SingleTickerProviderStateMixin {
  late Animation<double> _scaleTransition;

  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _scaleTransition = Tween(
      begin: 0.1,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const ElasticOutCurve(1),
      ),
    );

    Future.delayed(kDefaultAnimationDuration * 3, () {
      _animationController.forward();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleTransition,
      child: CircleAvatar(
        radius: 25,
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          UIcons.solidRounded.play,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }
}

class NavIcon extends StatelessWidget {
  const NavIcon({
    super.key,
    this.icon,
  });
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon ?? UIcons.solidRounded.home),
        const SizedBox(height: 5),
        Icon(
          Icons.circle,
          size: 5,
          color: icon == null ? null : Colors.transparent,
        ),
      ],
    );
  }
}
