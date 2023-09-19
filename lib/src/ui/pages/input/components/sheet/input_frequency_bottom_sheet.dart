import 'package:elevo/src/constants.dart';
import 'package:elevo/src/core/logic/input_logic.dart';
import 'package:elevo/src/router.dart';
import 'package:elevo/src/ui/common/components/gap.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_svg/svg.dart';

class InputFrequencyBottomSheet extends StatelessWidget {
  const InputFrequencyBottomSheet({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height / 2,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      child: Column(
        children: [
          Gap(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Select the frequency',
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
              itemCount: mapFrequency.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final frequency = mapFrequency[index];
                final title = frequency['title'];
                final description = frequency['description'];

                return InkWell(
                  onTap: () {
                    frequencyDataState.value = frequency['id'];
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
                            Gap(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  title!,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  description!,
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
