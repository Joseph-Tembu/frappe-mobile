import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:frappe_app/model/doctype_response.dart';

import '../../config/palette.dart';


mixin Control {
  // Define the mixin properties and methods here
}

mixin ControlInput {
  // Define the mixin properties and methods here
}

class Int extends StatelessWidget with Control, ControlInput {
  final DoctypeField doctypeField;
  final void Function(String?)? onChanged;
  final Key? key;
  final Map? doc;

  const Int({
    required this.doctypeField,
    this.onChanged,
    this.key,
    this.doc,
  });

  // Define the setMandatory method here
  String? setMandatory(DoctypeField field) {
    // Implement your logic here to determine if the field is mandatory
    // For example:
    if (field.isMandatory) {
      return 'This field is mandatory';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    List<String? Function(dynamic)> validators = [];

    var f = setMandatory(doctypeField);

    if (f != null) {
      validators.add(
            (value) {
          if (value == null || value.isEmpty) {
            return f;
          }
          return null;
        },
      );
    }

    return FormBuilderTextField(
      key: key,
      onChanged: onChanged,
      initialValue: doc != null
          ? doc![doctypeField.fieldname] != null
          ? doc![doctypeField.fieldname].toString()
          : null
          : null,
      keyboardType: TextInputType.number,
      name: doctypeField.fieldname,
      decoration: Palette.formFieldDecoration(
        label: doctypeField.label,
      ),
      validator: FormBuilderValidators.compose(validators),
    );
  }
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

class Palette {
  static InputDecoration formFieldDecoration({required String label}) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(),
    );
  }
}
