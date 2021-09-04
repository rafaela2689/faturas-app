import 'package:faturas/shared/model/credit-card/credit_card.dart';
import 'package:faturas/shared/model/credit-card/user_credit_card_model.dart';

class CreditCardDetailsViewModel {
  final UserCreditCardModel userCreditCardModel;

  CreditCardDetailsViewModel(this.userCreditCardModel);

  setUserCreditCard(CreditCard creditCard) {
    this.userCreditCardModel.setUserCreditCard(creditCard);
  }
}