import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';


class DoctypeField {
  final String fieldname;
  final String label;
  final int mandatory;

  DoctypeField({
    required this.fieldname,
    required this.label,
    required this.mandatory,
  });
}

mixin Control {
  String? setMandatory(DoctypeField field) {
    if (field.mandatory == 1) {
      return 'This field is mandatory'; // You can customize the error message.
    }
    return null;
  }
}

mixin ControlInput {
  // Define the mixin properties and methods here
}

class DatetimeField extends StatelessWidget with Control, ControlInput {
  final DoctypeField doctypeField;
  final Key? key;
  final Map? doc;

  const DatetimeField({
    required this.doctypeField,
    this.key,
    this.doc,
  });

  @override
  Widget build(BuildContext context) {
    DateTime? value;

    if (doc != null) {
      if (doc![doctypeField.fieldname] == "Now") {
        value = DateTime.now();
      } else {
        // Replace this with your actual date parsing logic
        // value = parseDate(doc![doctypeField.fieldname]);
      }
    }

    List<String? Function(dynamic)> validators = [];

    var f = setMandatory(doctypeField);

    if (f != null) {
      validators.add(
            (val) {
          if (val == null || val.toString().isEmpty) {
            return f;
          }
          return null;
        },
      );
    }

    return FormBuilderDateTimePicker(
      key: key,
      valueTransformer: (val) {
        return val?.toIso8601String();
      },
      resetIcon: Icon(Icons.close),
      initialValue: value,
      name: doctypeField.fieldname,
      decoration: InputDecoration(
        labelText: doctypeField.label,
      ),
      validator: FormBuilderValidators.compose(validators),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: DatetimeField(
            doctypeField: DoctypeField(
              fieldname: 'date_field',
              label: 'Date Field',
              mandatory: 1, // Set 1 for mandatory, 0 for optional
            ),
          ),
        ),
      ),
    ),
  );
}
