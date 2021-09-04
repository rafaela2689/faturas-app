import 'package:faturas/shared/model/payment-options/payment_option.dart';
import 'package:faturas/payment-options/view_model/payment_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PaymentOptionTile extends StatelessWidget {

  final nf = NumberFormat.currency(locale: "pt_BR", symbol: "R\$", decimalDigits: 2);

  final PaymentOption paymentOption;

  PaymentOptionTile(this.paymentOption);

  String formattedValue() {
    return '${paymentOption.number} x ${nf.format(paymentOption.value)}';
  }

  @override
  Widget build(BuildContext context) {
    var paymentOptionsViewModel = context.read<PaymentOptionsViewModel>();
    final selectedPaymentOption = paymentOptionsViewModel.paymentOptionsModel.selectedPaymentOption;

    return Card(
      child: RadioListTile<PaymentOption>(
        key: Key(paymentOption.number.toString()),
        title: Text(formattedValue()),
        onChanged: (value) {
          if (value != null) {
            paymentOptionsViewModel.setSelectedPaymentOption(value);
          }
        },
        groupValue: selectedPaymentOption,
        value: paymentOption,
        secondary: Text("${nf.format(paymentOption.total)}"),
        selected: selectedPaymentOption.number == paymentOption.number,
      ),
    );
  }

}