import 'package:asp/asp.dart';
import 'package:elevo/src/config.dart';
import 'package:elevo/src/core/logic/app_logic.dart';
import 'package:elevo/src/core/logic/auth_logic.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    startSplashAnimation();
    super.initState();
  }

  void startSplashAnimation() async {
    await Future.delayed(const Duration(seconds: 5), () async {
      verifyStatusApp();
      logoutAction.call();
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(() => isLoadingState.value);
    return (isLoading)
        ? Container()
        : Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Lottie.asset("lib/assets/animation/splash.json"),
              ),
            ),
          );
  }
}
