import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:wc_app/config/wc.config.dart';
import 'package:woocommerce/models/cart.dart';
import 'package:woocommerce/woocommerce.dart';

class CartProvider extends ChangeNotifier {
  WooCart _cart;
  Box<String> _cartBox;

  WooCoupon _coupon;

  WooCart get cart => _cart;

  int get count => _cart.itemCount ?? 0;

  bool get showPromoPopup => true;

  bool get appliedPromo => false;

  WooCoupon get coupon => _coupon;

  String get totalPrice => _cart.totalPrice;

  String get orderTotal => ((double.parse(_cart.totalPrice) + 10))
      .toStringAsFixed(2)
      .split('.')
      .join();

  String get discount =>
      (double.parse(_cart.totalPrice) * (double.parse(_coupon.amount) / 100))
          .toStringAsFixed(2);

  String get discountedPrice => (double.parse(_cart.totalPrice) *
          (1 - (double.parse(_coupon.amount) / 100)))
      .toStringAsFixed(2);

  Future<void> applyCoupon(String code) async {
    List<WooCoupon> coupons = await woocommerce.getCoupons(
      code: code,
    );
    if (coupons.length > 0) {
      _coupon = coupons[0];
      notifyListeners();
    }
  }

  Future<void> getCartData() async {
    _cartBox = Hive.box('cart');
    String data = _cartBox.get('items');
    if (data != null) {
      dynamic json = jsonDecode(data);
      _cart = WooCart.fromJson(json);
    } else {
      _cart = WooCart(
        currency: 'S/',
        itemCount: 0,
        items: <WooCartItems>[],
        needsShipping: true,
        totalPrice: '0.00',
      );
    }
  }

  void clear() {
    _cart.items = <WooCartItems>[];
    _updateCart();
  }

  void deleteItem(int index) {
    _cart.items.removeAt(index);
    _updateCart();
  }

  void updateItem(int index, int qty) async {
    _cart.items[index].quantity = qty;
    _updateCart();
  }

  Future<void> _updateCart() async {
    _cart.itemCount = _cart.items.fold<int>(0, (p, i) => p + i.quantity);
    _cart.totalPrice = _cart.items
        .fold(0, (p, i) => p + (i.quantity * double.parse(i.price)))
        .toStringAsFixed(2);
    var json = jsonEncode(_cart);
    await _cartBox.put('items', json);
    notifyListeners();
  }

  Future<void> addToCart(WooProduct product, {int quantity = 1}) async {
    int index = _cart.items.indexWhere((element) => element.id == product.id);
    if (index < 0) {
      WooCartItems item = WooCartItems(
        id: product.id,
        images: getWooCartImages(product),
        quantity: quantity,
        price: product.price,
        sku: product.sku,
        name: product.name,
        permalink: product.permalink,
        variation: [],
        key: product.id.toString(),
        linePrice: '',
      );
      _cart.items.add(item);
    } else {
      _cart.items[index].quantity += quantity;
    }
    _cart.itemCount += quantity;
    _cart.totalPrice = _cart.items
        .fold(0, (p, i) => p + (i.quantity * double.parse(i.price)))
        .toStringAsFixed(2);
    _updateCart();
  }

  Future<String> validateAddToCart(int id) async {
    WooProduct product = await woocommerce.getProductById(id: id);
    if (product.stockStatus != 'instock') {
      return '${product.name} está fuera de stock';
    }
    return null;
  }
}

List<WooCartImages> getWooCartImages(WooProduct product) {
  return product.images
      .map((i) => WooCartImages(
            id: i.id.toString(),
            alt: i.alt,
            name: i.name,
            src: i.src,
          ))
      .toList();
}
