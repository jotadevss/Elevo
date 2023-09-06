import 'package:elevo/src/constants.dart';
import 'package:elevo/src/ui/pages/input/controller/fixed_toggle_switch_controller.dart';
import 'package:flutter/material.dart';

class ToggleSwitchWidget extends StatelessWidget {
  const ToggleSwitchWidget({
    super.key,
    required this.isFixed,
  });

  final bool isFixed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Fixed Transaction",
            style: TextStyle(
              color: Colors.black,
              fontFamily: "Qanelas",
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          Transform.scale(
            scale: 0.8,
            child: Switch.adaptive(
                value: isFixed,
                activeColor: kPrimaryColor,
                onChanged: (newValue) {
                  toggleSwitchIsFixedAction.value = newValue;
                }),
          ),
        ],
      ),
    );
  }
}
