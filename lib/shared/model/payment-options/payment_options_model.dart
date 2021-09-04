import 'package:faturas/shared/model/payment-options/payment_option.dart';
import 'package:faturas/payment-options/repository/payment_options_rest_service.dart';
import 'package:faturas/shared/setup_dependencies.dart';
import 'package:flutter/cupertino.dart';

class PaymentOptionsModel extends ChangeNotifier {

  PaymentOptionsRestService service = getIt<PaymentOptionsRestService>();

  final double _invoiceValue = 3025.49;

  List<PaymentOption>? _paymentOptions;

  PaymentOption? _selectedPaymentOption;

  Future<List<PaymentOption>> getPaymentOptions() async {
    if (this._paymentOptions == null) {
      final paymentOptions = await service.fetchPaymentOptions();
      this._paymentOptions = paymentOptions;

      if (_selectedPaymentOption == null && this._paymentOptions!.length > 0) {
        setSelectedPaymentOption(paymentOptions!.first);
      }
    }

    return this._paymentOptions!;
  }

  double get invoiceValue => _invoiceValue;

  PaymentOption get selectedPaymentOption => _selectedPaymentOption!;

  setSelectedPaymentOption(PaymentOption paymentOption) {
    this._selectedPaymentOption = paymentOption;

    notifyListeners();
  }
}