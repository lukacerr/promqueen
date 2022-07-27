import 'package:flutter/material.dart';

class StringInput extends StatelessWidget {
  final String label;
  final String? initialValue;
  final bool isRequired;
  final Function(String?)? onSaved;
  
  const StringInput(
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
        initialValue: initialValue,
        validator: isRequired 
          ? (v) => v!.isEmpty ? "Required" : null 
          : null,
        onSaved: onSaved
      ),
    );
  }
}
