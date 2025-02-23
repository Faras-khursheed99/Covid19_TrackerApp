import 'dart:async';
import 'package:covid_19/App%20Screens/word_states_Screen.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 4),
        () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => WordStatesScreen())));
  }

  void dispose() {
    super.dispose();
    controller.dispose();
  }

  late final AnimationController controller =
      AnimationController(duration: Duration(seconds: 3), vsync: this)
        ..repeat();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedBuilder(
              child: Center(
                child: Container(
                    height: 200,
                    width: 300,
                    child: Image(
                      image: AssetImage(
                        "images/virius.jpg",
                      ),
                      fit: BoxFit.fill,
                    )),
              ),
              animation: controller,
              builder: (BuildContext context, Widget? child) {
                return Transform.rotate(
                    angle: controller.value * 2.0 * math.pi, child: child);
              }),
          SizedBox(
            height: MediaQuery.of(context).size.height * .12,
          ),
          const Text(
            "Covid_19\nTracker App",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          )
          // Center(child: Image(image: AssetImage("images/virius.jpg")))
        ],
      ),
    );
  }
}
