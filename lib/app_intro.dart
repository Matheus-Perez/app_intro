library app_intro;

import 'dart:math';

import 'package:flutter/material.dart';

class AppIntro extends StatefulWidget {
  List<Widget> pages;
  
  AppIntro({this.pages});

  @override
  _AppIntroState createState() => _AppIntroState();
}

class _AppIntroState extends State<AppIntro> {
   final PageController _pageController =
      PageController(keepPage: true, initialPage: 0);
      List<Widget> pages;

  @override
  Widget build(BuildContext context) {
      pages = widget.pages;



    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        itemCount: pages.length,
        itemBuilder: (context, index) => pages[index],
      ),
      bottomNavigationBar: Material(
        color: Colors.white,
        child: Container(
            height: 50,
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: InkWell(
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      child: Center( child: Text("Pular")),
                    ),
                    onTap: (){
                    //  Navigator.push(context, MaterialPageRoute(builder: (context) => InicioScreen()));
                    },
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: DotsIndicator(
                    controller: _pageController,
                    itemCount: pages.length,
                    color: Colors.black,
                    dotSize: 8,
                    dotSpacing: 25,
                    dotIncreaseSize: 2.0,
                    onPageSelected: (int page) {
                      _pageController.animateToPage(page,
                          duration: Duration(seconds: 2), curve: Curves.ease);
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: Icon(Icons.arrow_forward,
                        size: 30, color: Colors.black),
                    onPressed: () {
                      _pageController.nextPage(
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease);
                    },
                  ),
                )
              ],
            )
            ),
      ),
    );
  }
}

/// An indicator showing the currently selected page of a PageController
class DotsIndicator extends AnimatedWidget {
  DotsIndicator(
      {this.controller,
      this.itemCount,
      this.onPageSelected,
      this.color,
      this.dotSize,
      this.dotIncreaseSize,
      this.dotSpacing})
      : super(listenable: controller);

  // The PageController that this DotsIndicator is representing.
  final PageController controller;

  // The number of items managed by the PageController
  final int itemCount;

  // Called when a dot is tapped
  final ValueChanged<int> onPageSelected;

  // The color of the dots.
  final Color color;

  // The base size of the dots
  final double dotSize;

  // The increase in the size of the selected dot
  final double dotIncreaseSize;

  // The distance between the center of each dot
  final double dotSpacing;

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((controller.page ?? controller.initialPage) - index).abs(),
      ),
    );
    double zoom = 1.0 + (dotIncreaseSize - 1.0) * selectedness;
    return new Container(
      width: dotSpacing,
      child: new Center(
        child: new Material(
          color: color,
          type: MaterialType.circle,
          child: new Container(
            width: dotSize * zoom,
            height: dotSize * zoom,
            child: new InkWell(
              onTap: () => onPageSelected(index),
            ),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: new List<Widget>.generate(itemCount, _buildDot),
    );
  }
}

