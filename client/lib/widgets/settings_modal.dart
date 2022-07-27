import 'package:flutter/material.dart';
import 'package:promqueen_client/helpers/config_helper.dart';
import 'package:promqueen_client/widgets/integer_input.dart';

class SettingsModal extends StatefulWidget {
  final Function refreshChart;
  const SettingsModal(this.refreshChart, {Key? key}) : super(key: key);

  @override
  State<SettingsModal> createState() => _SettingsModalState();
}

class _SettingsModalState extends State<SettingsModal> {
  int _calorieIntake = ConfigHelper.calorieIntake;
  int _proteinIntake = ConfigHelper.proteinIntake;
  int _carbsIntake = ConfigHelper.carbsIntake;
  int _fatsIntake = ConfigHelper.fatsIntake;
  int _sodiumIntake = ConfigHelper.sodiumIntake;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /*
        const Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            'Edit configuration',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        */
        Flexible(
            child: Form(
          key: _formKey,
          child: SingleChildScrollView(
              child: Column(children: [
            IntegerInput(
                'Calorie intake (kcal)',
                _calorieIntake,
                true,
                (v) => _calorieIntake =
                    v!.isEmpty ? _calorieIntake : int.parse(v)),
            IntegerInput(
                'Protein intake (grams)',
                _proteinIntake,
                true,
                (v) => _proteinIntake =
                    v!.isEmpty ? _proteinIntake : int.parse(v)),
            IntegerInput('Carbohydrates intake (grams)', _carbsIntake, true,
                (v) => _carbsIntake = v!.isEmpty ? _carbsIntake : int.parse(v)),
            IntegerInput('Fats intake (grams)', _fatsIntake, true,
                (v) => _fatsIntake = v!.isEmpty ? _fatsIntake : int.parse(v)),
            IntegerInput(
                'Sodium intake (miligrams)',
                _sodiumIntake,
                true,
                (v) =>
                    _sodiumIntake = v!.isEmpty ? _sodiumIntake : int.parse(v)),
          ])),
        )),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Wrap(
            spacing: 100,
            children: [
              TextButton(
                  onPressed: () => Navigator.pop(context, 'CANCEL'),
                  child: const Text('Cancel')),
              ElevatedButton(
                child: const Text('Save'),
                onPressed: () {
                  if (!(_formKey.currentState?.validate() ?? false)) return;
                  _formKey.currentState?.save();
                  ConfigHelper.editConfig(_calorieIntake, _proteinIntake,
                      _carbsIntake, _fatsIntake, _sodiumIntake);

                  widget.refreshChart();
                  Navigator.pop(context, 'CONFIG_SAVED');
                },
              )
            ],
          ),
        )
      ],
    );
  }
}
