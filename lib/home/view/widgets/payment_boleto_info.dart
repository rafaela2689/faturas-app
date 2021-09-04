import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dialog.dart';

class PaymentBoleto extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(bottom: 20.0),
            child:  Text(
              'Formas de Pagamento',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              textDirection: TextDirection.rtl,
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(bottom: 10.0),
            child:  Text(
              'Boleto Bancário',
              style: const TextStyle(
                fontWeight: FontWeight.w200,
                fontSize: 18,
              ),
              textDirection: TextDirection.rtl,
            ),
          ),
          Container(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {},
              child: const Text('Copiar código de barras do boleto'),
            ),
          ),
          Container(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => showDialog(
                context: context,
                builder: (BuildContext context) => FirstDialog(),
              ),
              child: const Text('Enviar boleto por e-mail'),
            ),
          ),
        ],
      ),
    );
  }

}