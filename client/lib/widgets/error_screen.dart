import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final Function refetchIntakes;
  const ErrorScreen(this.refetchIntakes, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: (() async => await refetchIntakes(true)),
      child: AbsorbPointer(
        child: Center(
          child: Wrap(
            direction: Axis.vertical,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 10,
            children: const [
              Opacity(opacity: 0.75, child: Icon(Icons.error, size: 100)),
              Text('Seems there was an error retreiving data.'),
              Opacity(opacity: 0.5, child: Text('Tap anywhere to retry.')),
            ],
          ),
        ),
      ),
    );
  }
}
