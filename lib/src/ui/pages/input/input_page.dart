// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:asp/asp.dart';
import 'package:elevo/src/domain/enums/type_enum.dart';
import 'package:elevo/src/ui/pages/input/components/input_slider.dart';
import 'package:elevo/src/ui/pages/input/components/item_slider.dart';
import 'package:elevo/src/ui/pages/input/controller/slider_select_type_controller.dart';
import 'package:flutter/material.dart';

import 'package:elevo/src/constants.dart';
import 'package:elevo/src/ui/common/components/appbar.dart';
import 'package:elevo/src/ui/common/components/gap.dart';
import 'package:elevo/src/ui/pages/input/components/input_insert_amount.dart';
import 'package:elevo/src/ui/pages/input/controller/width_insert_amount_controller.dart';

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final TextEditingController _insertAmountController = TextEditingController();

  final isIncome = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final statusBar = MediaQuery.of(context).viewPadding.top;
    final expandedWith = context.select(() => expandWidthAtom.value);
    final selectedType = context.select(() => selectedTypeAtom.value);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: statusBar + 10, left: kMarginHorizontal, right: kMarginHorizontal),
        child: Column(
          children: [
            ElevoAppBar(size: size, assetName: 'lib/assets/icons/close.svg', enableAction: true),
            const Gap(height: 25),
            const Text(
              'Insert amount',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: kGrayColor,
                fontWeight: FontWeight.w500,
              ),
            ),
            InputInsertAmount(
              expandedWith: expandedWith,
              insertAmountController: _insertAmountController,
            ),
            Gap(height: 20),
            InputSlider(
              items: [
                ItemSlider(
                  isIncome: (selectedType == TypeTransaction.incomes),
                  label: 'Incomes',
                  color: kPrimaryColor,
                  onTap: () => changeTypeAction.value = TypeTransaction.incomes,
                ),
                ItemSlider(
                  isIncome: (selectedType == TypeTransaction.expense),
                  label: 'Expenses',
                  color: kErrorColor,
                  onTap: () => changeTypeAction.value = TypeTransaction.expense,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
