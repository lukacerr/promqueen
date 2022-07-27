import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IntegerInput extends StatelessWidget {
  final String label;
  final int initialValue;
  final bool isRequired;
  final Function(String?)? onSaved;
  
  const IntegerInput(
    this.label,
    this.initialValue, 
    this.isRequired,
    this.onSaved,
    {Key? key}
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        decoration: InputDecoration(labelText: label),
        keyboardType: TextInputType.number,
        initialValue: initialValue.toString(),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        validator: isRequired 
          ? (v) => v!.isEmpty ? "Required" : null 
          : null,
        onSaved: onSaved
      ),
    );
  }
}
