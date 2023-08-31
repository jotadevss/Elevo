import 'package:asp/asp.dart';
import 'package:elevo/src/core/atoms/app_atoms.dart';
import 'package:elevo/src/core/atoms/category_atom.dart';
import 'package:elevo/src/core/atoms/input_atoms.dart';
import 'package:elevo/src/core/formatters/currency_formatter.dart';
import 'package:elevo/src/domain/enums/type_enum.dart';
import 'package:elevo/src/ui/pages/input/components/input_bottom_sheet.dart';
import 'package:elevo/src/ui/pages/input/components/input_slider.dart';
import 'package:elevo/src/ui/pages/input/components/item_slider.dart';
import 'package:elevo/src/ui/pages/input/controller/slider_select_type_controller.dart';
import 'package:flutter/material.dart';
import 'package:elevo/src/constants.dart';
import 'package:elevo/src/ui/common/components/appbar.dart';
import 'package:elevo/src/ui/common/components/gap.dart';
import 'package:elevo/src/ui/pages/input/components/input_insert_amount.dart';
import 'package:elevo/src/ui/pages/input/controller/width_insert_amount_controller.dart';
import 'package:flutter_svg/svg.dart';

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  @override
  void initState() {
    super.initState();
    loadAllCategoriesAction.call();
  }

  final TextEditingController _insertAmountController = TextEditingController();

  void showCategories(String type) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        final categories = context.select(() => (type == TypeTransaction.income.name) ? incomesCategories : expensesCategories);
        return InputCategoryBottomSheet(items: categories);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final statusBar = MediaQuery.of(context).viewPadding.top;
    final isLoading = context.select(() => isLoadingState.value);
    final selectedType = context.select(() => selectedTypeAtom.value);
    final category = context.select(() => categoryAtom.value);

    return Scaffold(
      body: (isLoading)
          ? Center(child: CircularProgressIndicator(color: kPrimaryColor))
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: statusBar + 10, left: kMarginHorizontal, right: kMarginHorizontal),
                child: Column(
                  children: [
                    const ElevoAppBar(assetName: 'lib/assets/icons/close.svg', enableAction: true),
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
                      insertAmountController: _insertAmountController,
                      onChanged: (text) {
                        observerTextLengthAction.value = text;
                        valueAtom.value = CurrencyFormatter.unformat(text);
                      },
                    ),
                    const Gap(height: 20),
                    InputSlider(
                      items: [
                        ItemSlider(
                          isIncome: (selectedType == TypeTransaction.income),
                          label: 'Incomes',
                          color: kPrimaryColor,
                          onTap: () {
                            final type = TypeTransaction.income;
                            changeTypeAction.value = type;
                            typeAtom.value = type.name;
                          },
                        ),
                        ItemSlider(
                          isIncome: (selectedType == TypeTransaction.expense),
                          label: 'Expenses',
                          color: kErrorColor,
                          onTap: () {
                            final type = TypeTransaction.expense;
                            changeTypeAction.value = type;
                            typeAtom.value = type.name;
                          },
                        ),
                      ],
                    ),
                    Gap(height: 22),
                    InkWell(
                      onTap: () => showCategories(typeAtom.value),
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
                                Gap(height: 6),
                                const Text(
                                  'Select the category',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: kGrayColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            (category == null)
                                ? IconButton(
                                    onPressed: () => showCategories(typeAtom.value),
                                    color: kPrimaryColor,
                                    icon: SvgPicture.asset(
                                      'lib/assets/icons/arrow-down.svg',
                                      height: 20,
                                    ),
                                  )
                                : IconButton(
                                    onPressed: () => showCategories(typeAtom.value),
                                    icon: CircleAvatar(
                                      backgroundColor: kPrimaryColor.withOpacity(0.1),
                                      child: SvgPicture.asset(categoryAtom.value!.iconPath),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
