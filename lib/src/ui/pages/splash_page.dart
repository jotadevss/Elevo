import 'package:elevo/src/constants.dart';
import 'package:elevo/src/core/atoms/transaction_atoms.dart';
import 'package:elevo/src/ui/common/components/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    getAllTransactionAction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('lib/assets/icons/logo.svg', height: 50),
              const Gap(height: 80),
              const CircularProgressIndicator(color: kPrimaryColor),
            ],
          ),
        ),
      ),
    );
  }
}
