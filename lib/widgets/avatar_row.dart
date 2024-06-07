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
