import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SuccessDialog extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Cobrança Efetuada"),
      content: const Text('Tudo certo, seu pagamento foi efetuado!'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Ok'),
          child: const Text('Ok'),
        ),
      ],
    );
  }

}