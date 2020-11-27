import 'dart:convert';

import 'package:culqi_flutter/culqi_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';
import 'package:wc_app/common/errors.common.dart';
import 'package:wc_app/common/functions.common.dart';
import 'package:wc_app/components/input.component.dart';
import 'package:wc_app/config/wc.config.dart';
import 'package:wc_app/providers/cart.provider.dart';
import 'package:wc_app/providers/checkout.provider.dart';
import 'package:wc_app/providers/customer.provider.dart';
import 'package:wc_app/views/checkout/orderInfo.view.dart';
import 'package:woocommerce/models/order_payload.dart';
import 'package:woocommerce/woocommerce.dart';
import 'package:http/http.dart' as http;

class PayView extends StatefulWidget {
  @override
  _PayViewState createState() => _PayViewState();
}

class _PayViewState extends State<PayView> {
  final String culqiKey = 'sk_test_1Gv6PiIyFv6WXEp8';
  final TextEditingController _numController = TextEditingController();
  final TextEditingController _monthController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();

  final GlobalKey<InputComponentState> _numKey =
      GlobalKey<InputComponentState>();
  final GlobalKey<InputComponentState> _monthKey =
      GlobalKey<InputComponentState>();
  final GlobalKey<InputComponentState> _yearKey =
      GlobalKey<InputComponentState>();
  final GlobalKey<InputComponentState> _cvvKey =
      GlobalKey<InputComponentState>();

  final MaskTextInputFormatter yearFormatter =
      MaskTextInputFormatter(mask: 'XX', filter: {"X": RegExp(r'[0-9]')});
  final MaskTextInputFormatter monthFormatter =
      MaskTextInputFormatter(mask: 'XX', filter: {"X": RegExp(r'[0-9]')});
  final MaskTextInputFormatter cvvFormatter =
      MaskTextInputFormatter(mask: 'XXX', filter: {"X": RegExp(r'[0-9]')});
  final MaskTextInputFormatter cardFormatter = MaskTextInputFormatter(
      mask: 'XXXX XXXX XXXX XXXX', filter: {"X": RegExp(r'[0-9]')});

  @override
  Widget build(BuildContext context) {
    final CheckoutProvider _checkoutProvider =
        Provider.of<CheckoutProvider>(context);
    final CartProvider _cartProvider = Provider.of<CartProvider>(context);
    final CustomerProvider _customerProvider =
        Provider.of<CustomerProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Pago'),
        centerTitle: true,
      ),
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.primary,
          onPressed: () async {
            if (_numKey.currentState.validate() &&
                _monthKey.currentState.validate() &&
                _yearKey.currentState.validate() &&
                _cvvKey.currentState.validate()) {
              showLoading(context);
              String err = await pay(_checkoutProvider, _cartProvider);
              if (err != null) {
                Navigator.pop(context);
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text(err),
                  backgroundColor: Colors.red,
                ));
                return;
              }
              WooOrder order = await sendOrder(
                  _cartProvider, _checkoutProvider, _customerProvider);
              print(order.id);
              _cartProvider.clear();
              Navigator.pop(context);
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => OrderInfoView(order: order),
                ),
                (route) => false,
              );
            }
          },
          child: Icon(Icons.credit_card_outlined),
        ),
      ),
      body: Column(
        children: [
          InputComponent(
            key: _numKey,
            inputFormatters: [cardFormatter],
            validator: _emptyValidate,
            controller: _numController,
            hint: 'Número de tarjeta',
            keyboard: TextInputType.number,
          ),
          InputComponent(
            key: _monthKey,
            inputFormatters: [monthFormatter],
            validator: _emptyValidate,
            controller: _monthController,
            hint: 'Mes de expiración',
            keyboard: TextInputType.number,
          ),
          InputComponent(
            inputFormatters: [yearFormatter],
            key: _yearKey,
            validator: _emptyValidate,
            controller: _yearController,
            hint: 'Año de expiración',
            keyboard: TextInputType.number,
          ),
          InputComponent(
            key: _cvvKey,
            inputFormatters: [cvvFormatter],
            validator: _emptyValidate,
            controller: _cvvController,
            hint: 'CVV',
            keyboard: TextInputType.number,
          ),
        ],
      ),
    );
  }

  Future<String> pay(
      CheckoutProvider checkoutProvider, CartProvider cartProvider) async {
    CCard card = CCard(
      cardNumber: _numController.text,
      cvv: _cvvController.text,
      expirationMonth: int.parse(_monthController.text),
      expirationYear: int.parse(_yearController.text),
      email: checkoutProvider.email,
    );

    try {
      CToken token = await createToken(
        card: card,
        apiKey: culqiKey,
      );
      //su token
      print(token.id);
      http.Response res = await http.post(
        'https://api.culqi.com/v2/charges',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ' + culqiKey,
        },
        body: jsonEncode({
          "amount": cartProvider.orderTotal,
          "currency_code": "PEN",
          "email": checkoutProvider.email,
          "source_id": token.id,
        }),
      );
      print(res.statusCode);
      return null;
    } on CulqiBadRequestException catch (ex) {
      return ex.cause;
    } on CulqiUnknownException catch (ex) {
      //codigo de error del servidor
      return ex.cause;
    }
  }

  Future<WooOrder> sendOrder(
    CartProvider cartProvider,
    CheckoutProvider checkoutProvider,
    CustomerProvider customerProvider,
  ) async {
    WooOrderPayload orderPayload = WooOrderPayload(
      setPaid: true,
      customerId: customerProvider.customer.id,
      couponLines: cartProvider.coupon != null
          ? [
              WooOrderPayloadCouponLines(code: cartProvider.coupon.code),
            ]
          : null,
      lineItems: cartProvider.cart.items
          .map((e) => LineItems(
                productId: e.id,
                quantity: e.quantity,
              ))
          .toList(),
      metaData: <WooOrderPayloadMetaData>[
        WooOrderPayloadMetaData(
          key: '_billing_wooccm12',
          value: checkoutProvider.dni,
        ),
        WooOrderPayloadMetaData(
          key: '_billing_wooccm17',
          value: checkoutProvider.latLng.latitude.toString(),
        ),
        WooOrderPayloadMetaData(
          key: '_billing_wooccm18',
          value: checkoutProvider.latLng.longitude.toString(),
        ),
        WooOrderPayloadMetaData(
          key: '_shipping_wooccm10',
          value: checkoutProvider.deliveryLatLng != null
              ? checkoutProvider.latLng.latitude.toString()
              : checkoutProvider.latLng.latitude.toString(),
        ),
        WooOrderPayloadMetaData(
          key: '_shipping_wooccm11',
          value: checkoutProvider.deliveryLatLng != null
              ? checkoutProvider.latLng.longitude.toString()
              : checkoutProvider.latLng.longitude.toString(),
        ),
      ],
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
        address1: checkoutProvider.deliveryAddress ?? checkoutProvider.address,
        city: 'Lima',
        country: 'PE',
        firstName: checkoutProvider.deliveryName ?? checkoutProvider.name,
        lastName:
            checkoutProvider.deliveryLastName ?? checkoutProvider.lastName,
        state: checkoutProvider.deliveryDistrict != null
            ? checkoutProvider.getDeliveryDistrictCode()
            : checkoutProvider.getDistrictCode(),
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
    return order;
  }

  String _emptyValidate(String s) {
    if (s.isEmpty || s == '') return ErrorsCommon.required;
    return null;
  }
}
