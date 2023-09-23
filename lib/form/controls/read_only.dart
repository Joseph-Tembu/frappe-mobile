import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class DoctypeField {
  final String fieldname;
  final String label;
  final bool mandatory;

  DoctypeField({
    required this.fieldname,
    required this.label,
    this.mandatory = false,
  });
}

class Palette {
  static InputDecoration formFieldDecoration({required String label}) {
    return InputDecoration(labelText: label);
  }
}

mixin Control {
  // Define the mixin properties and methods here

  Function(BuildContext) setMandatory(DoctypeField doctypeField) {
    if (doctypeField.mandatory) {
      return (BuildContext context) {
        return FormBuilderValidators.required;
      };
    }
    return (BuildContext context) => null;
  }
}

mixin ControlInput {
  // Define the mixin properties and methods here
}

class ReadOnly extends StatelessWidget with Control, ControlInput {
  final DoctypeField doctypeField;
  final Key? key;
  final Map? doc;

  const ReadOnly({
    required this.doctypeField,
    this.key,
    this.doc,
  });

  @override
  Widget build(BuildContext context) {
    List<String? Function(dynamic)> validators = [];

    var f = setMandatory(doctypeField);

    if (f != null) {
      validators.add(f(context));
    }

    return FormBuilderTextField(
      key: key,
      readOnly: true,
      initialValue: doc != null ? doc![doctypeField.fieldname] : null,
      name: doctypeField.fieldname,
      decoration: Palette.formFieldDecoration(
        label: doctypeField.label,
      ),
      validator: FormBuilderValidators.compose(validators),
    );
  }
}
