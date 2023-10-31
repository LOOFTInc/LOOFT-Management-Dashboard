import 'package:flutter/material.dart';
import 'package:management_dashboard/data/models/classes/category_chart_data.dart';
import 'package:management_dashboard/presentation/widgets/custom_container.dart';
import 'package:management_dashboard/presentation/widgets/text_widgets/custom_text.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class UsersByDeviceGraph extends StatefulWidget {
  /// Graph to show the count of users per device
  const UsersByDeviceGraph({super.key});

  @override
  State<UsersByDeviceGraph> createState() => _UsersByDeviceGraphState();
}

class _UsersByDeviceGraphState extends State<UsersByDeviceGraph> {
  final List<CategoryChartData> chartData = <CategoryChartData>[
    CategoryChartData('iOS', 10, color: const Color(0xFFbaedbd)),
    CategoryChartData('Android', 20, color: const Color(0xFF95a4fc)),
    CategoryChartData('Other', 0),
  ];

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      width: 432,
      height: 273,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 12),
            child: CustomText(
              'Users by Device',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 20),
          Flexible(
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(
                majorGridLines: const MajorGridLines(width: 0),
                minorGridLines: const MinorGridLines(width: 0),
                majorTickLines: const MajorTickLines(width: 0),
                minorTickLines: const MinorTickLines(width: 0),
              ),
              primaryYAxis: NumericAxis(
                axisLine: const AxisLine(width: 0),
                minorGridLines: const MinorGridLines(width: 0),
                majorTickLines: const MajorTickLines(width: 0),
                minorTickLines: const MinorTickLines(width: 0),
                maximumLabels: 2,
              ),
              plotAreaBorderWidth: 0,
              series: <ChartSeries<CategoryChartData, String>>[
                ColumnSeries<CategoryChartData, String>(
                  dataSource: chartData,
                  xValueMapper: (CategoryChartData data, _) => data.x,
                  yValueMapper: (CategoryChartData data, _) => data.y,
                  pointColorMapper: (CategoryChartData data, _) => data.color,
                  width: 0.25,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(6),
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
