import 'package:faturas/credit-card/view_model/credit_card_details.dart';
import 'package:faturas/shared/model/credit-card/credit_card.dart';
import 'package:faturas/shared/model/credit-card/user_credit_card_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const _infoCreditCardText =
    "Essa transação é 100% segura e com certificados de segurança que garantem a integridade dos seus dados.";
const _cardNumberInput = "Número do cartão";
const _cardNameInput = "Nome do titular do cartão";

class CreditCardDetailsScreen extends StatelessWidget {
  const CreditCardDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ProxyProvider<UserCreditCardModel, CreditCardDetailsViewModel>(
      create: (context) => CreditCardDetailsViewModel(
        context.read<UserCreditCardModel>(),
      ),
      update: (context, creditCardModel, notifier) => CreditCardDetailsViewModel(
        creditCardModel
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pagamento da Fatura'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: CreditCardDetailsForm(),
        ),
      ),
    );
  }
}

class CreditCardDetailsForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CreditCardDetailsFormState();
  }
}

class CreditCardDetailsFormState extends State<CreditCardDetailsForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _expirationController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  UserCreditCardModel? savedUserCreditcard;

  String? _notEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _numberController.dispose();
    _expirationController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final creditCartDetailsViewModel = context.read<CreditCardDetailsViewModel>();
    final userCreditCard = creditCartDetailsViewModel.userCreditCardModel.userCreditCard;
    if (userCreditCard != null) {
      _nameController.text = userCreditCard.name;
      _numberController.text = userCreditCard.number;
      _expirationController.text = userCreditCard.expiration;
      _cvvController.text = userCreditCard.cvv;
    }

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              _cardNumberInput,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            TextFormField(
              controller: _numberController,
              maxLength: 16,
              decoration: InputDecoration(border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
              validator: (value) => _notEmpty(value),
            ),
            Text(
              _cardNameInput,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(border: OutlineInputBorder()),
              validator: (value) => _notEmpty(value),
            ),
            Row(
              children: [
                Column(
                  children: [
                    Text(
                      "Validade",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: TextFormField(
                        controller: _expirationController,
                        maxLength: 4,
                        decoration:
                            InputDecoration(border: OutlineInputBorder()),
                        keyboardType: TextInputType.number,
                        validator: (value) => _notEmpty(value),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  children: [
                    Text(
                      "CVV",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: TextFormField(
                        controller: _cvvController,
                        maxLength: 3,
                        decoration:
                            InputDecoration(border: OutlineInputBorder()),
                        keyboardType: TextInputType.number,
                        validator: (value) => _notEmpty(value),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            InfoCreditCard(),
            Row(
              children: [
                OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("Voltar"),
                ),
                Spacer(),
                Text("2 de 3"),
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final creditCard = CreditCard(
                        _nameController.text,
                        _numberController.text,
                        _expirationController.text,
                        _cvvController.text
                      );
                      creditCartDetailsViewModel.setUserCreditCard(creditCard);
                      Navigator.pushNamed(context, '/confirmation');
                    }
                  },
                  child: Text("Continuar"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class InfoCreditCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          _infoCreditCardText,
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
      ),
    );
  }
}
