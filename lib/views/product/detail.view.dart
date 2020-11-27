import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:wc_app/common/functions.common.dart';
import 'package:wc_app/components/button.component.dart';
import 'package:wc_app/providers/cart.provider.dart';
import 'package:woocommerce/woocommerce.dart';
import 'package:html/parser.dart';

class ProductDetailView extends StatefulWidget {
  final WooProduct product;

  const ProductDetailView({Key key, this.product}) : super(key: key);

  @override
  _ProductDetailViewState createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  int _quantity = 1;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final CartProvider _cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.product.name),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            SizedBox(
              height: size.height,
              width: size.width,
            ),
            widget.product.images.length > 0
                ? CachedNetworkImage(
                    imageUrl: widget.product.images[0].src,
                    fit: BoxFit.fitWidth)
                : Image.asset('assets/img/generic_product.png'),
            Positioned(
              right: 10,
              child: IconButton(
                icon: Icon(FontAwesomeIcons.share),
                onPressed: () {
                  Share.share(
                      '${widget.product.name}: ${widget.product.permalink}');
                },
              ),
            ),
            if (widget.product.sku != null)
              Positioned(
                top: 10,
                left: 10,
                child: Text('SKU: ' + widget.product.sku),
              ),
            Positioned(
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                height: (size.height / 2) + 20,
                width: size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 20.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 15,
                        ),
                        child: Text(
                          widget.product.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          widget.product.categories[0].name,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'Características principales:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          parse(widget.product.shortDescription)
                              .documentElement
                              .text,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text.rich(
                          TextSpan(
                            text:
                                '${getFormattedPrice(widget.product.price)}  ',
                            style: TextStyle(
                              color:
                                  Theme.of(context).colorScheme.primaryVariant,
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0,
                            ),
                            children: widget.product.onSale
                                ? <TextSpan>[
                                    TextSpan(
                                      text: getFormattedPrice(
                                          widget.product.regularPrice),
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontSize: 15,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    )
                                  ]
                                : null,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () {
                                setState(() {
                                  _quantity =
                                      _quantity == 1 ? 1 : _quantity - 1;
                                });
                              },
                            ),
                            Text(
                              _quantity.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                setState(() {
                                  _quantity++;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      Align(
                        child: Builder(
                          builder: (context) => ButtonComponent(
                            icon: FontAwesomeIcons.shoppingBag,
                            title: 'Agregar a carrito',
                            onPressed: () async {
                              await _cartProvider.addToCart(
                                widget.product,
                                quantity: _quantity,
                              );
                              showSnackBar(
                                context: context,
                                msg: 'Producto agregado',
                                type: SnackBarType.success,
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
