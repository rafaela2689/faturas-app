import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: LoadingTitleWidget(message : 'Confirmando seu pagamento'),
      content: const Text('Estamos confirmando a transação com seu banco e isso pode levar alguns segundos.'),
    );
  }
}

class LoadingTitleWidget extends StatelessWidget {
  final String message;

  LoadingTitleWidget({this.message = 'Loading'});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CircularProgressIndicator(),
          Text(message),
        ],
      ),
    );
  }

}