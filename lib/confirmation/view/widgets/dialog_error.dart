import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Falha na cobrança'),
      content: const Text('Algo deu errado no processamento do seu cartão. Verifique se os dados do cartão estão corretos.'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pushNamed(context, '/credit-card-details'),
          child: const Text('Revisar Dados'),
        ),
      ],
    );
  }

}