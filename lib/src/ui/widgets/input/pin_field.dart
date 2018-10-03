import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_paystack/src/ui/my_colors.dart';

class PinField extends StatefulWidget {
  final ValueChanged<String> onSaved;
  final int pinLength;

  PinField({this.onSaved, this.pinLength = 4});

  @override
  State createState() => _PinFieldState();
}

class _PinFieldState extends State<PinField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.0,
      child: new TextField(
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black87,
          fontSize: 25.0,
          letterSpacing: 15.0,
        ),
        autofocus: true,
        inputFormatters: [
          WhitelistingTextInputFormatter.digitsOnly,
          new LengthLimitingTextInputFormatter(widget.pinLength),
        ],
        obscureText: true,
        decoration: new InputDecoration(
          border: OutlineInputBorder(),
          isDense: true,
          hintText: 'PIN',
          hintStyle: const TextStyle(color: Colors.grey, fontSize: 14.0),
          contentPadding: const EdgeInsets.all(10.0),
          enabledBorder: const OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey, width: 0.5)),
          focusedBorder: const OutlineInputBorder(
              borderSide:
                  const BorderSide(color: MyColors.lightBlue, width: 1.0)),
        ),
        onChanged: (String value) {
          if (value.length == widget.pinLength) {
            widget.onSaved(value);
          }
        },
      ),
    );
  }
}