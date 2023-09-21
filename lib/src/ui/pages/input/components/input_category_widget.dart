import 'package:asp/asp.dart';
import 'package:elevo/src/constants.dart';
import 'package:elevo/src/core/logic/input_logic.dart';
import 'package:elevo/src/ui/common/components/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class InputCategoryWidget extends StatelessWidget {
  const InputCategoryWidget({
    Key? key,
    required this.onTap,
    required this.subtitle,
  }) : super(key: key);

  final void Function() onTap;
  final Widget subtitle;

  @override
  Widget build(BuildContext context) {
    final category = context.select(() => categoryDataState.value);
    return InkWell(
      onTap: onTap,
      splashColor: kGrayColor.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Category',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 19,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Gap(height: 6),
                subtitle,
              ],
            ),
            (category == null)
                ? IconButton(
                    onPressed: onTap,
                    color: kPrimaryColor,
                    icon: SvgPicture.asset(
                      'lib/assets/icons/arrow-down.svg',
                      height: 20,
                    ),
                  )
                : IconButton(
                    onPressed: onTap,
                    icon: CircleAvatar(
                      backgroundColor: kPrimaryColor.withOpacity(0.1),
                      child: SvgPicture.asset(categoryDataState.value!.iconPath),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
