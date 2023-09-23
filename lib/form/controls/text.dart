import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:frappe_app/config/palette.dart';
import 'package:frappe_app/model/doctype_response.dart';


import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class DoctypeField {
  final String fieldname;
  final String label;

  DoctypeField({required this.fieldname, required this.label});
}

mixin Control {
  // Define the mixin properties and methods here
}

mixin ControlInput {
  // Define the mixin properties and methods here
}

class ControlText extends StatelessWidget with Control, ControlInput {
  final DoctypeField doctypeField;
  final void Function(String?)? onChanged;
  final Key? key;
  final Map? doc;

  ControlText({
    required this.doctypeField,
    this.onChanged,
    this.key,
    this.doc,
  });

  // Define the setMandatory method
  String? Function(BuildContext)? setMandatory(DoctypeField field) {
    if (field.label.isEmpty) {
      return (BuildContext context) => 'Field ${field.fieldname} is mandatory';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    List<String? Function(dynamic)> validators = [];

    var f = setMandatory(doctypeField);

    if (f != null) {
      validators.add(
        f(context) as String? Function(dynamic p1),
      );
    }

    return FormBuilderTextField(
      key: key,
      onChanged: onChanged,
      initialValue: doc != null ? doc![doctypeField.fieldname] : null,
      name: doctypeField.fieldname,
      decoration: InputDecoration(
        labelText: doctypeField.label,
      ),
      validator: FormBuilderValidators.compose(validators),
    );
  }
}
