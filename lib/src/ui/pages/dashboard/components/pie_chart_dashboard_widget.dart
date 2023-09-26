import 'package:elevo/src/constants.dart';
import 'package:elevo/src/core/dto/pie_chart_dto.dart';
import 'package:elevo/src/core/formatters/currency_formatter.dart';
import 'package:elevo/src/ui/common/components/gap.dart';
import 'package:elevo/src/ui/pages/dashboard/components/indicator_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PieChartDashboardWidget extends StatelessWidget {
  const PieChartDashboardWidget({
    super.key,
    required this.dtos,
    required this.value,
    this.icon,
    this.svgPath,
    this.colorIcon,
    required this.dashboard,
    required this.label,
    this.description,
  });

  final Widget dashboard;
  final List<PieChartDTO> dtos;
  final Icon? icon;
  final String? svgPath;
  final Color? colorIcon;
  final double value;
  final String label;
  final String? description;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kGrayColor.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 19,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12),
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
          const Gap(height: 24),
          SizedBox(
            height: 250,
            width: double.infinity,
            child: Stack(
              alignment: Alignment.center,
              children: [
                dashboard,
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    icon != null
                        ? icon!
                        : SvgPicture.asset(
                            svgPath ?? 'lib/assets/icons/wallet-money.svg',
                            height: 24,
                            colorFilter: ColorFilter.mode(colorIcon ?? Colors.black, BlendMode.srcIn),
                          ),
                    Text(
                      '\$' + CurrencyFormatter.format(value.toString()),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      description ?? 'Total added',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 14,
                        color: kGrayColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Gap(height: 12),
                  ],
                ),
              ],
            ),
          ),
          const Gap(height: 36),
          SizedBox(
            height: ((size.height / 36) * dtos.length) + ((dtos.length < 8) ? 50 : 110),
            child: ListView.builder(
              itemCount: dtos.length,
              controller: new ScrollController(keepScrollOffset: false),
              physics: const NeverScrollableScrollPhysics(),
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
