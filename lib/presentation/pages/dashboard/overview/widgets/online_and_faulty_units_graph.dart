import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:management_dashboard/constants.dart';
import 'package:management_dashboard/data/models/classes/category_chart_data.dart';
import 'package:management_dashboard/data/models/enums/opacity_colors.dart';
import 'package:management_dashboard/logic/cubits/theme/theme_cubit.dart';
import 'package:management_dashboard/presentation/widgets/buttons/custom_popup_button.dart';
import 'package:management_dashboard/presentation/widgets/custom_container.dart';
import 'package:management_dashboard/presentation/widgets/custom_popup_menu_item.dart';
import 'package:management_dashboard/presentation/widgets/text_widgets/custom_text.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class OnlineAndFaultyUnitsGraph extends StatefulWidget {
  /// Widget to show the online and faulty units graph
  const OnlineAndFaultyUnitsGraph({super.key});

  @override
  State<OnlineAndFaultyUnitsGraph> createState() =>
      _OnlineAndFaultyUnitsGraphState();
}

class _OnlineAndFaultyUnitsGraphState extends State<OnlineAndFaultyUnitsGraph> {
  /// Current week data
  late List<CategoryChartData> currentWeek = CategoryChartData.generateData();

  /// Previous week data
  late List<CategoryChartData> previousWeek = CategoryChartData.generateData();

  /// Whether the graph is showing online units or faulty units
  bool isOnlineUnits = true;

  /// Color of the previous week graph
  final Color previousWeekGraphColor = const Color(0xFFabc5da);

  /// Is the current week graph line visible
  bool currentWeekGraphLineVisible = true;

  /// Is the previous week graph line visible
  bool previousWeekGraphLineVisible = true;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      width: 662,
      height: 320,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  _HelperGraphSwitchButton(
                    text: 'Online Units',
                    selected: isOnlineUnits,
                    onPressed: () {
                      setState(() {
                        isOnlineUnits = true;

                        currentWeek = CategoryChartData.generateData();
                        previousWeek = CategoryChartData.generateData();
                      });
                    },
                  ),
                  _HelperGraphSwitchButton(
                    text: 'Faulty Units',
                    selected: !isOnlineUnits,
                    onPressed: () {
                      setState(() {
                        isOnlineUnits = false;

                        currentWeek = CategoryChartData.generateData();
                        previousWeek = CategoryChartData.generateData();
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, right: 20),
                    child: BlocBuilder<ThemeCubit, ThemeState>(
                      builder: (context, state) {
                        return Container(
                          height: 20,
                          width: 1,
                          color: state.opacity20,
                        );
                      },
                    ),
                  ),
                  if (MediaQuery.of(context).size.width > K.mobileSize)
                    _HelperGraphVisibilityButton(
                      text: 'Current Week',
                      dotColor: K.primaryBlue,
                      visible: currentWeekGraphLineVisible,
                      onPressed: () {
                        setState(() {
                          currentWeekGraphLineVisible =
                              !currentWeekGraphLineVisible;
                        });
                      },
                    ),
                  if (MediaQuery.of(context).size.width > K.mobileSize)
                    _HelperGraphVisibilityButton(
                      text: 'Previous Week',
                      dotColor: previousWeekGraphColor,
                      visible: previousWeekGraphLineVisible,
                      onPressed: () {
                        setState(() {
                          previousWeekGraphLineVisible =
                              !previousWeekGraphLineVisible;
                        });
                      },
                    ),
                ],
              ),
              const CustomPopupButton(
                items: [
                  CustomPopupMenuItem(
                    child: Text('Meow'),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
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
              ),
              trackballBehavior: TrackballBehavior(
                activationMode: ActivationMode.singleTap,
                enable: true,
                shouldAlwaysShow: true,
                lineDashArray: const [2, 2],
                lineColor: Colors.grey.withOpacity(0.2),
                markerSettings: const TrackballMarkerSettings(
                  markerVisibility: TrackballVisibilityMode.visible,
                  color: K.primaryBlue,
                  width: 6,
                  height: 6,
                  borderWidth: 6,
                  borderColor: K.white,
                ),
                tooltipSettings: const InteractiveTooltip(),
              ),
              plotAreaBorderWidth: 0,
              series: <ChartSeries>[
                if (currentWeekGraphLineVisible)
                  SplineSeries<CategoryChartData, String>(
                    name: 'Current Week',
                    dataSource: currentWeek,
                    xValueMapper: (CategoryChartData data, _) => data.x,
                    yValueMapper: (CategoryChartData data, _) => data.y,
                    width: 4,
                    color: K.primaryBlue,
                  ),
                if (previousWeekGraphLineVisible)
                  SplineSeries<CategoryChartData, String>(
                    name: 'Previous Week',
                    dataSource: previousWeek,
                    xValueMapper: (CategoryChartData data, _) => data.x,
                    yValueMapper: (CategoryChartData data, _) => data.y,
                    width: 4,
                    color: previousWeekGraphColor,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HelperGraphVisibilityButton extends StatelessWidget {
  /// Helper widget to toggle the visibility of a graph line
  const _HelperGraphVisibilityButton({
    required this.text,
    this.onPressed,
    this.visible = false,
    required this.dotColor,
  });

  /// Text to be shown on the button
  final String text;

  /// Callback to be called when the button is pressed
  final VoidCallback? onPressed;

  /// Is the button selected
  final bool visible;

  /// Color of the dot
  final Color dotColor;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: dotColor,
            ),
            margin: const EdgeInsets.symmetric(horizontal: 6),
          ),
          CustomText(
            text,
            selectable: false,
            opacity: visible ? OpacityColors.op100 : OpacityColors.op40,
            style: TextStyle(
              decoration: visible ? null : TextDecoration.lineThrough,
            ),
          ),
        ],
      ),
    );
  }
}

class _HelperGraphSwitchButton extends StatelessWidget {
  /// Helper widget to show the online and faulty units graph
  const _HelperGraphSwitchButton({
    required this.text,
    this.onPressed,
    this.selected = false,
  });

  /// Text to be shown on the button
  final String text;

  /// Callback to be called when the button is pressed
  final VoidCallback? onPressed;

  /// Is the button selected
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      child: CustomText(
        text,
        opacity: selected ? OpacityColors.op100 : OpacityColors.op40,
        selectable: false,
      ),
    );
  }
}
