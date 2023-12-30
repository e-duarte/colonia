import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateField extends StatelessWidget {
  const DateField({required this.initValue, required this.handle, super.key});

  final String initValue;
  final void Function(String date) handle;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: UniqueKey(),
      initialValue: initValue,
      // onChanged: (value) => dataNascimento = value,
      // validator: validation,
      // maxLength: 10,
      decoration: const InputDecoration(
        labelText: 'Data do pagamento',
        labelStyle: TextStyle(color: Colors.green),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        ),
        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
      ),
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
          handle(formattedDate);
        }
      },
    );
  }
}
