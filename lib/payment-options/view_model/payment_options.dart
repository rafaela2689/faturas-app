import 'package:faturas/shared/model/payment-options/payment_option.dart';
import 'package:faturas/shared/model/payment-options/payment_options_model.dart';

class PaymentOptionsViewModel {

  final PaymentOptionsModel paymentOptionsModel;

  PaymentOptionsViewModel(this.paymentOptionsModel);

  Future<List<PaymentOption>> loadPaymentOptions() async {
    var paymentOptions = await paymentOptionsModel.getPaymentOptions();
    return paymentOptions;
  }

  double get invoiceValue => paymentOptionsModel.invoiceValue;

  double calculateOperationTax(PaymentOption selectedPaymentOption) {
    return (selectedPaymentOption.number * selectedPaymentOption.value) - invoiceValue;
  }

  void setSelectedPaymentOption(PaymentOption paymentOption) {
    this.paymentOptionsModel.setSelectedPaymentOption(paymentOption);
  }
}