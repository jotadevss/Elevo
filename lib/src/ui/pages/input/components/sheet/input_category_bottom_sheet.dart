// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math' as math;
import 'package:elevo/src/core/logic/input_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:elevo/src/constants.dart';
import 'package:elevo/src/domain/entity/category.dart';
import 'package:elevo/src/router.dart';
import 'package:elevo/src/ui/common/components/gap.dart';

class InputCategoryBottomSheet extends StatelessWidget {
  const InputCategoryBottomSheet({
    Key? key,
    required this.items,
  }) : super(key: key);

  final List<CategoryEntity> items;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      height: size.height / 1.5,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Column(
        children: [
          Gap(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Select the category',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextButton(
                onPressed: () => router.pop(),
                child: const Text(
                  'Close',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Gap(height: 20),
          Expanded(
            child: ListView.separated(
              itemCount: items.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final category = items[index];
                final icon = category.iconPath;
                final label = category.title;

                return InkWell(
                  onTap: () {
                    categoryAtom.value = category;
                    router.pop();
                  },
                  borderRadius: BorderRadius.circular(100),
                  splashColor: kPrimaryColor.withOpacity(0.02),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: kPrimaryColor.withOpacity(0.1),
                              radius: 25,
                              child: SvgPicture.asset(icon),
                            ),
                            Gap(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  label,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  'ID: ${(index + 1).hashCode}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: kGrayColor.withOpacity(0.8),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Transform.rotate(
                          angle: math.pi / -2,
                          child: SvgPicture.asset('lib/assets/icons/arrow-down.svg', height: 20),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
