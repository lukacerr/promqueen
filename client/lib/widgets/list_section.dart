import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:promqueen_client/models/intake.dart';
import 'package:promqueen_client/widgets/intake_item.dart';

class ListSection extends StatelessWidget {
  final List<Intake> data;
  final Function deleteIntake;
  final Function editIntake;
  final Function duplicateIntake;

  const ListSection(
    this.data, 
    this.deleteIntake, 
    this.editIntake, 
    this.duplicateIntake,
    {Key? key}
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    data.sort((a,b) => b.editDate.compareTo(a.editDate));
    return SizedBox(
      height: double.infinity,
      child: FadeInUp(
        // TODO: Reorderable
        child: ListView.builder(
          itemBuilder: (ctx, i) => IntakeItem(
            data[i], 
            deleteIntake, 
            editIntake,
            duplicateIntake,
            key: Key(data[i].id),
          ),
          itemCount: data.length,
        )
      ) 
    );
  }
}
