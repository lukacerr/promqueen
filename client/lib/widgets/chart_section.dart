import 'package:flutter/material.dart';
import 'package:promqueen_client/helpers/config_helper.dart';

import '../models/intake.dart';

import '../widgets/individual_chart.dart';

class ChartSection extends StatelessWidget {
  final List<Intake> data;
  final int mode;
  final Function changeChartMode;

  const ChartSection(
    this.data, 
    this.mode, 
    this.changeChartMode, 
    {Key? key}
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onHorizontalDragEnd: (d) => changeChartMode((d.primaryVelocity ?? 0) <= 0),
      child: AbsorbPointer(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                children: [
                  IndividualChart(ConfigHelper.getCalorieChart(data), mode, unit: 'kcal'),
                  IndividualChart(ConfigHelper.getCarbsChart(data), mode),
                ],
              )),
              Expanded(
                child: Column(
                  children: [
                    IndividualChart(ConfigHelper.getProteinChart(data), mode),
                    IndividualChart(ConfigHelper.getFatsChart(data), mode),
                  ],
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}
