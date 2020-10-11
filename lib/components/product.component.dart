import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:wc_app/common/functions.common.dart';
import 'package:wc_app/providers/cart.provider.dart';
import 'package:wc_app/views/product/detail.view.dart';
import 'package:woocommerce/woocommerce.dart';

class ProductCompoent extends StatefulWidget {
  final WooProduct product;

  const ProductCompoent({Key key, this.product}) : super(key: key);

  @override
  _ProductCompoentState createState() => _ProductCompoentState();
}

class _ProductCompoentState extends State<ProductCompoent> {
  String getBrand(WooProduct product) {
    // final brands = product.metaData.firstWhere((m) => m.key == 'brands');
    // return brands.value;
    return null;
  }

  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final CartProvider _cartProvider = Provider.of<CartProvider>(context);
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // if ()
          // Padding(
          //   padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
          //   child: Text(getBrand(widget.product)),
          // ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    widget.product.name,
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                ),
                ColoredBox(
                  color: Theme.of(context).colorScheme.primary,
                  child: IconButton(
                    visualDensity: VisualDensity.compact,
                    constraints: BoxConstraints(
                      maxHeight: 40,
                      maxWidth: 40,
                    ),
                    icon: _loading
                        ? Theme(
                            data: Theme.of(context).copyWith(
                              accentColor: Colors.white,
                            ),
                            child: CircularProgressIndicator(
                              strokeWidth: 1,
                            ),
                          )
                        : Icon(Icons.add),
                    onPressed: () async {
                      setState(() {
                        _loading = true;
                      });
                      String invalid = await _cartProvider
                          .validateAddToCart(widget.product.id);
                      if (invalid != null) {
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text(
                            invalid,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          backgroundColor: Colors.red,
                        ));
                      } else {
                        await _cartProvider.addToCart(widget.product);
                        Scaffold.of(context).showSnackBar(SnackBar(
                          content: Text(
                            'Se ha agregado ${widget.product.name}',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ));
                      }
                      setState(() {
                        _loading = false;
                      });
                    },
                    color: Colors.white,
                    iconSize: 18,
                    padding: const EdgeInsets.all(5),
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ProductDetailView(
                  product: widget.product,
                ),
              ),
            ),
            child: CachedNetworkImage(imageUrl: widget.product.images[0].src),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text.rich(TextSpan(
              text: '${getFormattedPrice(widget.product.price)}  ',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primaryVariant,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
              children: widget.product.onSale
                  ? <TextSpan>[
                      TextSpan(
                        text: getFormattedPrice(widget.product.regularPrice),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 13,
                          decoration: TextDecoration.lineThrough,
                        ),
                      )
                    ]
                  : null,
            )),
          ),
        ],
      ),
    );
  }
}
