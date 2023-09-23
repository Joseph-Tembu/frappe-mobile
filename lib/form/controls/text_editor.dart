import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:frappe_app/widgets/form_builder_text_editor.dart';

import '../../model/doctype_response.dart';


import 'package:flutter/material.dart';

// Define the DoctypeField class for illustration purposes
class DoctypeField {
  final String fieldname;
  final bool isMandatory;

  DoctypeField({required this.fieldname, this.isMandatory = false});
}

mixin Control {
  // Define the mixin properties and methods here
}

mixin ControlInput {
  // Define the mixin properties and methods here
}

class TextEditor extends StatelessWidget with Control, ControlInput {
  final DoctypeField doctypeField;
  final Key? key;
  final Map? doc;
  final Color? color;
  final bool fullHeight;

  const TextEditor({
    required this.doctypeField,
    this.key,
    this.doc,
    this.color,
    this.fullHeight = false,
  });

  @override
  Widget build(BuildContext context) {
    List<String? Function(dynamic)> validators = [];

    if (doctypeField.isMandatory) {
      validators.add((value) {
        if (value == null || value.toString().isEmpty) {
          return 'This field is mandatory';
        }
        return null;
      });
    }

    return FormBuilderTextEditor(
      key: key,
      fullHeight: fullHeight,
      initialValue: doc != null ? doc![doctypeField.fieldname] : null,
      name: doctypeField.fieldname,
      context: context,
      color: color,
      validator: FormBuilderValidators.compose(validators),
    );
  }
}
