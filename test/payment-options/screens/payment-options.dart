import 'package:faturas/shared/model/payment-options/payment_option.dart';
import 'package:faturas/shared/model/payment-options/payment_options_model.dart';
import 'package:faturas/payment-options/repository/payment_options_rest_service.dart';
import 'package:faturas/payment-options/view/screens/payment_options.dart';
import 'package:faturas/payment-options/view/widgets/payment-option-tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

final List<PaymentOption> paymentOptions = [
  PaymentOption(number: 1, value: 4775.0, total: 4775.0),
  PaymentOption(number: 2, value: 2447.5, total: 4895.0),
  PaymentOption(number: 3, value: 1631.67, total: 4895.0),
  PaymentOption(number: 4, value: 1223.75, total: 4895),
  PaymentOption(number: 5, value: 995, total: 4975),
  PaymentOption(number: 6, value: 829.17, total: 4975),
];

class PaymentOptionsRestServiceMock extends Mock
    implements PaymentOptionsRestService {}

void main() {
  group("Payment Options Screen", () {

    PaymentOptionsRestService paymentOptionsServiceMock = PaymentOptionsRestServiceMock();

    setUpAll(() {
      GetIt.instance.registerSingleton<PaymentOptionsRestService>(paymentOptionsServiceMock);
    });

    testWidgets("render properly", (WidgetTester tester) async {

      when(paymentOptionsServiceMock.fetchPaymentOptions())
          .thenAnswer((invocation) async => paymentOptions);

      final paymentOptionsScreen = ChangeNotifierProvider<PaymentOptionsModel>(
        create: (_) => PaymentOptionsModel(),
        child: MaterialApp(home: PaymentOptionsScreen()),
      );

      await tester.pumpWidget(paymentOptionsScreen);

      final loadingFinder = find.text('Loading');
      expect(loadingFinder, findsOneWidget);

      await tester.pumpAndSettle();

      expect(find.text('Loading'), findsNothing);

      final titleFinder = find.text("Escolha o número de parcelas");
      final paymentOptionsFinder = find.byType(PaymentOptionTile);
      final backButtonFinder = find.byType(OutlinedButton);
      final continueButtonFinder = find.byType(ElevatedButton);
      final taxFinder = find.byKey(Key("tax"));

      expect(titleFinder, findsOneWidget);
      expect(paymentOptionsFinder, findsNWidgets(6));
      expect(backButtonFinder, findsNWidgets(1));
      expect(continueButtonFinder, findsNWidgets(1));
      expect(taxFinder, findsOneWidget);
    });

    testWidgets("change operation tax when select different payment option",
        (WidgetTester tester) async {

      when(paymentOptionsServiceMock.fetchPaymentOptions())
          .thenAnswer((invocation) async => paymentOptions);

      final paymentOptionsScreen = ChangeNotifierProvider<PaymentOptionsModel>(
        create: (_) => PaymentOptionsModel(),
        child: MaterialApp(home: PaymentOptionsScreen()),
      );

      await tester.pumpWidget(paymentOptionsScreen);

      await tester.pumpAndSettle();

      final paymentOptionFinder = find.byKey(Key("2"));
      final taxFinder = find.byKey(Key("tax"));

      expect(taxFinder, findsOneWidget);

      await tester.tap(paymentOptionFinder);

      await tester.pump();

      var nf = NumberFormat.currency(
          locale: "pt_BR", symbol: "R\$", decimalDigits: 2);
      final taxFinderUpdated = find.byKey(Key("tax")).first;
      Text tax = tester.firstWidget(taxFinderUpdated);
      expect(tax.data, nf.format(1869.51));
    });

    testWidgets("render no payment options found when service returns empty list",
            (WidgetTester tester) async {

      when(paymentOptionsServiceMock.fetchPaymentOptions())
          .thenAnswer((invocation) async => []);

      final paymentOptionsScreen = ChangeNotifierProvider<PaymentOptionsModel>(
        create: (_) => PaymentOptionsModel(),
        child: MaterialApp(home: PaymentOptionsScreen()),
      );

      await tester.pumpWidget(paymentOptionsScreen);

      final loadingFinder = find.text('Loading');
      expect(loadingFinder, findsOneWidget);

      await tester.pumpAndSettle();

      expect(find.text('Loading'), findsNothing);
      expect(find.text('No payment options found!'), findsOneWidget);

    });

    testWidgets("render text error when service returns error",
            (WidgetTester tester) async {

      when(paymentOptionsServiceMock.fetchPaymentOptions())
          .thenThrow(Exception('error'));

      final paymentOptionsScreen = ChangeNotifierProvider<PaymentOptionsModel>(
        create: (_) => PaymentOptionsModel(),
        child: MaterialApp(home: PaymentOptionsScreen()),
      );

      await tester.pumpWidget(paymentOptionsScreen);

      final loadingFinder = find.text('Loading');
      expect(loadingFinder, findsOneWidget);

      await tester.pumpAndSettle();

      expect(find.text('Loading'), findsNothing);
      expect(find.text('Something went wrong!'), findsOneWidget);

    });
  });
}
