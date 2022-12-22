import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartSampleHum extends StatefulWidget {
  @override
  _LineChartSampleHumState createState() => _LineChartSampleHumState();
}

class _LineChartSampleHumState extends State<LineChartSampleHum> {
  List<Color> gradientColors = [
    Color(0xffFFBC47),
    Color(0xffF1F461),
  ];
  @override
  Widget build(BuildContext context) {
    return LineChart(LineChartData(
        titlesData: FlTitlesData(
            show: true,
            bottomTitles: SideTitles(
                showTitles: true,
                reservedSize: 22,
                getTextStyles: (val) => const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
                getTitles: (x) {
                  switch (x.toInt()) {
                    case 2:
                      return 'Week1';
                    case 5:
                      return 'week2';
                    case 8:
                      return 'week3';
                  }
                  return '';
                }),
            leftTitles: SideTitles(
                showTitles: true,
                getTextStyles: (val) => const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
                getTitles: (y) {
                  switch (y.toInt()) {
                    case 1:
                      return '23.2';
                    case 3:
                      return '25.6';
                    case 5:
                      return '26.0';
                  }
                  return '';
                })),
        minX: 0,
        maxX: 10,
        minY: 0,
        maxY: 6,
        lineBarsData: [
          LineChartBarData(
              spots: [
                FlSpot(0, 0),
                FlSpot(3, 3),
                FlSpot(5, 1),
                FlSpot(7, 5),
                FlSpot(8, 4),
                FlSpot(10, 2),
              ],
              isCurved: true,
              colors: gradientColors,
              barWidth: 5,
              belowBarData: BarAreaData(
                show: true,
                colors: gradientColors.map((e) => e.withOpacity(0.3)).toList(),
              ),
              dotData: FlDotData(
                show: false,
              )),
        ]),
      swapAnimationDuration: Duration(milliseconds: 350), // Optional
      // Optional
    );
  }
}