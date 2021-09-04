import 'dart:async';

import 'package:faturas/confirmation/view/widgets/loading_dialog.dart';
import 'package:faturas/confirmation/view_model/confirmation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'dialog_error.dart';
import 'dialog_success.dart';

const _paymentInfo =
    "Este pagamento é referente somente ao mês de junho. Não vamos salvar os dados do seu cartão para pagamentos recorrentes";

class ConfirmationWidget extends StatelessWidget {
  final nf =
  NumberFormat.currency(locale: "pt_BR", symbol: "R\$", decimalDigits: 2);

  @override
  Widget build(BuildContext context) {
    final confirmationViewModel = context.read<ConfirmationViewModel>();

    final paymentOptionsModel = confirmationViewModel.paymentOptionsModel;
    final taxOperation = nf.format(
        paymentOptionsModel.selectedPaymentOption.total -
            paymentOptionsModel.invoiceValue);
    final invoiceValue = nf.format(paymentOptionsModel.invoiceValue);
    final totalValue =
    nf.format(paymentOptionsModel.selectedPaymentOption.total);

    final youPay =
        '${paymentOptionsModel.selectedPaymentOption.number} x ${nf.format(
        paymentOptionsModel.selectedPaymentOption.value)}';

    final userCreditCard = confirmationViewModel.userCreditCardModel;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Pagamento da fatura"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Revise os Valores",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "Fatura de junho",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                          Spacer(),
                          Text(
                            invoiceValue,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "Taxa de operação",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                          Spacer(),
                          Text(
                            taxOperation,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "Total",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Spacer(),
                          Text(
                            totalValue,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "Você vai pagar",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Spacer(),
                          Text(
                            youPay,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  _paymentInfo,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Spacer(),
            Row(
              children: [
                OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Voltar"),
                ),
                Spacer(),
                Text("3 de 3"),
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    Timer? _timer;
                    showDialog(
                      context: context,
                      builder: (context) {
                        _timer = Timer(Duration(seconds: 2), () {
                          Navigator.of(context).pop();
                        });
                        return LoadingDialog();
                      },
                    ).then((value) => {
                      if (_timer!.isActive) {
                        _timer!.cancel()
                      } else {
                        if (userCreditCard.userCreditCard!.cvv == '111') {
                          showDialog(context: context, builder: (context) => SuccessDialog())
                        } else {
                          showDialog(context: context, builder: (context) => ErrorDialog())
                        }
                      }
                  });
                  },
                  child: Text("Pagar Fatura"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
