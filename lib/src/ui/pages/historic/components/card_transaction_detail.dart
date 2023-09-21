import 'package:elevo/src/constants.dart';
import 'package:elevo/src/core/dto/category_props_dto.dart';
import 'package:elevo/src/core/formatters/currency_formatter.dart';
import 'package:elevo/src/core/formatters/date_formatter.dart';
import 'package:elevo/src/domain/entity/transaction.dart';
import 'package:elevo/src/domain/enums/type_enum.dart';
import 'package:elevo/src/ui/common/components/gap.dart';
import 'package:flutter/material.dart';

class CardTransactionDetails extends StatelessWidget {
  const CardTransactionDetails({
    super.key,
    required this.categoryProps,
    required this.transaction,
    required this.size,
  });

  final CategoryProsDTO categoryProps;
  final TransactionEntity transaction;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: kGrayColor.withOpacity(0.2),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                categoryProps.label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '\$' + CurrencyFormatter.format(transaction.value.toString()),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: (TypeTransaction.income.name == transaction.type) ? kPrimaryColor : kErrorColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const Gap(height: 32),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Transaction ID',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Gap(height: 6),
              Text(
                transaction.id,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  color: kGrayColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 14),
            child: Divider(
              color: kGrayColor.withOpacity(0.1),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Creation Date',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Gap(height: 6),
                  Text(
                    DateFormatter.format(transaction.createAt),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      color: kGrayColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Gap(width: size.width / 6),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Frequency',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Gap(height: 6),
                  Text(
                    transaction.type,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      color: kGrayColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 14),
            child: Divider(
              color: kGrayColor.withOpacity(0.1),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Description',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Gap(height: 6),
                  Text(
                    transaction.description ?? 'No Description',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: kGrayColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
