import 'package:faturas/payment-options/repository/payment_options_rest_service.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void registerDependencies() {
  getIt.registerSingleton<PaymentOptionsRestService>(PaymentOptionsRestService());
}