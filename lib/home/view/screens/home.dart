import 'package:faturas/home/view/widgets/last_invoice_info.dart';
import 'package:faturas/home/view/widgets/payment_boleto_info.dart';
import 'package:faturas/home/view/widgets/payment_credit_card_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sistema de Faturas'),
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(15.0),
            child: Card(
              child: Column(
                children: <Widget>[
                  LastInvoiceInfo(),
                  Container(
                    margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                    child: Divider(
                      height: 5,
                      thickness: 1,
                      indent: 20,
                      endIndent: 20,
                    ),
                  ),
                  PaymentBoleto(),
                  PaymentCreditCard(),
                ],
              ),
            ),
          ),
        ),
      );
  }

}