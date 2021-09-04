import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LastInvoiceInfo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
      child: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                margin: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  'Última fatura',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20
                  ),
                  textDirection: TextDirection.ltr,
                ),
              ),
            ],
          ),
          Row(
            textDirection: TextDirection.ltr,
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        'R\$ 3.025,49',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        textDirection: TextDirection.ltr,
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      // margin: const EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        'Vencimento 08/07/2019',
                        style: const TextStyle(
                          fontWeight: FontWeight.w200,
                          fontSize: 18,
                        ),
                        textDirection: TextDirection.ltr,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Text(
                  'Vencida',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                    fontSize: 18,
                  ),
                  textDirection: TextDirection.ltr,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}