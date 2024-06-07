import 'dart:async';
import 'dart:math';

import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:streaming_ui/pages/base_page.dart';
import 'package:streaming_ui/pages/profile_page.dart';
import 'package:streaming_ui/widgets/avatar_row.dart';
import 'package:streaming_ui/widgets/categories_list.dart';
import 'package:streaming_ui/widgets/stream_cards.dart';
import 'package:uicons/uicons.dart';

import '../constants.dart';
import '../widgets/shaking_icon.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              InkWell(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const BasePage(),
                  ),
                ),
                child: const HomeAppBar(),
              ),

              //AVATAR

              const AvatarRow(),

              //CATEGORIES
              const CategoriesList(),

              ///
              /// ListView
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(0, 16, 0, 100),
                  itemCount: usersList.length,
                  itemBuilder: (context, index) {
                    return CustomSlideYAnimation(
                      begin: 1,
                      curve: Curves.fastOutSlowIn,
                      animationDuration: kDefaultAnimationDuration * 2,
                      child: StreamCards(
                        user: usersList[index],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeAppBar extends StatefulWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar>
    with SingleTickerProviderStateMixin {
  late Animation<double> _fadeAnimation;
  late AnimationController _fadeCtrl;

  @override
  void initState() {
    _fadeCtrl = AnimationController(
      vsync: this,
      duration: kDefaultAnimationDuration * 2,
    );

    _fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(_fadeCtrl);

    _fadeCtrl.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
                text: 'Gaming.',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                children: [
                  TextSpan(
                    text: 'ly',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                ]),
          ),
          Row(
            children: [
              ShakingIcon(
                duration: kDefaultAnimationDuration * 10,
                icon: Icon(
                  UIcons.regularRounded.search,
                ),
              ),
              const SizedBox(width: 20),
              ShakingIcon(
                duration: kDefaultAnimationDuration * 10,
                icon: Icon(
                  UIcons.solidRounded.bell,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
