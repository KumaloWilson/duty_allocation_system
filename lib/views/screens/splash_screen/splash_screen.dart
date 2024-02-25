import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:platform_x_universal/utils/asset_utils/assets_util.dart';
import 'package:platform_x_universal/views/screens/universal_screens/onlanding_screen/onlandingscreen.dart';


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen.withScreenFunction(
      splash: Assets.blueLogo,
      splashIconSize: 100,

      screenFunction: () async{
        return const OnLandingPage();
      },
      splashTransition: SplashTransition.rotationTransition,
    );
  }
}
