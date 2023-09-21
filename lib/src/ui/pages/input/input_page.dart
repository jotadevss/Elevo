import 'package:asp/asp.dart';
import 'package:elevo/src/core/logic/app_logic.dart';
import 'package:elevo/src/core/logic/category_logic.dart';
import 'package:elevo/src/core/logic/input_logic.dart';
import 'package:elevo/src/ui/common/components/error_message.dart';
import 'package:elevo/src/ui/pages/input/components/input_category_widget.dart';
import 'package:elevo/src/ui/pages/input/components/input_date_widget.dart';
import 'package:elevo/src/ui/pages/input/components/input_description_widget.dart';
import 'package:elevo/src/ui/pages/input/components/input_frequency_widget.dart';
import 'package:elevo/src/ui/pages/input/components/sheet/input_frequency_bottom_sheet.dart';
import 'package:elevo/src/ui/pages/input/components/submit_widget.dart';
import 'package:elevo/src/ui/pages/input/components/toggle_switch_widget.dart';
import 'package:elevo/src/ui/pages/input/controller/date_picker_controller.dart';
import 'package:elevo/src/ui/pages/input/controller/fixed_toggle_switch_controller.dart';
import 'package:flutter/material.dart';
import 'package:elevo/src/constants.dart';
import 'package:elevo/src/core/formatters/currency_formatter.dart';
import 'package:elevo/src/domain/enums/type_enum.dart';
import 'package:elevo/src/ui/common/components/appbar.dart';
import 'package:elevo/src/ui/common/components/gap.dart';
import 'package:elevo/src/ui/pages/input/components/sheet/input_category_bottom_sheet.dart';
import 'package:elevo/src/ui/pages/input/components/input_insert_amount_widget.dart';
import 'package:elevo/src/ui/pages/input/components/input_slider_widget.dart';
import 'package:elevo/src/ui/pages/input/components/item_slider_widget.dart';
import 'package:elevo/src/ui/pages/input/controller/slider_select_type_controller.dart';
import 'package:elevo/src/ui/pages/input/controller/width_insert_amount_controller.dart';
import 'package:go_router/go_router.dart';

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
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select(() => isLoadingState.value);
    final selectedType = context.select(() => selectedTypeAtom.value);
    final isFixed = context.select(() => toggleSwitchIsFixedAction.value);
    final ([valueError, categoryError] as List<bool>) = context.select(() => [isValueErrorState.value, isCategoryErrorState.value]);

    return Scaffold(
      body: (isLoading)
          ? const Center(child: CircularProgressIndicator(color: kPrimaryColor))
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(top: getStatusBar(context) + 10, left: kMarginHorizontal, right: kMarginHorizontal),
                child: Column(
                  children: [
                    ElevoAppBar(
                      assetName: 'lib/assets/icons/close.svg',
                      enableAction: true,
                      isCenter: false,
                      action: () {
                        clearDataAction.call();
                        context.pop();
                      },
                    ),
                    const Gap(height: 25),
                    Text(
                      'Insert amount',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: (valueError) ? kErrorColor : kGrayColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    InputInsertAmount(
                      insertAmountController: _insertAmountController,
                      onChanged: (text) {
                        observerTextLengthAction.value = text;
                        valueDataState.value = CurrencyFormatter.unformat(text);
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
                            typeDataState.value = type.name;
                          },
                        ),
                        ItemSlider(
                          isIncome: (selectedType == TypeTransaction.expense),
                          label: 'Expenses',
                          color: kErrorColor,
                          onTap: () {
                            final type = TypeTransaction.expense;
                            changeTypeAction.value = type;
                            typeDataState.value = type.name;
                          },
                        ),
                      ],
                    ),
                    const Gap(height: 26),
                    InputCategoryWidget(
                      onTap: () => showCategories(typeDataState.value),
                      subtitle: Text(
                        'Select the category',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: (categoryError) ? kErrorColor : kGrayColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Divider(color: kGrayColor.withOpacity(0.1)),
                    ),
                    InputDateWidget(
                      onTap: () => showDatePickerAction.value = context,
                    ),
                    const Gap(height: 10),
                    ToggleSwitchWidget(
                      onChanged: (newValue) {
                        toggleSwitchIsFixedAction.value = newValue;
                      },
                    ),
                    if (isFixed) InputFrequencyWidget(onTap: showFrequencies),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Divider(color: kGrayColor.withOpacity(0.1)),
                    ),
                    InputDescriptionWidget(
                        descriptionController: _descriptionController,
                        onChanged: (text) {
                          descriptionDataState.value = text;
                        }),
                    if (valueError) const ErrorMessage(message: 'Value not entered. Please enter it before proceeding.'),
                    if (categoryError) const ErrorMessage(message: 'Category not selected. Please choose one before proceeding.'),
                    SubmitWidget(onTap: () => submitTransactionAction.call()),
                  ],
                ),
              ),
            ),
    );
  }

  void showCategories(String type) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        final categories = context.select(() => (type == TypeTransaction.income.name) ? getIncomesCategories : getExpensesCategories);
        return InputCategoryBottomSheet(items: categories);
      },
    );
  }

  void showFrequencies() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        final size = MediaQuery.of(context).size;
        return InputFrequencyBottomSheet(size: size);
      },
    );
  }
}
