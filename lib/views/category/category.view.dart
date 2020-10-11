import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wc_app/components/appBar.component.dart';
import 'package:wc_app/components/product.component.dart';
import 'package:wc_app/config/wc.config.dart';
import 'package:woocommerce/woocommerce.dart';

class CategoryView extends StatefulWidget {
  final WooProductCategory category;

  const CategoryView({Key key, this.category}) : super(key: key);

  @override
  _CategoryViewState createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  Future<List<WooProduct>> _future;
  @override
  void initState() {
    super.initState();
    _future = woocommerce.getProducts(
      category: widget.category.id.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(widget.category.name),
      body: FutureBuilder(
          future: _future,
          builder: (context, AsyncSnapshot<List<WooProduct>> snap) {
            switch (snap.connectionState) {
              case ConnectionState.done:
                List<WooProduct> products = snap.data;
                print(products.length);
                return GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.65,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, int i) => ProductCompoent(
                    product: products[i],
                  ),
                );
                break;
              default:
                return Center(
                  child: CircularProgressIndicator(),
                );
            }
          }),
    );
  }
}
