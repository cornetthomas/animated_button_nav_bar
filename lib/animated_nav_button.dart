import 'package:flutter/material.dart';

class AnimatedNavButton extends StatefulWidget {
  AnimatedNavButtonState createState() => AnimatedNavButtonState();

  AnimatedNavButton({
    @required this.controller,
    @required this.animation,
    @required this.onTap,
    @required this.icon,
  });

  final Animation animation;

  final AnimationController controller;
  final VoidCallback onTap;
  final Icon icon;
}

class AnimatedNavButtonState extends State<AnimatedNavButton> {
  Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _opacityAnimation = new Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: widget.controller,
        curve: new Interval(0.25, 0.5, curve: Curves.linear)));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: widget.controller,
        builder: (BuildContext context, Widget child) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Center(
              child: Opacity(
                opacity: _opacityAnimation.value,
                child: SizedBox(
                  height: 40.0 * (1 + widget.animation.value),
                  width: 40.0 * (1 + widget.animation.value),
                  child: new FlatButton(
                    color: Colors.white,
                    child: Center(child: widget.icon),
                    onPressed: widget.onTap,
                    shape: CircleBorder(),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
