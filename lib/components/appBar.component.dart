import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wc_app/providers/cart.provider.dart';
import 'package:wc_app/views/cart/cart.view.dart';

AppBar appBar(Widget title) {
  return AppBar(
    title: title,
    centerTitle: true,
    actions: [
      BagIcon(),
    ],
  );
}

class BagIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CartProvider _cartProvider = Provider.of<CartProvider>(context);
    return Stack(
      alignment: Alignment.center,
      children: [
        IconButton(
          disabledColor: Colors.white,
          icon: Icon(FontAwesomeIcons.shoppingBag),
          iconSize: 18,
          onPressed: _cartProvider.count > 0
              ? () {
                  Navigator.of(context).push(CupertinoPageRoute(
                    builder: (context) => CartView(),
                  ));
                }
              : null,
        ),
        Positioned(
          top: 15,
          right: 10,
          child: Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: Color(0xFFBA9A69),
              shape: BoxShape.circle,
            ),
            child: Text(
              _cartProvider.count.toString(),
              style: TextStyle(
                fontSize: 10,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
