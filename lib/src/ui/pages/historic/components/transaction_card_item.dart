import 'package:elevo/src/constants.dart';
import 'package:elevo/src/core/formatters/currency_formatter.dart';
import 'package:elevo/src/domain/entity/transaction.dart';
import 'package:elevo/src/domain/enums/type_enum.dart';
import 'package:elevo/src/extensions.dart';
import 'package:elevo/src/ui/common/components/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TransactionCardItem extends StatelessWidget {
  const TransactionCardItem({
    super.key,
    required this.iconPath,
    required this.label,
    required this.item,
    required this.value,
    required this.transactionDate,
    required this.fixedTransaction,
    required this.onTap,
  });

  final String iconPath;
  final String label;
  final TransactionEntity item;
  final double value;
  final String transactionDate;
  final String fixedTransaction;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: InkWell(
        onTap: onTap,
        splashColor: kGrayColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(25),
        child: Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: kGrayColor.withOpacity(0.2),
            ),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            iconPath,
                            width: 20,
                          ),
                          const Gap(width: 12),
                          Text(
                            label,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const Gap(height: 16, width: 0),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(17),
                          color: (TypeTransaction.income.name == item.type) ? kPrimaryColor.withOpacity(0.1) : kSecondaryColor.withOpacity(0.1),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Gap(width: 4),
                            Text(
                              (TypeTransaction.income.name == item.type) ? 'Income' : 'Expense',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 10,
                                color: (TypeTransaction.income.name == item.type) ? kPrimaryColor : kSecondaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Gap(width: 6),
                            Icon(
                              (TypeTransaction.income.name == item.type) ? Icons.trending_up_rounded : Icons.trending_down_rounded,
                              color: (TypeTransaction.income.name == item.type) ? kPrimaryColor : kSecondaryColor,
                              size: 11,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '\$' + CurrencyFormatter.format(value.toString()),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Transaction date',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: kGrayColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    transactionDate,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const Gap(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Fixed transaction',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: kGrayColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    fixedTransaction.capitalize(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
