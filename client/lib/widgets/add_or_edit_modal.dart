import 'package:flutter/material.dart';

import '../models/intake.dart';

import 'string_input.dart';
import 'integer_input.dart';

class AddOrEditModal extends StatefulWidget {
  final Function addOrEditIntake;
  final Intake? intakeData;
  
  const AddOrEditModal( 
    this.addOrEditIntake,
    this.intakeData,
    {Key? key}
  ) : super(key: key);

  @override
  State<AddOrEditModal> createState() => _AddOrEditModalState();
}

class _AddOrEditModalState extends State<AddOrEditModal> {
  late String _name;
  late int _calories;
  late int _protein;
  late int _carbs;
  late int _fats;
  late int _sodium;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final isForAdd = widget.intakeData == null;

    if (isForAdd) {
        _name = '-';
        _calories = 0;
        _protein = 0;
        _carbs = 0;
        _fats = 0;
        _sodium = 0;
    } else {
      _name = widget.intakeData!.name;
      _calories = widget.intakeData!.calories;
      _protein = widget.intakeData!.protein;
      _carbs = widget.intakeData!.carbs;
      _fats = widget.intakeData!.fats;
      _sodium = widget.intakeData!.sodium;
    }

    return Column(
      children: [
        Flexible(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  StringInput(
                    'Name', isForAdd ? null : _name, true,
                    (v) => _name = v!.isEmpty ? _name : v
                  ),
                  IntegerInput(
                    'Calories (kcal)', _calories, true,
                    (v) => _calories = v!.isEmpty ? _calories : int.parse(v)
                  ),
                  IntegerInput(
                    'Protein (grams)', _protein, false,
                    (v) => _protein = v!.isEmpty ? _protein : int.parse(v)
                  ),
                  IntegerInput(
                    'Carbohydrates (grams)', _carbs, false,
                    (v) => _carbs = v!.isEmpty ? _carbs : int.parse(v)
                  ),
                  IntegerInput(
                    'Fats (grams)', _fats, false,
                    (v) => _fats = v!.isEmpty ? _fats : int.parse(v)
                  ),
                  IntegerInput(
                    'Sodium (miligrams)', _sodium, false,
                    (v) => _sodium = v!.isEmpty ? _sodium : int.parse(v)
                  ),
                ]
              )
            ),
          )
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Wrap(
            spacing: 100,
            children: [
              TextButton(
                  onPressed: () => Navigator.pop(context, 'CANCEL'),
                  child: const Text('Cancel')),
              ElevatedButton(
                child: Text(isForAdd ? 'Add' : 'Edit'),
                onPressed: () {
                  if (!(_formKey.currentState?.validate() ?? false)) return;
                  _formKey.currentState?.save();
                  
                  if (isForAdd) {
                    widget.addOrEditIntake(
                      _name,
                      _calories,
                      _protein,
                      _carbs,
                      _fats,
                      _sodium
                    );
                  } else {
                    widget.intakeData!.name = _name;
                    widget.intakeData!.calories = _calories;
                    widget.intakeData!.protein = _protein;
                    widget.intakeData!.carbs = _carbs;
                    widget.intakeData!.fats = _fats;
                    widget.intakeData!.sodium = _sodium;
                    widget.addOrEditIntake(widget.intakeData!);
                  }

                  Navigator.pop(context, 'INTAKE_SAVED');
                },
              )
            ],
          ),
        )
      ],
    );
  }
}
