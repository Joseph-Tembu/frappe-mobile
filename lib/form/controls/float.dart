import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:frappe_app/model/doctype_response.dart';

import '../../config/palette.dart';

import 'base_control.dart';
import 'base_input.dart';


import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

// Define the Control mixin
mixin Control {
  String? setMandatory(DoctypeField field) {
    // Implement your logic for setting mandatory here
    // For example, if field is mandatory, return an error message; otherwise, return null
    if (field.isMandatory) {
      return 'This field is mandatory';
    } else {
      return null;
    }
  }
}

// Define the ControlInput mixin
mixin ControlInput {
  // Define the mixin properties and methods here
}

class DoctypeField {
  final String fieldname;
  final String label;
  final bool isMandatory;

  DoctypeField({
    required this.fieldname,
    required this.label,
    this.isMandatory = false,
  });
}

class Float extends StatelessWidget with Control, ControlInput {
  final DoctypeField doctypeField;
  final Key? key;
  final Map? doc;

  const Float({
    required this.doctypeField,
    this.key,
    this.doc,
  });

  @override
  Widget build(BuildContext context) {
    List<String? Function(dynamic?)> validators = [];

    var f = setMandatory(doctypeField);

    if (f != null) {
      validators.add(
            (value) {
          if (value == null || value.toString().isEmpty) {
            return f;
          }
          return null;
        },
      );
    }

    return FormBuilderTextField(
      key: key,
      initialValue: doc != null
          ? doc![doctypeField.fieldname] != null
          ? doc![doctypeField.fieldname].toString()
          : null
          : null,
      keyboardType: TextInputType.number,
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
        appBar: AppBar(
          title: Text('Flutter Example'),
        ),
        body: Center(
          child: Float(
            doctypeField: DoctypeField(
              fieldname: 'exampleField',
              label: 'Example Field',
              isMandatory: true,
            ),
          ),
        ),
      ),
    ),
  );
}
