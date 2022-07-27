import 'package:flutter/material.dart';
import 'package:promqueen_client/widgets/chart_section.dart';
import 'package:promqueen_client/widgets/list_section.dart';

import 'models/intake.dart';

import 'widgets/empty_data.dart';

class MainScreen extends StatelessWidget {
  final List<Intake> data;
  final Function deleteIntake;
  final Function editIntake;
  final Function duplicateIntake;
  final Function changeChartMode;
  final int chartMode;
  
  const MainScreen(
    this.data, 
    this.deleteIntake, 
    this.editIntake,
    this.duplicateIntake,
    this.chartMode, 
    this.changeChartMode, 
    { Key? key }
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return data.isEmpty ? const EmptyData() : Column(
      children: [
        Expanded(child: ChartSection(data, chartMode, changeChartMode)),
        Expanded(
          child: ListSection(
            data, 
            deleteIntake, 
            editIntake, 
            duplicateIntake
          )
        ),
      ],
    );
  }
}
