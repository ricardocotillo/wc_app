import 'package:wc_app/config/wc.config.dart';
import 'package:woocommerce/models/products.dart';
import 'package:woocommerce/woocommerce.dart';

class MainViewProvider {
  List<WooProduct> _featured;
  List<WooProductCategory> _categories;

  Future<void> getProducts() async {
    _featured = await woocommerce.getProducts(
      orderBy: 'menu_order',
      order: 'asc',
      featured: true,
    );
  }

  Future<void> getCategories() async {
    _categories = await woocommerce.getProductCategories();
  }

  List<WooProduct> get featured => _featured;
  List<WooProductCategory> get categories => _categories;
}
