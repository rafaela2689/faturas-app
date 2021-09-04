// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:faturas/home/view/screens/home.dart';
import 'package:faturas/home/view/widgets/last_invoice_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Home Faturas', (WidgetTester tester) async {

    await tester.pumpWidget(MaterialApp(home: HomeScreen()));

    expect(find.text('Última fatura'), findsOneWidget);
    expect(find.text('R\$ 3.025,49'), findsOneWidget);
    expect(find.text('Vencimento 08/07/2019'), findsOneWidget);
    expect(find.text('Vencida'), findsOneWidget);
    expect(find.text('Formas de Pagamento'), findsOneWidget);
    expect(find.text('Boleto Bancário'), findsOneWidget);
    expect(find.text('Cartão de Crédito'), findsOneWidget);

    expect(find.byType(OutlinedButton), findsNWidgets(3));

    expect(find.text('Copiar código de barras do boleto'), findsOneWidget);
    expect(find.text('Enviar boleto por e-mail'), findsOneWidget);
    expect(find.text('Pagar com cartão de crédito'), findsOneWidget);
  });

  testWidgets('LastInvoiceInfo', (WidgetTester tester) async {

    await tester.pumpWidget(LastInvoiceInfo());

    expect(find.text('Última fatura'), findsOneWidget);
    expect(find.text('R\$ 3.025,49'), findsOneWidget);
    expect(find.text('Vencimento 08/07/2019'), findsOneWidget);
    expect(find.text('Vencida'), findsOneWidget);
  });
}
