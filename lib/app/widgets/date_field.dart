import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateField extends StatelessWidget {
  const DateField({
    super.key,
    required this.initValue,
    required this.decoration,
    required this.labelText,
    required this.onChanged,
  });

  final String initValue;
  final bool decoration;
  final String labelText;
  final void Function(String date) onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: UniqueKey(),
      initialValue: initValue,
      decoration: decoration
          ? InputDecoration(
              labelText: labelText,
              labelStyle: const TextStyle(color: Colors.green),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.green),
              ),
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
            )
          : null,
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1980),
          lastDate: DateTime(2101),
        );

        if (pickedDate != null) {
          String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
          onChanged(formattedDate);
        }
      },
    );
  }
}
