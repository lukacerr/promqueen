import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:promqueen_client/helpers/config_helper.dart';

class IndividualChart extends StatelessWidget {
  final List<charts.Series<PercentageChart, String>> chartData;
  final String unit;
  final int mode;

  const IndividualChart(
    this.chartData, 
    this.mode,
    { 
      this.unit = 'g', 
      Key? key 
    }
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String chartId = chartData.first.id;
    final int displayValue = ConfigHelper.getDisplayValue(chartData.first.data, mode);

    return Expanded(
      child: Stack(
        children: [
          charts.PieChart<String>(
            chartData,
            defaultRenderer: charts.ArcRendererConfig(arcWidth: 10),
            // animate: false,
          ),
          Center(
            child: Wrap(
              direction: Axis.vertical,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 5,
              children: [
                Text(
                  "$displayValue${mode == 0 || mode == 1 ? unit : '%'}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Opacity(
                  opacity: 0.5, 
                  child: Text(
                    chartId,
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 12
                    ),
                  )
                )
              ]
            ),
          )
        ]
      )
    );
  }
}