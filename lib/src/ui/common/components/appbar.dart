import 'package:elevo/src/constants.dart';
import 'package:elevo/src/core/atoms/input_atoms.dart';
import 'package:elevo/src/ui/common/components/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class ElevoAppBar extends StatelessWidget {
  const ElevoAppBar({
    Key? key,
    this.assetName,
    required this.enableAction,
  }) : super(key: key);

  final String? assetName;
  final bool enableAction;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (enableAction)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                clearAction.call();
                context.pop();
              },
              borderRadius: BorderRadius.circular(100),
              child: Container(
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: kGrayColor.withOpacity(0.2),
                  ),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: SvgPicture.asset(
                  assetName!,
                ),
              ),
            ),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('lib/assets/icons/logo.svg'),
            Gap(width: 10),
            Text(
              'Elevo',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                color: Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
            Gap(width: (size.width / 2.5) - kMarginHorizontal),
          ],
        ),
      ],
    );
  }
}
