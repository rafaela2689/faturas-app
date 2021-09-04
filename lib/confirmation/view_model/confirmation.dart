import 'package:faturas/shared/model/credit-card/user_credit_card_model.dart';
import 'package:faturas/shared/model/payment-options/payment_options_model.dart';

class ConfirmationViewModel {
  final PaymentOptionsModel paymentOptionsModel;
  final UserCreditCardModel userCreditCardModel;

  ConfirmationViewModel(this.paymentOptionsModel, this.userCreditCardModel);
}