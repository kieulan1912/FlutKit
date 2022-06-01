import 'package:flutter/material.dart';
import 'package:flutx/extensions/string_extension.dart';

typedef FxFieldValidator = String? Function(String? value);

abstract class FxFormValidator {
  String? validate(String? value);
}

mixin FxFormDataMixin {
  Map<String, dynamic> errors = {};
  GlobalKey<FormState> formKey = GlobalKey();

  FxFieldValidator createValidation(String name,
      {bool required = false, List<FxFormValidator> validators = const []}) {
    return (String? value) {
      String? error = getError(name);
      if (error != null) {
        return error;
      }

      if (required && (value == null || value.isEmpty)) {
        return name.capitalize + " is required";
      }
      for (FxFormValidator validator in validators) {
        String? validationError = validator.validate(value);
        if (validationError != null) {
          return validationError;
        }
      }
      return null;
    };
  }

  String? getError(String name) {
    if (errors.containsKey(name)) {
      dynamic error = errors[name];
      if (error is List) {
        return error[0];
      } else {
        return error.toString();
      }
    }
    return null;
  }

  bool validateForm({bool clear = false}) {
    if (clear) {
      errors.clear();
    }
    return formKey.currentState?.validate() ?? false;
  }

  bool validateFormWithErrors(Map<String, dynamic> errors) {
    this.errors = errors;
    return validateForm();
  }
}
