import 'package:faturas/confirmation/view/widgets/confirmation.dart';
import 'package:faturas/confirmation/view_model/confirmation.dart';
import 'package:faturas/shared/model/credit-card/user_credit_card_model.dart';
import 'package:faturas/shared/model/payment-options/payment_options_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConfirmationScreen extends StatelessWidget {
  const ConfirmationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ProxyProvider2<PaymentOptionsModel, UserCreditCardModel, ConfirmationViewModel>(
      create: (context) => ConfirmationViewModel(
        context.read<PaymentOptionsModel>(), context.read<UserCreditCardModel>(),
      ),
      update: (context, paymentOptionsModel, creditCardModel, notifier) => ConfirmationViewModel(
          paymentOptionsModel, creditCardModel
      ),
      child: ConfirmationWidget(),
    );
  }
}
