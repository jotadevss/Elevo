import 'package:elevo/src/constants.dart';
import 'package:elevo/src/ui/common/components/gap.dart';
import 'package:elevo/src/core/formatters/currency_formatter.dart';
import 'package:elevo/src/ui/pages/input/controller/width_insert_amount_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputInsertAmount extends StatelessWidget {
  const InputInsertAmount({
    super.key,
    required this.expandedWith,
    required TextEditingController insertAmountController,
  }) : _insertAmountController = insertAmountController;

  final bool expandedWith;
  final TextEditingController _insertAmountController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "\$",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 36,
          ),
        ),
        Gap(width: 5),
        Column(
          children: [
            IntrinsicWidth(
              stepWidth: (expandedWith == false) ? 100 : 1,
              child: TextFormField(
                controller: _insertAmountController,
                inputFormatters: [
                  CurrencyFormatter(),
                  LengthLimitingTextInputFormatter(16),
                ],
                decoration: InputDecoration(
                  hintText: '0,00',
                  hintStyle: TextStyle(
                    color: kGrayColor.withOpacity(0.4),
                    fontWeight: FontWeight.w600,
                    fontSize: 36,
                  ),
                  border: InputBorder.none,
                ),
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: "Qanelas",
                  fontWeight: FontWeight.w600,
                  fontSize: 36,
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                onChanged: (value) {
                  observerTextLengthAction.value = value;
                },
              ),
            ),
            Gap(),
          ],
        ),
      ],
    );
  }
}
