import 'package:faturas/shared/model/credit-card/credit_card.dart';
import 'package:flutter/widgets.dart';

class UserCreditCardModel extends ChangeNotifier {
  CreditCard? userCreditCard;
  
  setUserCreditCard(CreditCard creditCard) {
    this.userCreditCard = creditCard;

    notifyListeners();
  }
}