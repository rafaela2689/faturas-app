import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaymentCreditCard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(bottom: 10.0),
            child:  Text(
              'Cartão de Crédito',
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
              onPressed: () => {
                Navigator.pushNamed(context, '/payment-options'),
              },
              child: Text(
                'Pagar com cartão de crédito',
                textDirection: TextDirection.rtl,
              ),
            ),
          ),
        ],
      ),
    );
  }
}