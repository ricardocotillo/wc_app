import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share/share.dart';
import 'package:wc_app/common/functions.common.dart';
import 'package:wc_app/components/button.component.dart';
import 'package:woocommerce/woocommerce.dart';
import 'package:html/parser.dart';

class ProductDetailView extends StatelessWidget {
  final WooProduct product;

  const ProductDetailView({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            SizedBox(
              height: size.height,
              width: size.width,
            ),
            Image.network(
              product.images[0].src,
              fit: BoxFit.fitWidth,
            ),
            Positioned(
              right: 10,
              child: IconButton(
                icon: Icon(FontAwesomeIcons.share),
                onPressed: () {
                  Share.share('${product.name}: ${product.permalink}');
                },
              ),
            ),
            if (product.sku != null)
              Positioned(
                top: 10,
                left: 10,
                child: Text('SKU: ' + product.sku),
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
                          product.name,
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
                          product.categories[0].name,
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
                          parse(product.shortDescription).documentElement.text,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text.rich(
                          TextSpan(
                            text: '${getFormattedPrice(product.price)}  ',
                            style: TextStyle(
                              color:
                                  Theme.of(context).colorScheme.primaryVariant,
                              fontWeight: FontWeight.bold,
                              fontSize: 25.0,
                            ),
                            children: product.onSale
                                ? <TextSpan>[
                                    TextSpan(
                                      text: getFormattedPrice(
                                          product.regularPrice),
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
                      Align(
                        child: ButtonComponent(
                          icon: FontAwesomeIcons.shoppingBag,
                          title: 'Agregar a carrito',
                          onPressed: () {},
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
