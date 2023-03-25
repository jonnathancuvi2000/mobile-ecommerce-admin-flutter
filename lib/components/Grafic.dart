import 'package:ecommerce_admin/utils/constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Grafic extends StatelessWidget {
  const Grafic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PieChart(
          PieChartData(
            // sectionsSpace: 0,
            // centerSpaceRadius: 60,
            startDegreeOffset: -90,
            sections: [
              PieChartSectionData(value: 10, color: Colors.red),
              PieChartSectionData(value: 25, color: primaryColor),
              PieChartSectionData(value: 15),
            ],
          ),
        ),
        Positioned.fill(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "28",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Text("data"),
            ],
          ),
        ),
      ],
    );
  }
}
