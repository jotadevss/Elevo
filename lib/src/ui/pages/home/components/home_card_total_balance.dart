import 'package:elevo/src/constants.dart';
import 'package:elevo/src/core/formatters/currency_formatter.dart';
import 'package:elevo/src/ui/common/components/gap.dart';
import 'package:elevo/src/ui/pages/home/controller/toggle_visibility_controller.dart';
import 'package:elevo/src/ui/pages/input/controller/fixed_toggle_switch_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CardTotalBalance extends StatelessWidget {
  const CardTotalBalance({
    super.key,
    required this.value,
    required this.onTap,
    required this.isVisible,
  });

  final double value;
  final void Function() onTap;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 38),
      decoration: BoxDecoration(
        color: Color(0xffF9F9F9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Total balance",
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
          Gap(height: 12),
          Text(
            (isVisible) ? '\$' + CurrencyFormatter.format(value.toString()) : "*****",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 32,
            ),
          ),
          Gap(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(100),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: kPrimaryColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        'lib/assets/icons/wallet-money_white.svg',
                        height: 22,
                      ),
                      Gap(width: 10),
                      Text(
                        "Add Transaction",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Gap(width: 15),
              InkWell(
                onTap: () {
                  toggleVisibilityAction.call();
                },
                borderRadius: BorderRadius.circular(100),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 24,
                  child: Icon(
                    Icons.visibility_off,
                    color: kSecondaryColor,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
