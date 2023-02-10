import 'dart:math';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: Duration(milliseconds: 300));

  // double outerCardsTiltValue = 0.261; //15 degrees
  // double middleCardsTiltValue = 0.087; //5 degrees

  double outerCardsTiltValue = 0.418; //24 degrees
  double middleCardsTiltValue = 0.139; //8 degrees

  // double outerCardsTiltValue = 0.6283; //36 degrees
  // double middleCardsTiltValue = 0.2094; //12 degrees

  double begin1 = 0.049;
  double begin2 = 0.034;
  double begin3 = -0.109;
  double begin4 = 0.104;

  bool expanded = false;
  @override
  Widget build(BuildContext context) {
    // Animation anim = _controller.drive(CurveTween(curve: Curves.decelerate));
    // Animation anim = _controller.drive(CurveTween(curve: Curves.easeInOutBack));

    Animation anim1 = new Tween(
      begin: begin1,
      end: -outerCardsTiltValue,
    ).animate(
        new CurvedAnimation(parent: _controller, curve: Curves.decelerate));

    Animation anim2 = new Tween(
      begin: begin2,
      end: -middleCardsTiltValue,
    ).animate(
        new CurvedAnimation(parent: _controller, curve: Curves.decelerate));

    Animation anim3 = new Tween(
      begin: begin3,
      end: middleCardsTiltValue,
    ).animate(
        new CurvedAnimation(parent: _controller, curve: Curves.decelerate));

    Animation anim4 = new Tween(
      begin: begin4,
      end: outerCardsTiltValue,
    ).animate(
        new CurvedAnimation(parent: _controller, curve: Curves.decelerate));

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (expanded) {
              _controller.reverse();
            } else {
              _controller.forward();
            }
            expanded = !expanded;
          });
        },
      ),
      body: Center(
        child: Stack(children: [
          AnimatedBuilder(
            animation: anim1,
            builder: (_, child) {
              return Transform.rotate(
                angle: anim1.value,
                child: Transform.translate(
                  offset: Offset((anim1.value - begin1) * 150, 0),
                  child: Container(
                    height: 200,
                    width: 150,
                    color: Colors.black,
                  ),
                ),
              );
            },
          ),
          AnimatedBuilder(
            animation: anim2,
            builder: (_, child) {
              return Transform.rotate(
                angle: anim2.value,
                child: Transform.translate(
                  offset: Offset((anim2.value - begin2) * 150, 0),
                  child: Container(
                    height: 200,
                    width: 150,
                    color: Colors.green,
                  ),
                ),
              );
            },
          ),
          AnimatedBuilder(
            animation: anim3,
            builder: (_, child) {
              return Transform.rotate(
                angle: anim3.value,
                child: Transform.translate(
                  offset: Offset((anim3.value - begin3) * 150, 0),
                  child: Container(
                    height: 200,
                    width: 150,
                    color: Colors.blue,
                  ),
                ),
              );
            },
          ),
          AnimatedBuilder(
            animation: anim4,
            builder: (_, child) {
              return Transform.rotate(
                angle: anim4.value,
                child: Transform.translate(
                  offset: Offset((anim4.value - begin4) * 150, 0),
                  child: Container(
                    height: 200,
                    width: 150,
                    color: Colors.red,
                  ),
                ),
              );
            },
          ),
        ]),
      ),
    );
  }
}
