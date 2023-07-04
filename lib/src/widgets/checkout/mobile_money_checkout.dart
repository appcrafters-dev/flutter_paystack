import 'package:flutter/material.dart';
import 'package:flutter_paystack/src/api/service/contracts/banks_service_contract.dart';
import 'package:flutter_paystack/src/common/paystack.dart';
import 'package:flutter_paystack/src/common/utils.dart';
import 'package:flutter_paystack/src/models/charge.dart';
import 'package:flutter_paystack/src/models/checkout_response.dart';
import 'package:flutter_paystack/src/widgets/buttons.dart';
import 'package:flutter_paystack/src/widgets/checkout/base_checkout.dart';
import 'package:flutter_paystack/src/widgets/checkout/checkout_widget.dart';
import 'package:flutter_paystack/src/widgets/input/mobile_money_input.dart';

class MobileMoneyCheckout extends StatefulWidget {
  final Charge charge;
  final OnResponse<CheckoutResponse> onResponse;
  final ValueChanged<bool> onProcessingChange;
  final BankServiceContract service;
  final String publicKey;

  MobileMoneyCheckout({
    required this.charge,
    required this.onResponse,
    required this.onProcessingChange,
    required this.service,
    required this.publicKey,
  });

  @override
  _MobileMoneyCheckoutState createState() =>
      _MobileMoneyCheckoutState(charge, onResponse);
}

class _MobileMoneyCheckoutState
    extends BaseCheckoutMethodState<MobileMoneyCheckout> {
  late Charge _charge;
  _MobileMoneyCheckoutState(
      this._charge, OnResponse<CheckoutResponse> onResponse)
      : super(onResponse, CheckoutMethod.mobileMoney);

  var _formKey = new GlobalKey<FormState>();
  var _autoValidate = AutovalidateMode.disabled;

  var _loading = false;

  @override
  void initState() {
    _charge = widget.charge;
    super.initState();
  }

  @override
  Widget buildAnimatedChild() {
    return Container(child: _getCompleteUI());
  }

  Widget _getCompleteUI() {
    return Container(
      child: Form(
        autovalidateMode: _autoValidate,
        key: _formKey,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Icon(
              Icons.mobile_friendly_outlined,
              size: 35.0,
            ),
            Text(
              'Enter your mobile money number to \nbegin this payment',
              maxLines: 2,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14.0,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Column(
              // mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 15.0,
                ),
                MobileMoneyField(onSaved: (String? value) {}),
                SizedBox(
                  height: 20.0,
                ),
                AccentButton(
                    onPressed: _validateInputs,
                    showProgress: _loading,
                    text: _charge.amount.isNegative
                        ? ''
                        : 'PAY ' + (Utils.formatAmount(_charge.amount))),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _validateInputs() {
    FocusScope.of(context).requestFocus(new FocusNode());
    final FormState form = _formKey.currentState!;
    if (form.validate()) {
      form.save();
      widget.onProcessingChange(true);
      setState(() => _loading = true);
      _chargeAccount();
    } else {
      setState(() => _autoValidate = AutovalidateMode.always);
    }
  }

  void _chargeAccount() async {
    //TODO: add changes related mobilemoneymanager
    // final response = await BankTransactionManager(
    //         charge: widget.charge,
    //         service: widget.service,
    //         context: context,
    //         publicKey: widget.publicKey)
    //     .chargeBank();

    // if (!mounted) return;

    // setState(() => _loading = false);
    // onResponse(response);
  }
}
