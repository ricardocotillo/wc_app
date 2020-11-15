import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:wc_app/components/input.component.dart';
import 'package:wc_app/config/wc.config.dart';
import 'package:wc_app/providers/cart.provider.dart';
import 'package:wc_app/providers/checkout.provider.dart';
import 'package:woocommerce/models/order_payload.dart';
import 'package:woocommerce/woocommerce.dart';

class PayView extends StatefulWidget {
  @override
  _PayViewState createState() => _PayViewState();
}

class _PayViewState extends State<PayView> {
  final TextEditingController _numController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final CheckoutProvider _checkoutProvider =
        Provider.of<CheckoutProvider>(context);
    final CartProvider _cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          sendOrder(_cartProvider, _checkoutProvider);
        },
        child: Text('Realizar Pago'),
      ),
      body: Column(
        children: [
          InputComponent(
            controller: _numController,
            hint: 'Número de tarjeta',
          ),
        ],
      ),
    );
  }

  void sendOrder(
      CartProvider cartProvider, CheckoutProvider checkoutProvider) async {
    WooOrderPayload orderPayload = WooOrderPayload(
      setPaid: true,
      lineItems: cartProvider.cart.items
          .map((e) => LineItems(
                productId: e.id,
                quantity: e.quantity,
              ))
          .toList(),
      billing: WooOrderPayloadBilling(
        address1: checkoutProvider.address,
        city: 'Lima',
        country: 'PE',
        email: checkoutProvider.email,
        firstName: checkoutProvider.name,
        lastName: checkoutProvider.lastName,
        phone: checkoutProvider.phone,
        state: checkoutProvider.getDistrictCode(),
      ),
      shipping: WooOrderPayloadShipping(
        address1: checkoutProvider.address,
        city: 'Lima',
        country: 'PE',
        firstName: checkoutProvider.name,
        lastName: checkoutProvider.lastName,
        state: checkoutProvider.getDistrictCode(),
      ),
      shippingLines: <ShippingLines>[
        ShippingLines(
          methodId: "flat_rate",
          methodTitle: "Flat rate",
          total: '10.00',
        )
      ],
    );
    WooOrder order = await woocommerce.createOrder(orderPayload);
  }
}
