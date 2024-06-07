import 'dart:async';
import 'dart:math';

import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:streaming_ui/pages/base_page.dart';
import 'package:streaming_ui/pages/profile_page.dart';
import 'package:uicons/uicons.dart';

import '../constants.dart';

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
                    return StreamCards(
                      user: usersList[index],
                    );
                  },
                ),
              ).animate().slideY(
                    begin: 1,
                    duration: kDefaultAnimationDuration * 2,
                    curve: Curves.fastOutSlowIn,
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

class StreamCards extends StatefulWidget {
  const StreamCards({
    super.key,
    required this.user,
  });

  final User user;
  @override
  State<StreamCards> createState() => _StreamCardsState();
}

class _StreamCardsState extends State<StreamCards>
    with AutomaticKeepAliveClientMixin {
  late CachedVideoPlayerController _controller;

  String? thumbnail;

  // bool liked = false;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.initState();
    _controller = CachedVideoPlayerController.network(widget.user.videoUrl)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _controller.setLooping(true);
        _controller.setVolume(0);
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final _imageIndex = Random().nextInt(gamesList.length);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 300),
            reverseTransitionDuration: const Duration(milliseconds: 300),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            pageBuilder: (_, __, ___) {
              return ProfilePage(
                user: widget.user,
                controller: _controller,
              );
            },
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              width: double.infinity,
              height: 175,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    gamesList[_imageIndex],
                  ),
                ),
              ),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Live',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.black,
                      backgroundImage: NetworkImage(widget.user.imageUrl),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.user.name,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Text(
                          '428k viewers',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: Theme.of(context).hintColor,
                                  ),
                        ),
                      ],
                    )
                  ],
                ),
                Icon(
                  UIcons.regularRounded.menu_dots_vertical,
                  size: 16,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class AvatarRow extends StatefulWidget {
  const AvatarRow({
    super.key,
  });

  @override
  State<AvatarRow> createState() => _AvatarRowState();
}

class _AvatarRowState extends State<AvatarRow> with TickerProviderStateMixin {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _addItems();
  }

  void _addItems() {
    Future.delayed(Duration.zero, () {
      for (int i = 0; i < usersList.length; i++) {
        Future.delayed(Duration(milliseconds: i * 200), () {
          _listKey.currentState?.insertItem(i);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: AnimatedList(
        key: _listKey,
        initialItemCount: 0,
        clipBehavior: Clip.none,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index, animation) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.5),
                end: const Offset(0, 0),
              ).animate(
                CurvedAnimation(
                  parent: animation,
                  curve: Curves.ease,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    (index == 2 || index == 1)
                        ? Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.purpleAccent.withOpacity(0.5),
                                      Colors.deepOrange.withOpacity(0.5),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  border: Border.all(
                                    width: 1,
                                  ),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                  ),
                                  child: CircleAvatar(
                                    radius: 28,
                                    backgroundColor: Colors.black,
                                    backgroundImage:
                                        NetworkImage(usersList[index].imageUrl),
                                  ),
                                ),
                              ),
                              const Positioned(
                                right: -15,
                                top: 7,
                                child: _LivePill(),
                              )
                            ],
                          )
                        : Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: CircleAvatar(
                                  radius: 28,
                                  backgroundColor: Colors.black,
                                  backgroundImage:
                                      NetworkImage(usersList[index].imageUrl),
                                ),
                              ),
                              (index == 0)
                                  ? const Positioned(
                                      right: -5,
                                      bottom: 0,
                                      child: _AddIcon(),
                                    )
                                  : const SizedBox()
                            ],
                          ),
                    const SizedBox(height: 5),
                    Text(usersList[index].name.split(' ').last),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _AddIcon extends StatelessWidget {
  const _AddIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.red,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Icon(
        Icons.add,
        size: 16,
      ),
    );
  }
}

class _LivePill extends StatelessWidget {
  const _LivePill({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 6,
      ),
      decoration: BoxDecoration(
        color: Colors.red,
        border: Border.all(
          color: Theme.of(context).scaffoldBackgroundColor,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Text(
        'Live',
        style: TextStyle(
          fontSize: 12,
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
