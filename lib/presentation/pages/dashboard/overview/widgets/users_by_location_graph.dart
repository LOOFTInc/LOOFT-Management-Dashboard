import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:management_dashboard/logic/cubits/theme/theme_cubit.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../constants.dart';
import '../../../../../data/models/classes/category_chart_data.dart';
import '../../../../widgets/custom_container.dart';
import '../../../../widgets/text_widgets/custom_text.dart';

class UsersByLocationGraph extends StatefulWidget {
  /// Shows the users by location graph
  const UsersByLocationGraph({super.key});

  @override
  State<UsersByLocationGraph> createState() => _UsersByLocationGraphState();
}

class _UsersByLocationGraphState extends State<UsersByLocationGraph> {
  /// Data for the graph
  final List<CategoryChartData> data = <CategoryChartData>[
    CategoryChartData('Texas, US', 38.6, color: const Color(0xFFbaedbd)),
    CategoryChartData('Islamabad, PK', 22.5, color: const Color(0xFFc6c7f8)),
    CategoryChartData('Berlin, DE', 30.8, color: const Color(0xFF29abe2)),
    CategoryChartData('Other', 8.1, color: const Color(0xFF95a4fc)),
  ];

  /// Converted Data for the graph - Contains empty spaces
  late final List<CategoryChartData> chartData = List.generate(
    data.length * 2 - 1,
    (index) => index % 2 == 0
        ? data.elementAt((index / 2).truncate())
        : CategoryChartData('', 0.5, color: Colors.transparent),
  );

  /// Data used to create starting curves
  late final List<CategoryChartData> reverseChartData =
      List.generate(data.length * 2, (index) {
    if (index % 2 == 0) {
      return CategoryChartData('', 2);
    }

    CategoryChartData _ = data.elementAt((index / 2).truncate());
    return CategoryChartData(_.x, _.y - 1.6, color: _.color);
  });

  @override
  void initState() {
    super.initState();

    chartData.insert(0, CategoryChartData('', 0.25, color: Colors.transparent));
    chartData.add(CategoryChartData('', 0.25, color: Colors.transparent));
  }

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
              'Users by Location',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 20),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 4,
                  child: Stack(
                    children: [
                      SfCircularChart(
                        series: <CircularSeries<CategoryChartData, String>>[
                          DoughnutSeries<CategoryChartData, String>(
                            dataSource: chartData,
                            xValueMapper: (CategoryChartData data, _) => data.x,
                            yValueMapper: (CategoryChartData data, _) => data.y,
                            pointColorMapper: (CategoryChartData data, _) =>
                                data.color,
                            innerRadius: '63%',
                            cornerStyle: CornerStyle.endCurve,
                            radius: '95%',
                          ),
                        ],
                      ),
                      BlocBuilder<ThemeCubit, ThemeState>(
                        builder: (context, state) {
                          return SfCircularChart(
                            series: <CircularSeries<CategoryChartData, String>>[
                              DoughnutSeries<CategoryChartData, String>(
                                dataSource: reverseChartData,
                                xValueMapper: (CategoryChartData data, _) =>
                                    data.x,
                                yValueMapper: (CategoryChartData data, _) =>
                                    data.y,
                                pointColorMapper: (CategoryChartData data, _) =>
                                    data.color != null
                                        ? Colors.transparent
                                        : state.themeMode == ThemeMode.light
                                            ? K.cardsLightBackgroundColor
                                            : const Color(0xFF282828),
                                innerRadius: '63%',
                                cornerStyle: CornerStyle.endCurve,
                                radius: '95%',
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Flexible(
                  flex: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: data
                        .map<Widget>(
                          (e) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 5,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      size: 6,
                                      color: e.color,
                                    ),
                                    const SizedBox(width: 6),
                                    CustomText(
                                      e.x,
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Row(
                                  children: [
                                    CustomText(
                                      '${e.y.toStringAsFixed(1)}%',
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                        .toList(),
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
