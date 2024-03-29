import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartSample extends StatefulWidget {
  @override
  _LineChartSampleState createState() => _LineChartSampleState();
}

class _LineChartSampleState extends State<LineChartSample> {
  List<Color> gradientColors = [
    Color(0xff23b6e6),
    Color(0xff02d39a),
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
                      return '65.0';
                    case 3:
                      return '67.6';
                    case 5:
                      return '70.3';
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
                FlSpot(5, 4),
                FlSpot(7, 5),
                FlSpot(8, 1),
                FlSpot(10, 3),
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