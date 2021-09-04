import 'package:faturas/shared/model/payment-options/payment_option.dart';
import 'package:faturas/payment-options/view/widgets/payment-option-tile.dart';
import 'package:faturas/payment-options/view_model/payment_options.dart';
import 'package:faturas/shared/progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

const _pageTitle = 'Pagamento da Fatura';
const _operationTaxText = 'Taxa de operação';
const _invoiceJuneText = 'Fatura de junho';
const _backButton = 'Voltar';
const _continueButton = 'Continuar';
const _chooseInstallments = 'Escolha o número de parcelas';

class PaymentOptionsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var paymentOptionsViewModel = context.read<PaymentOptionsViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(_pageTitle),
      ),
      body: FutureBuilder<List<PaymentOption>>(
          future: paymentOptionsViewModel.loadPaymentOptions(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
              case ConnectionState.active:
                return Progress();
              case ConnectionState.done:
                if (snapshot.hasData) {
                  return Container(
                    child: Consumer<PaymentOptionsViewModel>(
                      builder: (context, paymentOptionsViewModel, child) {
                        var paymentOptions = snapshot.data!;

                        if (paymentOptions.length == 0) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.warning),
                                Text('No payment options found!'),
                              ],
                            ),
                          );
                        }

                        return PaymentOptionsList(paymentOptions);
                      },
                    ),
                  );
                }
            }

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.warning),
                  Text('Something went wrong!'),
                ],
              ),
            );
          }),
    );
  }
}

class PaymentOptionsList extends StatelessWidget {
  final List<PaymentOption> paymentOptions;

  PaymentOptionsList(this.paymentOptions);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              _chooseInstallments,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: paymentOptions.length,
              itemBuilder: (context, index) {
                final paymentOption = paymentOptions[index];
                return PaymentOptionTile(paymentOption);
              },
            ),
          ),
          Divider(),
          InvoiceInfoCard(),
          Footer(),
        ],
      ),
    );
  }
}

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        OutlinedButton(
          onPressed: () => Navigator.pop(context),
          child: Text(_backButton),
        ),
        Spacer(),
        Text("1 de 3"),
        Spacer(),
        ElevatedButton(
          onPressed: () => Navigator.pushNamed(context, '/credit-card-details'),
          child: Text(_continueButton),
        ),
      ],
    );
  }
}

class InvoiceInfoCard extends StatelessWidget {
  final nf =
      NumberFormat.currency(locale: "pt_BR", symbol: "R\$", decimalDigits: 2);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                children: [
                  Text(
                    _invoiceJuneText,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  Spacer(),
                  Consumer<PaymentOptionsViewModel>(
                    builder: (context, paymentOptionsViewModel, child) {
                      return Text(
                        "${nf.format(paymentOptionsViewModel.invoiceValue)}",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      );
                    },
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Row(
                children: [
                  Text(
                    _operationTaxText,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  Spacer(),
                  Consumer<PaymentOptionsViewModel>(
                    builder: (context, paymentOptionsViewModel, child) {
                      final selectedPaymentOption = paymentOptionsViewModel
                          .paymentOptionsModel.selectedPaymentOption;
                      var operationTax = paymentOptionsViewModel
                          .calculateOperationTax(selectedPaymentOption);

                      return Text(
                        "${nf.format(operationTax)}",
                        key: Key("tax"),
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      );
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
