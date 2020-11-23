import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:wc_app/components/button.component.dart';
import 'package:wc_app/components/cartItem.component.dart';
import 'package:wc_app/components/inputButton.component.dart';
import 'package:wc_app/components/summaryLine.component.dart';
import 'package:wc_app/providers/cart.provider.dart';
import 'package:wc_app/providers/customer.provider.dart';
import 'package:wc_app/views/auth/login.view.dart';
import 'package:wc_app/views/checkout/address.view.dart';

class CartView extends StatelessWidget {
  final TextEditingController _couponController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final CartProvider _cartProvider = Provider.of<CartProvider>(context);
    final CustomerProvider _customerProvider =
        Provider.of<CustomerProvider>(context);
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrito'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  primary: false,
                  itemCount: _cartProvider.cart.items.length,
                  itemBuilder: (context, i) => CartItemComponent(
                    item: _cartProvider.cart.items[i],
                    onChangeQuantity: (int qty) {
                      _cartProvider.updateItem(i, qty);
                    },
                    onRemoveFromCart: () async {
                      bool confirmed = await showDialog<bool>(
                        context: context,
                        child: AlertDialog(
                          title:
                              Text('¿Seguro que deseas borrarlo del carrito?'),
                          actions: [
                            FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop(true);
                              },
                              textColor: Colors.red,
                              child: Text('confirmar'),
                            ),
                            FlatButton(
                              onPressed: () {
                                Navigator.of(context).pop(false);
                              },
                              textColor: Colors.grey,
                              child: Text('cancelar'),
                            )
                          ],
                        ),
                      );
                      if (confirmed) {
                        _cartProvider.deleteItem(i);
                      }
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 15.0 * 3),
              ),
              InputButtonComponent(
                  placeHolder: _cartProvider.coupon != null
                      ? _cartProvider.coupon.code
                      : '¿Tienes un código de promoción?',
                  controller: _couponController,
                  width: size.width,
                  onClick: () {
                    if (_couponController.text != '') {
                      _cartProvider.applyCoupon(_couponController.text);
                      FocusScope.of(context).unfocus();
                    }
                  }),
              Padding(
                padding: EdgeInsets.only(bottom: 15.0 * 3),
              ),
              _cartProvider.coupon != null
                  ? Column(children: <Widget>[
                      SummaryLineComponent(
                          title: 'Subtotal:',
                          summary: 'S/' + _cartProvider.totalPrice),
                      SummaryLineComponent(
                        title: 'Descuento:',
                        summary: '- S/' + _cartProvider.discount,
                      ),
                      SummaryLineComponent(
                        title: 'Envío:',
                        summary: 'S/10.00',
                      ),
                      SummaryLineComponent(
                        title: 'Total:',
                        summary: 'S/' + _cartProvider.discountedPrice,
                      ),
                    ])
                  : Column(
                      children: [
                        SummaryLineComponent(
                          title: 'Subtotal:',
                          summary: 'S/' + _cartProvider.totalPrice,
                        ),
                        SummaryLineComponent(
                          title: 'Envío:',
                          summary: 'S/10.00',
                        ),
                        SummaryLineComponent(
                          title: 'Total:',
                          summary: 'S/' +
                              (double.parse(_cartProvider.totalPrice) + 10)
                                  .toStringAsFixed(2),
                        ),
                      ],
                    ),
              Padding(
                padding: EdgeInsets.only(bottom: 15.0 * 3),
              ),
              ButtonComponent(
                onPressed: () {
                  if (_customerProvider.isLoggedIn) {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AddressView(),
                    ));
                  } else {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => LoginView(),
                    ));
                  }
                },
                title: 'Realizar Pago',
              )
            ],
          ),
        ),
      ),
    );
  }
}
