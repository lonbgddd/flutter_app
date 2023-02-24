import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:assignments_final/screens/login/resignt/login.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class SplashSrceen extends StatefulWidget {
  const SplashSrceen({Key? key}) : super(key: key);

  @override
  State<SplashSrceen> createState() => _SplashSrceenState();
}

class _SplashSrceenState extends State<SplashSrceen> {
  @override
  void initState() {
    // Initialize SvgController
    super.initState();
  }

  @override
  void dispose() {
    // Dispose SvgController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Center(
        child: RiveAnimation.asset(
          'assets/icons/moving.riv',
          fit: BoxFit.fitHeight,
          alignment: Alignment.center,
        ),
      ),
      nextScreen: LoginScreen(),
      splashIconSize: 255,
    );
  }
}
