import 'package:flutter/material.dart';
import 'package:flutter_chips_input/flutter_chips_input.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

/// A field that takes a list of `Chip`s as input and suggests more options
/// while typing
class FormBuilderChipsInput<T> extends FormBuilderField<List<T>> {
  //TODO: Add documentation
  final ChipsInputSuggestions<T> findSuggestions;

  // final ValueChanged<List<T>> onChanged;
  final ChipsBuilder<T> chipBuilder;
  final ChipsBuilder<T> suggestionBuilder;
  final int maxChips;
  final TextStyle textStyle;
  final String actionLabel;
  final bool autocorrect;
  final TextInputAction inputAction;
  final TextInputType inputType;
  final Brightness keyboardAppearance;
  final bool obscureText;
  final double suggestionsBoxMaxHeight;
  final TextCapitalization textCapitalization;
  final bool allowChipEditing;
  final bool autofocus;
  final TextOverflow textOverflow;

  /// Creates a field that takes a list of `Chip`s as input and suggests more options
  /// while typing
  FormBuilderChipsInput({
    required Key key,
    //From Super
    required String name,
    required FormFieldValidator<List<T>> validator,
    List<T> initialValue = const [],
    InputDecoration decoration = const InputDecoration(),
    required ValueChanged<List<T>> onChanged,
    required ValueTransformer<List<T>> valueTransformer,
    bool enabled = true,
    required FormFieldSetter<List<T>> onSaved,
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
    required VoidCallback onReset,
    required FocusNode focusNode,
    required this.chipBuilder,
    required this.suggestionBuilder,
    required this.findSuggestions,
    required this.maxChips,
    required this.textStyle,
    required this.actionLabel,
    required this.suggestionsBoxMaxHeight,
    this.autocorrect = false,
    this.inputAction = TextInputAction.done,
    this.inputType = TextInputType.text,
    this.keyboardAppearance = Brightness.light,
    this.obscureText = false,
    this.textCapitalization = TextCapitalization.none,
    this.allowChipEditing = false,
    this.autofocus = false,
    required this.textOverflow,
  }) :
        super(
        key: key,
        initialValue: initialValue,
        name: name,
        validator: validator,
        onChanged: (List<T>? newValue) {
          // Your onChanged logic here
          // newValue will be a nullable list of values
          // Handle it accordingly
          if (newValue != null) {
            // Do something with newValue
          }
          // ...
        },
        autovalidateMode: autovalidateMode,
        onSaved: onSaved,
        enabled: enabled,
        onReset: onReset,
        focusNode: focusNode,


        // super(
        //   key: key,
        //   initialValue: initialValue,
        //   name: name,
        //   validator: validator,
        //   // valueTransformer: valueTransformer,
        //   onChanged: onChanged,
        //   autovalidateMode: autovalidateMode,
        //   onSaved: onSaved,
        //   enabled: enabled,
        //   onReset: onReset,
        //   // decoration: decoration,
        //   focusNode: focusNode,



          builder: (FormFieldState<List<T>> field) {
            final state = field as _FormBuilderChipsInputState<T>;

            return ChipsInput<T>(
              initialValue: field.value!,
              enabled: state.enabled,
              // decoration: state.decoration,
              findSuggestions: findSuggestions,
              onChanged: (data) {
                field.didChange(data);
              },






              maxChips: maxChips,
              chipBuilder: chipBuilder,
              suggestionBuilder: suggestionBuilder,
              textStyle: textStyle,
              actionLabel: actionLabel,
              autocorrect: autocorrect,
              inputAction: inputAction,
              inputType: inputType,
              keyboardAppearance: keyboardAppearance,
              obscureText: obscureText,
              suggestionsBoxMaxHeight: suggestionsBoxMaxHeight,
              textCapitalization: textCapitalization,
              allowChipEditing: allowChipEditing,
              autofocus: autofocus,
              focusNode: state.effectiveFocusNode,
              textOverflow: textOverflow,
            );
          },
        );

  @override
  _FormBuilderChipsInputState<T> createState() =>
      _FormBuilderChipsInputState<T>();
}

class _FormBuilderChipsInputState<T>
    extends FormBuilderFieldState<FormBuilderChipsInput<T>, List<T>> {}
