import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wc_app/config/wc.config.dart';
import 'package:woocommerce/woocommerce.dart';

class CustomerProvider extends ChangeNotifier {
  WooCustomer _customer;
  bool _isLoggedIn = false;
  FlutterSecureStorage _storage = FlutterSecureStorage();

  CustomerProvider() {
    checkAuthentication();
  }

  Future<void> checkAuthentication() async {
    _isLoggedIn = await woocommerce.isCustomerLoggedIn();
    if (_isLoggedIn) {
      final String customerId = await _storage.read(key: 'customer_id');
      _customer = await woocommerce.getCustomerById(id: int.parse(customerId));
    }
    notifyListeners();
  }

  Future<void> updateCustomer(WooCustomer customer) async {
    _customer = await woocommerce.updateCustomer(
      id: _customer.id,
      data: {
        'first_name': customer.firstName,
        'last_name': customer.lastName,
        'username': customer.username,
        'email': customer.email,
      },
    );
    notifyListeners();
  }

  Future<void> loginCustomer(String username, String password) async {
    _customer = await woocommerce.loginCustomer(
      username: username,
      password: password,
    );
    await _storage.write(key: 'customer_id', value: _customer.id.toString());
    notifyListeners();
  }

  bool get isLoggedIn => _isLoggedIn;
  WooCustomer get customer => _customer;

  set isLoggedIn(bool v) {
    _isLoggedIn = v;
    notifyListeners();
  }
}
