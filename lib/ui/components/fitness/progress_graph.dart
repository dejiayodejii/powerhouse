import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:powerhouse/core/extensions/_extension.dart';
import 'package:powerhouse/ui/constants/_constants.dart';
import 'package:powerhouse/ui/views/fitness/notifiers/fitness_notifier.dart';

class ProgressGraph extends HookConsumerWidget {
  const ProgressGraph({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(fitnessNotifier);
    return Visibility(
      visible: !true,
      child: SvgPicture.asset(
        AppAssets.mockGraphSvg,
        fit: BoxFit.fitWidth,
      ),
      replacement: LineChart(
        LineChartData(
          backgroundColor: AppColors.veryLightGrey,
          borderData: FlBorderData(show: false),
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(
            show: !false,
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                interval: 25,
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toInt().toString(),
                    style: AppTextStyles.kTextStyle(
                      8,
                      weight: FontWeight.normal,
                      color: AppColors.black,
                    ),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                interval: state.graphInterval,
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final day = DateTimeExension.fromMinutesSinceEpoch(value);
                  return Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: Text(
                      DateFormat('MMM dd').format(day),
                      style: AppTextStyles.kTextStyle(
                        8,
                        weight: FontWeight.normal,
                        color: AppColors.black,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          minY: 0,
          maxY: 100,
          lineBarsData: [
            LineChartBarData(
              spots: state.pastProgress!.map(
                (progress) {
                  return FlSpot(
                    progress.timestamp.daytimeDay.minutesSinceEpoch,
                    progress.doneRatio * 100,
                  );
                },
              ).toList(),
              isCurved: true,
              barWidth: 5,
              curveSmoothness: 0.5,
              preventCurveOverShooting: true,
              color: AppColors.black,
              dotData: FlDotData(show: !true),
              isStrokeCapRound: true,
            ),
          ],
        ),
      ),
    );
  }
}
