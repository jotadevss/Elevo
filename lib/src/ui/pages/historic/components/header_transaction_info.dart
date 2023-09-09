import 'package:elevo/src/constants.dart';
import 'package:elevo/src/core/atoms/transaction/transaction_atoms.dart';
import 'package:elevo/src/core/formatters/currency_formatter.dart';
import 'package:flutter/material.dart';

class HeaderTransactionInfo extends StatelessWidget {
  const HeaderTransactionInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 18, horizontal: 24),
      decoration: BoxDecoration(
        color: kGrayColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Total transaction: ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Qanelas',
                  ),
                ),
                TextSpan(
                  text: totalTransactions.toString(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Qanelas',
                  ),
                ),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Total balance: ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Qanelas',
                  ),
                ),
                TextSpan(
                  text: '\$' + CurrencyFormatter.format(totalBalance.toString()),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Qanelas',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
