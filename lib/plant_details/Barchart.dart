import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BarChartSample extends StatefulWidget {
  @override
  _BarChartSampleState createState() => _BarChartSampleState();
}

class _BarChartSampleState extends State<BarChartSample> {
  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 15,
          minY: 0,
          titlesData: FlTitlesData(
            bottomTitles: SideTitles(
                showTitles: true,
                getTextStyles: (double d) =>  GoogleFonts.montserrat(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
                margin: 20,
                getTitles: (double value) {
                  switch (value.toInt()) {
                    case 0:
                      return 'Week1';
                    case 1:
                      return 'Week2';
                    case 2:
                      return 'Week3';
                    case 3:
                      return 'Week4';
                    default:
                      return '';
                  }
                }),
          ),
          barGroups: [
            BarChartGroupData(
              x: 0,
              barRods: [
                BarChartRodData(y: 7, colors: [
                  Color(0xff0293ee),
                  Color(0xff0293ee),
                ]),
              ],
              showingTooltipIndicators: [0],
            ),
            BarChartGroupData(
              x: 1,
              barRods: [
                BarChartRodData(y: 3, colors: [
                  Color(0xff0293ee),
                  Color(0xff0293ee),
                ]),
              ],
              showingTooltipIndicators: [0],
            ),
            BarChartGroupData(
              x: 2,
              barRods: [
                BarChartRodData(y: 8, colors: [
                  Color(0xff0293ee),
                  Color(0xff0293ee),
                ]),
              ],
              showingTooltipIndicators: [0],
            ),
            BarChartGroupData(
              x: 3,
              barRods: [
                BarChartRodData(y: 4, colors: [
                  Color(0xff0293ee),
                  Color(0xff0293ee),
                ]),
              ],
              showingTooltipIndicators: [0],
            ),
          ]),
    );
  }
}