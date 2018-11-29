import 'package:flutter/material.dart';
import 'package:flutter_app/animated_nav_button.dart';

class AnimatedBottomNavBar extends StatefulWidget {
  AnimatedBottomNavBar(
      {this.onTapFirst, this.onTapSecond, this.onTapThird, this.onTapFourth});

  AnimatedBottomNavBarState createState() => AnimatedBottomNavBarState();

  AnimationController _controller;

  VoidCallback onTapFirst;
  VoidCallback onTapSecond;
  VoidCallback onTapThird;
  VoidCallback onTapFourth;

  void expand() {
    if (_controller.status == AnimationStatus.completed) {
      _controller.reverse();
    } else if (_controller.status == AnimationStatus.dismissed) {
      _controller.forward();
    }
  }
}

class AnimatedBottomNavBarState extends State<AnimatedBottomNavBar>
    with TickerProviderStateMixin {
  Animation<double> _animation;
  Animation<double> _delayedAnimation;
  Animation<Offset> _slideAnimation;
  Animation<Offset> _delayedSlideAnimation;
  Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();

    widget._controller = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 500));

    _animation = new Tween(begin: 0.0, end: 0.6).animate(
        CurvedAnimation(parent: widget._controller, curve: Curves.linear));

    _delayedAnimation = new Tween(begin: 0.0, end: 0.6).animate(CurvedAnimation(
        parent: widget._controller,
        curve: Interval(0.1, 1.0, curve: Curves.linear)));

    _slideAnimation = new Tween(
      begin: new Offset(0.0, 0.0),
      end: new Offset(0.0, -0.4),
    ).animate(new CurvedAnimation(
      parent: widget._controller,
      curve: new Interval(0.0, 1.0, curve: Curves.elasticInOut),
    ));

    _delayedSlideAnimation = new Tween(
      begin: new Offset(0.0, 0.0),
      end: new Offset(0.0, -0.2),
    ).animate(new CurvedAnimation(
      parent: widget._controller,
      curve: new Interval(0.15, 1.0, curve: Curves.elasticInOut),
    ));

    _opacityAnimation = new Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: widget._controller,
        curve: new Interval(0.25, 0.5, curve: Curves.linear)));
  }

  @override
  Widget build(BuildContext context) {
    final double _width = MediaQuery.of(context).size.width;
    final double _startHeight =
        90.0; //MediaQuery.of(context).size.height * 0.20;

    void onTapControl() {
      print("tapped a nav button");
    }

    return Stack(
      children: <Widget>[
        // FAB action buttons
        Container(
          height: _startHeight,
          width: _width,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: SlideTransition(
                  position: _delayedSlideAnimation,
                  child: new AnimatedNavButton(
                    animation: _delayedAnimation,
                    controller: widget._controller,
                    onTap: onTapControl,
                    icon: Icon(Icons.camera_enhance),
                  ),
                ),
              ),
              Expanded(
                child: SlideTransition(
                  position: _slideAnimation,
                  child: new AnimatedNavButton(
                    animation: _animation,
                    controller: widget._controller,
                    onTap: onTapControl,
                    icon: Icon(Icons.music_note),
                  ),
                ),
              ),
              SizedBox(
                width: 30.0,
                height: _startHeight,
              ),
              Expanded(
                child: SlideTransition(
                  position: _slideAnimation,
                  child: new AnimatedNavButton(
                    animation: _animation,
                    controller: widget._controller,
                    onTap: onTapControl,
                    icon: Icon(Icons.videocam),
                  ),
                ),
              ),
              Expanded(
                child: SlideTransition(
                  position: _delayedSlideAnimation,
                  child: new AnimatedNavButton(
                    animation: _delayedAnimation,
                    controller: widget._controller,
                    onTap: onTapControl,
                    icon: Icon(Icons.mic),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Actual Navigation bar
        AnimatedBuilder(
          animation: widget._controller,
          builder: (BuildContext context, Widget child) {
            return Opacity(
              opacity: 1.0, //_opacityAnimation.value,
              child: Offstage(
                offstage: (_opacityAnimation.value == 0.0) ? true : false,
                child: Container(
                  color: Colors.white,
                  width: _width,
                  height: _startHeight,
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Center(
                          child: GestureDetector(
                            child: Icon(Icons.home),
                            onTap: widget.onTapFirst,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: GestureDetector(
                            child: Icon(Icons.perm_identity),
                            onTap: widget.onTapSecond,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 30.0,
                        height: _startHeight,
                      ),
                      Expanded(
                        child: Center(
                          child: GestureDetector(
                            child: Icon(Icons.search),
                            onTap: widget.onTapThird,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: GestureDetector(
                            child: Icon(Icons.email),
                            onTap: widget.onTapFourth,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
