import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_paystack/src/common/my_strings.dart';
import 'package:flutter_paystack/src/widgets/input/base_field.dart';

class MobileMoneyField extends BaseTextField {
  MobileMoneyField({required FormFieldSetter<String> onSaved})
      : super(
          labelText: 'Mobile Money Number',
          validator: _validate,
          onSaved: onSaved,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            new LengthLimitingTextInputFormatter(9),
          ],
        );

  static String? _validate(String? value) {
    if (value == null || value.trim().isEmpty)
      return Strings.invalidMobileMoneyNumber;
    return value.length == 9 ? null : Strings.invalidMobileMoneyNumber;
  }
}
