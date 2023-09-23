import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';import 'package:frappe_app/config/palette.dart';

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

mixin ControlMixin {
  // Define the setMandatory method here
  String? setMandatory(DoctypeField field) {
    // Implement your logic here to determine if the field is mandatory
    // For example, you can check a condition and return an error message if it's mandatory.
    if (field.readOnly == 1) {
      return 'This field is mandatory';
    }
    return null;
  }
}

mixin ControlInputMixin {
  // Add the methods and properties of the ControlInput class here
}

class Data extends StatelessWidget with ControlMixin, ControlInputMixin {
  final DoctypeField doctypeField;
  final Widget? prefixIcon;
  final Color? color;

  final Key? key;
  final Map? doc;

  Data({
    required this.doctypeField,
    this.key,
    this.doc,
    this.color,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    List<String? Function(dynamic)> validators = [];

    // Use the setMandatory method defined in the mixin
    var errorMessage = setMandatory(doctypeField);

    if (errorMessage != null) {
      validators.add((value) {
        if (value == null || value.isEmpty) {
          return errorMessage;
        }
        return null;
      });
    }

    return FormBuilderTextField(
      key: key,
      readOnly: doctypeField.readOnly == 1,
      initialValue: doc != null ? doc![doctypeField.fieldname] : null,
      name: doctypeField.fieldname,
      decoration: InputDecoration(
        labelText: doctypeField.label,
        fillColor: color,
        prefixIcon: prefixIcon,
      ),
      validator: FormBuilderValidators.compose(validators),
    );
  }
}
