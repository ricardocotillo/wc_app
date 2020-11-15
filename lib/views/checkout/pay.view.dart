import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:wc_app/common/errors.common.dart';
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
  final TextEditingController _monthController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final CheckoutProvider _checkoutProvider =
        Provider.of<CheckoutProvider>(context);
    final CartProvider _cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Pago'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.primary,
        onPressed: () {
          sendOrder(_cartProvider, _checkoutProvider);
        },
        child: Icon(Icons.credit_card_outlined),
      ),
      body: Column(
        children: [
          InputComponent(
            validator: _emptyValidate,
            controller: _numController,
            hint: 'Número de tarjeta',
            keyboard: TextInputType.number,
          ),
          InputComponent(
            validator: _emptyValidate,
            controller: _monthController,
            hint: 'Mes de expiración',
            keyboard: TextInputType.number,
          ),
          InputComponent(
            validator: _emptyValidate,
            controller: _yearController,
            hint: 'Año de expiración',
            keyboard: TextInputType.number,
          ),
          InputComponent(
            validator: _emptyValidate,
            controller: _cvvController,
            hint: 'CVV',
            keyboard: TextInputType.number,
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

  String _emptyValidate(String s) {
    if (s.isEmpty || s == '') return ErrorsCommon.required;
    return null;
  }
}
