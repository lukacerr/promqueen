import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class EmptyData extends StatelessWidget {
  const EmptyData({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      child: Center(
        child: Wrap(
          direction: Axis.vertical,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 10,
          children: const [
            Opacity(opacity: 0.75, child: Icon(Icons.no_food, size: 100)),
            Text('Seems there is no loaded intakes...'),
            Opacity(opacity: 0.5, child: Text('Add one to get started.')),
          ],
        ),
      ),
    );
  }
}
