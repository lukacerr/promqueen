import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class ResetButton extends StatelessWidget {
  final Function resetIntakes;
  const ResetButton(this.resetIntakes, { Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      child: IconButton(
        icon: const Icon(Icons.restart_alt),
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Reset foods'),
            content: const Text('This will permanently delete all the intakes currently loaded. Are you sure you want to proceed?'),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () => Navigator.pop(context, 'CANCEL'),
              ),
              ElevatedButton(
                child: const Text('OK'),
                onPressed: () async => await resetIntakes(context),
              ),
            ],
          )
        )
      )
    );
  }
}