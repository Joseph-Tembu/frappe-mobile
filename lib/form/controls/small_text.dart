import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:frappe_app/config/palette.dart';
import 'package:frappe_app/model/doctype_response.dart';

import 'base_control.dart';
import 'base_input.dart';


class DoctypeField {
  final String fieldname;
  final String label;
  final int readOnly;

  DoctypeField({
    required this.fieldname,
    required this.label,
    required this.readOnly,
  });
}

mixin Control {
  DoctypeField setMandatory(DoctypeField field) {
    // Implement your logic to set the field as mandatory here
    // For example, you can check some conditions and return a modified field.
    // For now, we'll just return the original field.
    return field;
  }
}

mixin ControlInput {
  // Define the mixin properties and methods here
}

class SmallText extends StatelessWidget with Control, ControlInput {
  final DoctypeField doctypeField;
  final void Function(String?)? onChanged;
  final Key? key;
  final Map? doc;

  const SmallText({
    required this.doctypeField,
    this.onChanged,
    this.key,
    this.doc,
  });

  @override
  Widget build(BuildContext context) {
    List<String? Function(dynamic)> validators = [];

    var f = setMandatory(doctypeField);

    if (f != null) {
      validators.add(
            (value) {
          if (value == null || value.isEmpty) {
            return 'This field is mandatory'; // You can customize the error message.
          }
          return null;
        },
      );
    }

    return FormBuilderTextField(
      key: key,
      onChanged: onChanged,
      readOnly: doctypeField.readOnly == 1 ? true : false,
      initialValue: doc != null ? doc![doctypeField.fieldname] : null,
      name: doctypeField.fieldname,
      decoration: InputDecoration(
        labelText: doctypeField.label,
      ),
      validator: FormBuilderValidators.compose(validators),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      body: Center(
        child: SmallText(
          doctypeField: DoctypeField(
            fieldname: 'exampleField',
            label: 'Example Field',
            readOnly: 0,
          ),
        ),
      ),
    ),
  ));
}
