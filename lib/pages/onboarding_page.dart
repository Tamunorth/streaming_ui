import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:streaming_ui/pages/base_page.dart';
import 'package:streaming_ui/pages/home_page.dart';
import 'package:streaming_ui/constants.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage>
    with TickerProviderStateMixin {
  late Animation<Offset> _positionAnimation;
  late Animation<double> _fadeAnimation;
  late AnimationController animationController;
  late AnimationController fadeAnimationCtrl;

  ValueNotifier<bool> buttonVisible = ValueNotifier(true);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    animationController = AnimationController(
      vsync: this,
      reverseDuration: const Duration(milliseconds: 500),
      duration: const Duration(
        seconds: 2,
      ),
    );
    fadeAnimationCtrl = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 500,
      ),
    );
    _positionAnimation =
        Tween<Offset>(begin: const Offset(0, 1), end: const Offset(0, 0))
            .animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(
          0,
          0.5,
          curve: Curves.bounceIn,
        ),
      ),
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: fadeAnimationCtrl,
        curve: Curves.easeIn,
      ),
    );

    animationController.forward();
    fadeAnimationCtrl.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    fadeAnimationCtrl.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Transform.translate(
            offset: const Offset(0, -150),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedRotatedCards(
                  animationController: animationController,
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          FadeTransition(
                            opacity: _fadeAnimation,
                            child: Text(
                              'Gaming.',
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium
                                  ?.copyWith(
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w800,
                                  ),
                            ),
                          ),
                          AnimatedBuilder(
                            animation: _fadeAnimation,
                            builder: (context, child) {
                              return AnimatedOpacity(
                                opacity: _fadeAnimation.value > 0.5 ? 1.0 : 0.0,
                                duration: const Duration(milliseconds: 500),
                                child: Text(
                                  'ly',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium
                                      ?.copyWith(
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w800,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 17),
                      AnimatedBuilder(
                        animation: _fadeAnimation,
                        builder: (context, child) {
                          return AnimatedOpacity(
                            opacity: _fadeAnimation.value == 1.0 ? 1.0 : 0.0,
                            duration: const Duration(milliseconds: 500),
                            child: Text(
                              "Stream, watch other gamers\'s streams and play games in one app!",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    color: Theme.of(context).hintColor,
                                  ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ValueListenableBuilder(
              valueListenable: buttonVisible,
              builder: (context, buttonVisibleValue, child) {
                return AnimatedOpacity(
                  opacity: buttonVisibleValue ? 1 : 0,
                  duration: const Duration(milliseconds: 500),
                  child: StartButton(
                    positionAnimation: _positionAnimation,
                    onTap: () async {
                      buttonVisible.value = false;

                      // Navigator.of(context).push(
                      //   PageRouteBuilder(
                      //     transitionDuration: const Duration(milliseconds: 1000),
                      //     reverseTransitionDuration: const Duration(milliseconds: 500),
                      //     transitionsBuilder:
                      //         (context, animation, secondaryAnimation, child) {
                      //       return FadeTransition(
                      //         opacity: animation,
                      //         child: child,
                      //       );
                      //     },
                      //     pageBuilder: (_, __, ___) {
                      //       return BasePage();
                      //     },
                      //   ),
                      // );
                      Future.wait([
                        animationController.reverse(),
                        fadeAnimationCtrl.reverse(),
                      ]).then(
                        (value) => Navigator.of(context).push(
                          PageRouteBuilder(
                            transitionDuration:
                                const Duration(milliseconds: 500),
                            reverseTransitionDuration:
                                const Duration(milliseconds: 500),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                            pageBuilder: (_, __, ___) {
                              return BasePage();
                            },
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
        ],
      ),
    );
  }
}

class StartButton extends StatefulWidget {
  const StartButton({
    super.key,
    required Animation<Offset> positionAnimation,
    this.onTap,
  }) : _positionAnimation = positionAnimation;

  final Animation<Offset> _positionAnimation;
  final VoidCallback? onTap;

  @override
  State<StartButton> createState() => _StartButtonState();
}

class _StartButtonState extends State<StartButton>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _widthAnimationCtrl;
  late Animation<double> _widthAnimation;
  late Animation<Offset> _positionAnimation;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _widthAnimationCtrl = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _positionAnimation =
        Tween<Offset>(begin: const Offset(0, 8), end: const Offset(0, 0))
            .animate(
      CurvedAnimation(
        parent: _controller,
        curve: const ElasticOutCurve(2.5),
      ),
    );

    _widthAnimation = Tween<double>(begin: 55, end: 500).animate(
      CurvedAnimation(
        parent: _widthAnimationCtrl,
        curve: Curves.easeOut,
      ),
    );

    Future.delayed(const Duration(milliseconds: 400), () {
      _controller.forward().then((value) {
        Future.delayed(const Duration(milliseconds: 300), () {
          _widthAnimationCtrl.forward();
        });
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _widthAnimationCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _positionAnimation,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 65),
          child: AnimatedBuilder(
            animation: _widthAnimation,
            builder: (context, child) {
              return SizedBox(
                width: _widthAnimation.value,
                height: 55,
                child: FilledButton(
                  onPressed: widget.onTap,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: _widthAnimation.value > 200 ? 1 : 0,
                    child: const Text(
                      'Start',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class AnimatedRotatedCards extends StatefulWidget {
  const AnimatedRotatedCards({
    super.key,
    required this.animationController,
  });

  final AnimationController animationController;
  @override
  State<AnimatedRotatedCards> createState() => _AnimatedRotatedCardsState();
}

class _AnimatedRotatedCardsState extends State<AnimatedRotatedCards>
    with TickerProviderStateMixin {
  late Animation<Offset> _positionAnimation;
  late Animation<Offset> _altPositionAnimation;
  late ScrollController _listCtrl;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    _listCtrl = ScrollController();

    _positionAnimation = positionTransition(1).animate(
      CurvedAnimation(
        parent: widget.animationController,
        curve: Curves.easeIn,
        reverseCurve: Curves.easeOut,
      ),
    );

    _altPositionAnimation = positionTransition(-1).animate(
      CurvedAnimation(
        parent: widget.animationController,
        curve: Curves.easeIn,
        reverseCurve: Curves.easeOut,
      ),
    );

    Future.delayed(Duration.zero, () {
      _listCtrl.animateTo(
        200,
        duration: const Duration(seconds: 3),
        curve: Curves.decelerate,
      );
    });
  }

  Tween<Offset> positionTransition(double xOffset) =>
      Tween<Offset>(begin: Offset(xOffset, 0), end: const Offset(0, 0));

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        3,
        (index) {
          final listGames = gamesList.sublist((index * 8), ((index + 1) * 8));

          return Transform.rotate(
            angle: pi * 0.05,
            child: SlideTransition(
              position:
                  (index == 1) ? _altPositionAnimation : _positionAnimation,
              child: SizedBox(
                height: 235,
                //
                child: SingleChildScrollView(
                  controller: _listCtrl,
                  reverse: (index == 1) ? true : false,
                  scrollDirection: Axis.horizontal,
                  clipBehavior: Clip.none,
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    children: List.generate(
                      listGames.length,
                      (index) {
                        return GameCard(item: listGames[index]);
                      },
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class GameCard extends StatefulWidget {
  const GameCard({
    super.key,
    required this.item,
  });

  final String item;

  @override
  State<GameCard> createState() => _GameCardState();
}

class _GameCardState extends State<GameCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          widget.item,
          fit: BoxFit.cover,
          width: 135,
          height: 275,
        ),
      ),
    );
  }
}
