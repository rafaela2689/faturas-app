import 'package:faturas/credit-card/view/screens/credit_card_details.dart';
import 'package:faturas/home/view/screens/home.dart';
import 'package:faturas/shared/model/credit-card/user_credit_card_model.dart';
import 'package:faturas/shared/model/payment-options/payment_options_model.dart';
import 'package:faturas/payment-options/view/screens/payment_options.dart';
import 'package:faturas/shared/setup_dependencies.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'confirmation/view/screens/confirmation.dart';

void main() {
  registerDependencies();
  runApp(FaturasApp());
}

class FaturasApp extends StatelessWidget {
  const FaturasApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PaymentOptionsModel>(
          create: (_) => PaymentOptionsModel(),
        ),
        ChangeNotifierProvider<UserCreditCardModel>(
          create: (_) => UserCreditCardModel(),
        )
      ],
      child: MaterialApp(
        title: 'Sistema de Faturas',
        initialRoute: '/',
        routes: <String, WidgetBuilder>{
          '/': (BuildContext context) => const HomeScreen(),
          '/payment-options': (BuildContext context) =>
              const PaymentOptionsScreen(),
          '/credit-card-details': (BuildContext context) =>
              const CreditCardDetailsScreen(),
          '/confirmation': (BuildContext context) => const ConfirmationScreen(),
        },
      ),
    );
  }
}
