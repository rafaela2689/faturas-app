import 'package:faturas/shared/model/payment-options/payment_options_model.dart';
import 'package:faturas/payment-options/view/widgets/payment-options.dart';
import 'package:faturas/payment-options/view_model/payment_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class PaymentOptionsScreen extends StatelessWidget {
  const PaymentOptionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ProxyProvider<PaymentOptionsModel, PaymentOptionsViewModel>(
      create: (context) => PaymentOptionsViewModel(
        context.read<PaymentOptionsModel>(),
      ),
      update: (context, paymentOptionsModel, notifier) =>
          PaymentOptionsViewModel(paymentOptionsModel),
      child: PaymentOptionsWidget(),
    );

  }
}
