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

class CategoriesList extends StatefulWidget {
  const CategoriesList({
    super.key,
  });

  static const List<String> emojiList = [
    '🔥 Popular',
    '🏅 Top Games',
    '🧩 Questions'
  ];

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList>
    with TickerProviderStateMixin {
  late Animation<double> fadeTransition;
  late Animation<Offset> slideTransition;
  late AnimationController categoriesAnimationCtrl;

  @override
  void initState() {
    categoriesAnimationCtrl = AnimationController(
      vsync: this,
      duration: kDefaultAnimationDuration * 3,
    );

    fadeTransition = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: categoriesAnimationCtrl,
        curve: const Interval(
          0,
          0.4,
          curve: Curves.easeIn,
        ),
      ),
    );
    slideTransition =
        Tween(begin: const Offset(3, 0), end: const Offset(0, 0)).animate(
      CurvedAnimation(
        parent: categoriesAnimationCtrl,
        curve: const Interval(
          0,
          1,
          curve: ElasticInOutCurve(2),
        ),
      ),
    );

    categoriesAnimationCtrl.forward();
    super.initState();
  }

  @override
  void dispose() {
    categoriesAnimationCtrl.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: FadeTransition(
            opacity: fadeTransition,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Categories',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.w700),
                ),
                Text(
                  'See all',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).hintColor),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 35,
          child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: CategoriesList.emojiList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return SlideTransition(
                  position: slideTransition,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 7),
                      decoration: BoxDecoration(
                        color: const Color(0xff676699).withOpacity(0.7),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        CategoriesList.emojiList[index],
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 15,
                            ),
                      ),
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
