import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  static Duration duration = const Duration(milliseconds: 800);
  static Cubic defaultCurve = Curves.fastLinearToSlowEaseIn;

  static double outerCardsTiltVal = 0.418; //24 degrees
  static double middleCardsTiltVal = 0.139; //8 degrees

  static double card1InitRotation = 0.049;
  static double card2InitRotation = 0.034;
  static double card3InitRotation = -0.109;
  static double card4InitRotation = 0.104;

  static double bigCardHeight = 200.0;
  static double bigCardWidth = 150.0;

  static double smallCardHeight = 70.0;
  static double smallCardWidth = 55.0;

  bool cardsExpanded = false;

  late final AnimationController _controller =
      AnimationController(vsync: this, duration: duration);

  late Animation rot1 = buildAnimation(card1InitRotation, -outerCardsTiltVal);
  late Animation rot2 = buildAnimation(card2InitRotation, -middleCardsTiltVal);
  late Animation rot3 = buildAnimation(card3InitRotation, middleCardsTiltVal);
  late Animation rot4 = buildAnimation(card4InitRotation, outerCardsTiltVal);

  late Animation translate1 = buildAnimation(0.0, -90.0);
  late Animation translate2 = buildAnimation(-10.0, -30.0);
  late Animation translate3 = buildAnimation(0.0, 30.0);
  late Animation translate4 = buildAnimation(10.0, 90.0);

  late Animation smallCardRotateLeft = buildAnimation(0.0, -0.408);
  late Animation smallCardRotateRight = buildAnimation(0.0, 0.408);
  late Animation smallCardTranslate = buildAnimation(-20.0, -120.0);

  late List data = getData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (cardsExpanded) {
              _controller.reverse();
            } else {
              _controller.forward();
            }
            cardsExpanded = !cardsExpanded;
          });
        },
      ),
      body: Center(
        child: Stack(children: [
          ...List.generate(
            data.length,
            (index) {
              var item = data[index];
              return AnimatedBuilder(
                animation: item['rotateAnimation'],
                builder: (_, child) {
                  return Transform.rotate(
                    angle: item['rotateAnimation'].value,
                    child: AnimatedBuilder(
                      animation: item['translateAnimation'],
                      builder: (_, child) {
                        return Transform.translate(
                          offset: Offset(
                              (item['translateAnimation'].value *
                                      item['widthFactor']) -
                                  item['initialWidthOffset'],
                              -item['translateAnimation'].value.abs() *
                                  item['heightFactor']),
                          child: MouseRegion(
                            onEnter: (PointerEvent details) =>
                                _controller.forward(),
                            onExit: (PointerEvent details) =>
                                _controller.reverse(),
                            child: Container(
                              height: item['height'],
                              width: item['width'],
                              decoration: BoxDecoration(
                                color: item['color'],
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            },
          ),
        ]),
      ),
    );
  }

  Animation<double> buildAnimation(double start, double end) {
    return Tween(
      begin: start,
      end: end,
    ).animate(CurvedAnimation(parent: _controller, curve: defaultCurve));
  }

  List getData() {
    return [
      {
        'rotateAnimation': rot1,
        'translateAnimation': translate1,
        'color': Colors.pink,
        'height': bigCardHeight,
        'width': bigCardWidth,
        'heightFactor': 0.3,
        'widthFactor': 1.0,
        'initialWidthOffset': 0.0,
      },
      {
        'rotateAnimation': smallCardRotateLeft,
        'translateAnimation': smallCardTranslate,
        'color': Colors.purple,
        'height': smallCardHeight,
        'width': smallCardWidth,
        'heightFactor': -0.4,
        'widthFactor': -1.4,
        'initialWidthOffset': 0.0,
      },
      {
        'rotateAnimation': rot2,
        'translateAnimation': translate2,
        'color': Colors.green,
        'height': bigCardHeight,
        'width': bigCardWidth,
        'heightFactor': 0.3,
        'widthFactor': 1.0,
        'initialWidthOffset': 0.0,
      },
      {
        'rotateAnimation': smallCardRotateRight,
        'translateAnimation': smallCardTranslate,
        'color': Colors.amber,
        'height': smallCardHeight,
        'width': smallCardWidth,
        'heightFactor': -0.0,
        'widthFactor': 1.0,
        'initialWidthOffset': -39.0,
      },
      {
        'rotateAnimation': smallCardRotateRight,
        'translateAnimation': smallCardTranslate,
        'color': Colors.cyan,
        'height': smallCardHeight,
        'width': smallCardWidth,
        'heightFactor': -1.0,
        'widthFactor': -2.0,
        'initialWidthOffset': 0.0,
      },
      {
        'rotateAnimation': rot3,
        'translateAnimation': translate3,
        'color': Colors.blue,
        'height': bigCardHeight,
        'width': bigCardWidth,
        'heightFactor': 0.3,
        'widthFactor': 1.0,
        'initialWidthOffset': 0.0,
      },
      {
        'rotateAnimation': smallCardRotateLeft,
        'translateAnimation': smallCardTranslate,
        'color': Colors.orange,
        'height': smallCardHeight,
        'width': smallCardWidth,
        'heightFactor': -1.3,
        'widthFactor': 1.6,
        'initialWidthOffset': -smallCardHeight,
      },
      {
        'rotateAnimation': rot4,
        'translateAnimation': translate4,
        'color': Colors.red,
        'height': bigCardHeight,
        'width': bigCardWidth,
        'heightFactor': 0.3,
        'widthFactor': 1.0,
        'initialWidthOffset': 0.0,
      },
    ];
  }
}
