import 'package:flutter/foundation.dart';
import 'package:wc_app/config/wc.config.dart';
import 'package:woocommerce/woocommerce.dart';

class CustomerProvider extends ChangeNotifier {
  WooCustomer _customer;
  bool _isLoggedIn = false;

  CustomerProvider() {
    checkAuthentication();
  }

  Future<void> checkAuthentication() async {
    _isLoggedIn = await woocommerce.isCustomerLoggedIn();
    notifyListeners();
  }

  Future<void> loginCustomer(String username, String password) async {
    _customer = await woocommerce.loginCustomer(
      username: username,
      password: password,
    );
    notifyListeners();
  }

  bool get isLoggedIn => _isLoggedIn;
  WooCustomer get customer => _customer;

  set isLoggedIn(bool v) {
    _isLoggedIn = v;
    notifyListeners();
  }
}
