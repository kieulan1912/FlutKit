import 'dart:core';

import 'package:flutkit_feature/features/razorpay/razorpay_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayPaymentController extends FxController {
  late Razorpay _razorpay;

  RazorpayPaymentController() {
    save = false;
    initSetup();
  }

  void initSetup() {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    showSnackBar("Payment is success");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    showSnackBar("Payment is failed");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    showSnackBar("Pay from external wallet");
  }

  void pay() {
    var options = {
      'key': RazorpayUtils.RAZORPAY_KEY,
      'amount': 3999,
      'name': 'FlutKit',
      'currency': 'USD',
      'description': 'This is test payment',
      'prefill': {'contact': '8888888888', 'email': 'flutkit@coderthemes.com'},
      'theme': {'color': "#3C4EC5"},

      'external': {
        'wallets': ['paytm', 'freecharge', 'mobikwik'],
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {}
  }

  void showSnackBar(String content) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(content),
        duration: Duration(milliseconds: 1500),
      ),
    );
  }

  @override
  String getTag() {
    return "stripe_payment_controller";
  }
}
