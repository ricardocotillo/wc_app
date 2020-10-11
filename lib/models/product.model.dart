import 'package:woocommerce/woocommerce.dart';

class Product extends WooProduct {
  List<dynamic> brands;
  Product.fromJson(Map<String, dynamic> json)
      : brands = json['brands'],
        super.fromJson(json);
}
