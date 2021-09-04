import 'dart:convert';

import 'package:faturas/shared/model/payment-options/payment_option.dart';
import 'package:http/http.dart' as http;

class PaymentOptionsRestService {

  Future<List<PaymentOption>>? fetchPaymentOptions() async {
    final url = Uri.parse('https://dreamy-allen-2e1b47.netlify.app/payment-options.json');
    final response = await http.get(url).timeout(Duration(seconds: 10));

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      var installments = responseBody['options']['installments'] as List;
      return installments
          .map((json) => PaymentOption.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load payment options');
    }
  }
}