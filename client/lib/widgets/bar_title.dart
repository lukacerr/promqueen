import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../helpers/config_helper.dart';

class BarTitle extends StatelessWidget {
  final int chartMode;
  final Function changeChartMode;

  const BarTitle(
    this.chartMode, 
    this.changeChartMode, 
    { Key? key }
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onHorizontalDragEnd: (d) => changeChartMode((d.primaryVelocity ?? 0) <= 0),
        child: Text(
          ConfigHelper.getModeLabel(chartMode),
          style: const TextStyle(
            overflow: TextOverflow.fade
          ),
        ),
      )
    );
  }
}