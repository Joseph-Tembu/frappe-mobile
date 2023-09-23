import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';


mixin Control {
  // Define methods and properties for the Control mixin
}

mixin ControlInput {
  // Define methods and properties for the ControlInput mixin
}

class Currency extends StatelessWidget with Control, ControlInput {
  final DoctypeField doctypeField;
  final Key? key;
  final Map? doc;
  const Currency({
    required this.doctypeField,
    this.key,
    this.doc,
  });

  String? Function(dynamic)? setMandatory(DoctypeField field) {
    // Add your logic here to determine if the field should be mandatory
    if (field.isMandatory) {
      return (value) {
        if (value == null || value.toString().isEmpty) {
          return 'This field is mandatory.';
        }
        return null;
      };
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    List<String? Function(dynamic)> validators = [];
    var f = setMandatory(doctypeField);
    if (f != null) {
      validators.add(f);
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
  static InputDecoration formFieldDecoration({String? label}) {
    return InputDecoration(
      labelText: label,
    );
  }
}
