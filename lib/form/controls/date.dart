import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:frappe_app/model/offline_storage.dart';
import 'package:frappe_app/model/system_settings_response.dart';
import 'package:frappe_app/utils/constants.dart';
import 'package:intl/intl.dart';
import '../../config/palette.dart';
import '../../model/doctype_response.dart';
import '../../utils/help.dart';


import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
class DoctypeField {
  final String fieldname;
  final String label;
  DoctypeField({required this.fieldname, required this.label});

  // Define the setMandatory method
  void setMandatory(BuildContext context) {
    // Implement the logic to set the field as mandatory here
    // For example, you can add a validator function to enforce mandatory validation
  }
}

mixin Control {
  // Define the mixin properties and methods here
}

mixin ControlInput {
  // Define the mixin properties and methods here
}

class Date extends StatelessWidget with Control, ControlInput {
  final DoctypeField doctypeField;
  final Key? key;
  final Map? doc;

  const Date({
    this.key,
    required this.doctypeField,
    this.doc,
  });

  @override
  Widget build(BuildContext context) {
    List<String? Function(dynamic)> validators = [];

    // Call the setMandatory method on doctypeField
    doctypeField.setMandatory(context);

    var systemSettings = jsonDecode(
      jsonEncode(
        OfflineStorage.getItem("systemSettings")["data"],
      ),
    );

    var dateFormat = systemSettings != null
        ? SystemSettingsResponse.fromJson(
      systemSettings,
    ).message.defaults.dateFormat
        : "dd-MM-yyyy"; // Changed to use uppercase 'MM' for month

    return FormBuilderDateTimePicker(
      key: key,
      inputType: InputType.date,
      valueTransformer: (val) {
        return val?.toIso8601String();
      },
      format: DateFormat(
        Constants.frappeFlutterDateFormatMapping[dateFormat],
      ),
      initialValue:
      doc != null ? parseDate(doc![doctypeField.fieldname]) : null,
      keyboardType: TextInputType.number,
      name: doctypeField.fieldname,
      decoration: Palette.formFieldDecoration(
        label: doctypeField.label,
      ),
      validator: FormBuilderValidators.compose(validators),
    );
  }
}

// Define the SystemSettingsResponse and Constants classes as needed
