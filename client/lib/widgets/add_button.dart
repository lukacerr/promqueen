import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import 'add_or_edit_modal.dart';

class AddButton extends StatelessWidget {
  final Function addIntake;
  const AddButton(this.addIntake, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInRight(
      child: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return AddOrEditModal(addIntake, null);
            },
          );
        },
      )
    );
  }
}
