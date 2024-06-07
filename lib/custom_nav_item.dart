import 'package:flutter/material.dart';
import 'package:streaming_ui/users_list.dart';

class CustomNavItem extends StatefulWidget {
  const CustomNavItem({
    super.key,
    required this.index,
    required this.onTap,
    required this.selectedIndex,
    required this.icon,
  });

  final int index;
  final int selectedIndex;
  final ValueChanged<int> onTap;
  final IconData icon;

  @override
  State<CustomNavItem> createState() => _CustomNavItemState();
}

class _CustomNavItemState extends State<CustomNavItem>
    with SingleTickerProviderStateMixin {
  late Animation<Offset> _slideAnimation;

  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1200 * (widget.index + 1)),
    );
    _slideAnimation = Tween(
      begin: const Offset(0, 2),
      end: const Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const ElasticOutCurve(1),
      ),
    );

    Future.delayed(kDefaultAnimationDuration * 4, () {
      _animationController.forward();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onTap.call(widget.index);
      },
      child: SlideTransition(
        position: _slideAnimation,
        child: Container(
          padding: const EdgeInsets.only(top: 8.0, bottom: 2.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.icon,
                size: 20,
                color: widget.index == widget.selectedIndex
                    ? Colors.white
                    : Colors.grey,
              ),
              const SizedBox(height: 5),
              Icon(
                Icons.circle,
                size: 5,
                color: (widget.index == widget.selectedIndex)
                    ? null
                    : Colors.transparent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
