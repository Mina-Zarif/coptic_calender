import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../home_view/home_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int loadingProgress = 0;
  bool isDark = true;

  @override
  void initState() {
    super.initState();
    startLoadingAnimation();
    // navigateToHome();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDark ? Colors.black : const Color(0xfffdf0f1),
      body: Padding(
        padding: EdgeInsetsDirectional.only(
          top: MediaQuery.of(context).size.height * .27,
          bottom: 25,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                "assets/images/christian-cross-icon.jpg",
                fit: BoxFit.cover,
                width: 200,
              ),
              const Text(
                "Coptic Calendar",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              DotsIndicator(
                dotsCount: 4,
                mainAxisSize: MainAxisSize.min,
                position: loadingProgress,
                decorator: DotsDecorator(
                  color: isDark
                      ? const Color(0xfffdf0f1)
                      : const Color(0xff471515),
                  activeColor: isDark
                      ? const Color(0xff6d6969)
                      : const Color(0xff8c6969),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void startLoadingAnimation() {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        if (loadingProgress == 3) {
          navigateToHome();
        } else {
          loadingProgress = (loadingProgress + 1) % (4);
          startLoadingAnimation();
        }
      });
    });
  }

  void navigateToHome() {
    Future.delayed(const Duration(seconds: 0), () {
      Navigator.of(context).pushReplacement(
        PageTransition(
          type: PageTransitionType.fade,
          isIos: defaultTargetPlatform == TargetPlatform.iOS,
          child: const CalendarHomePage(),
          inheritTheme: false,
          ctx: context,
        ),
      );
    });
  }
}
