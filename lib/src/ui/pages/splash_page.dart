import 'package:elevo/src/core/logic/transaction/transaction_logic.dart';
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
    startApplication();
    super.initState();
  }

  void startApplication() async {
    await Future.delayed(const Duration(seconds: 8));
    getAllTransactionAction();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Lottie.asset("lib/assets/animation/splash.json"),
        ),
      ),
    );
  }
}
