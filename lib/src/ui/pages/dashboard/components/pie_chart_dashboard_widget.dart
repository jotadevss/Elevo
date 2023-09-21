import 'package:elevo/src/constants.dart';
import 'package:elevo/src/core/dto/pie_chart_dto.dart';
import 'package:elevo/src/core/formatters/currency_formatter.dart';
import 'package:elevo/src/ui/common/components/gap.dart';
import 'package:elevo/src/ui/pages/dashboard/components/indicator_item_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PieChartDashboardWidget extends StatelessWidget {
  const PieChartDashboardWidget({
    super.key,
    required this.sections,
    required this.dtos,
    required this.value,
  });

  final List<PieChartSectionData> sections;
  final List<PieChartDTO> dtos;
  final double value;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kGrayColor.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Overview',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 19,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: kGrayColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Text(
                  'This Month',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: kGrayColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          Gap(height: 24),
          SizedBox(
            height: 250,
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: [
                PieChart(
                  PieChartData(
                    sections: sections,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'lib/assets/icons/wallet-money.svg',
                      height: 28,
                    ),
                    Text(
                      '\$' + CurrencyFormatter.format(value.toString()),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Total added',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: kGrayColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Gap(height: 12),
                  ],
                ),
              ],
            ),
          ),
          Gap(height: 36),
          SizedBox(
            height: ((size.height / 36) * dtos.length) + ((dtos.length < 8) ? 50 : 110),
            child: ListView.builder(
              itemCount: dtos.length,
              controller: new ScrollController(keepScrollOffset: false),
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: IndicatorItem(
                    label: dtos[index].label ?? "",
                    value: dtos[index].value,
                    percent: dtos[index].percent,
                    color: dtos[index].color,
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
