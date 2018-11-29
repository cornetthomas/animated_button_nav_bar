import 'package:flutter/material.dart';
import 'package:flutter_app/animated_bottom_nav_bar_widget.dart';
import 'dart:math' as math;

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AnimatedBottomNavBar _bottomNavBar;

  void switchPage(int page) {
    _pageController.animateToPage(page,
        duration: new Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  FloatingActionButtonLocation fabLocation =
      FloatingActionButtonLocation.centerDocked;

  Widget fabIcon = Icon(Icons.add);

  int _currentPage = 0;
  PageController _pageController;

  @override
  initState() {
    _pageController = new PageController(
      initialPage: _currentPage,
    );

    _bottomNavBar = AnimatedBottomNavBar(
      onTapFirst: () {
        switchPage(0);
      },
      onTapSecond: () {
        switchPage(1);
      },
      onTapThird: () {
        switchPage(2);
      },
      onTapFourth: () {
        switchPage(3);
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white70,
      appBar: new AppBar(
        title: new Text(
          widget.title,
          style:
              Theme.of(context).textTheme.title.copyWith(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: new Center(
          child: new PageView(
        controller: _pageController,
        children: <Widget>[
          new Page("Page 1"),
          new Page("Page 2"),
          new Page("Page 3"),
          new Page("Page 4"),
        ],
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
      )),
      bottomNavigationBar: _bottomNavBar,
      floatingActionButtonLocation: fabLocation,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.yellow,
        onPressed: () {
          _bottomNavBar.expand();
          setState(() {
            if (fabLocation == FloatingActionButtonLocation.centerDocked) {
              fabLocation = FloatingActionButtonLocation.centerFloat;
              fabIcon = Icon(Icons.cancel);
            } else {
              fabLocation = FloatingActionButtonLocation.centerDocked;
              fabIcon = Icon(Icons.add);
            }
          });
        },
        child: fabIcon,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class Page extends StatelessWidget {
  String title;

  Page(this.title);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 300.0,
          height: 450.0,
          child: Card(
            child: Center(child: new Text(title)),
          ),
        ),
      ],
    );
  }
}
