import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:promqueen_client/widgets/settings_modal.dart';

class SettingsButton extends StatelessWidget {
  final Function refreshChart;
  const SettingsButton(this.refreshChart, { Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInRight(
      child: IconButton(
        icon: const Icon(Icons.settings),
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return SettingsModal(refreshChart);
            },
          );
        }
      )
    );
  }
}