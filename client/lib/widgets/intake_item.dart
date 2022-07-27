import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:promqueen_client/models/intake.dart';

import 'add_or_edit_modal.dart';

class IntakeItem extends StatelessWidget {
  final Intake data;
  final Function deleteIntake;
  final Function editIntake;
  final Function duplicateIntake;

  const IntakeItem(
    this.data, 
    this.deleteIntake, 
    this.editIntake, 
    this.duplicateIntake,
    {Key? key}
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(data.name),
          content: Text(data.jsonify()), // TODO: Data modal
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.pop(context, 'CANCEL'),
            ),
            ElevatedButton(
              child: const Text('Duplicate'),
              onPressed: () => duplicateIntake(data, context),
            ),
          ],
        )
      ),
      behavior: HitTestBehavior.translucent,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Wrap(
                direction: Axis.vertical,
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 2.5,
                children: [
                  Text(
                    data.calories.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    )
                  ), 
                  const Text(
                    "kcal",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 14
                    )
                  ), 
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Wrap(
                    direction: Axis.vertical,
                    spacing: 2.5,
                    children: [
                      Text(
                        data.name,
                        style: const TextStyle(
                          overflow: TextOverflow.fade,
                          fontSize: 16
                        )
                      ),
                      Opacity(
                        opacity: 0.75, 
                        child: Text(
                          "P: ${data.protein}g / C: ${data.carbs}g / F: ${data.fats}g",
                          style: const TextStyle(
                            fontSize: 14,
                            overflow: TextOverflow.fade,
                          ),
                        )
                      ),
                      Opacity(
                        opacity: 0.5, 
                        child: Text(
                          "Edited: ${DateFormat('kk:mm (MM/dd/yyyy)').format(data.editDate.toLocal())}",
                          style: const TextStyle(
                            fontStyle: FontStyle.italic,
                            fontSize: 12,
                            overflow: TextOverflow.fade,
                          ),
                        )
                      )
                    ],
                  )
                ),
              ),
              const Spacer(),
              Wrap(
                spacing: 10,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  /*
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(Icons.copy),
                    onPressed: () {},
                  ),
                  */
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      showModalBottomSheet<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return AddOrEditModal(editIntake, data);
                        },
                      );
                    },
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    icon: const Icon(Icons.delete),
                    onPressed: () async => await deleteIntake(data),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
