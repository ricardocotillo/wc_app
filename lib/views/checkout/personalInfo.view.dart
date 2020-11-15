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

class PersonalInfoView extends StatefulWidget {
  @override
  _PersonalInfoViewState createState() => _PersonalInfoViewState();
}

class _PersonalInfoViewState extends State<PersonalInfoView> {
  final TextEditingController _nameController = TextEditingController(),
      _lastNameController = TextEditingController(),
      _idNumberController = TextEditingController(),
      _phoneController = TextEditingController(),
      _emailController = TextEditingController();

  int _idType;

  final GlobalKey<InputComponentState> _nameKey =
      GlobalKey<InputComponentState>();
  final GlobalKey<InputComponentState> _lastNameKey =
      GlobalKey<InputComponentState>();
  final GlobalKey<InputComponentState> _idNumKey =
      GlobalKey<InputComponentState>();
  final GlobalKey<InputComponentState> _phoneKey =
      GlobalKey<InputComponentState>();
  final GlobalKey<InputComponentState> _emailKey =
      GlobalKey<InputComponentState>();

  @override
  Widget build(BuildContext context) {
    final CheckoutProvider _checkoutProvider =
        Provider.of<CheckoutProvider>(context);
    final CartProvider _cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Informacion personal'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () {
          if (_nameKey.currentState.validate() &&
              _lastNameKey.currentState.validate() &&
              _idNumKey.currentState.validate() &&
              _phoneKey.currentState.validate() &&
              _emailKey.currentState.validate()) {
            _checkoutProvider.name = _nameController.text;
            _checkoutProvider.lastName = _lastNameController.text;
            _checkoutProvider.idNum = _idNumberController.text;
            _checkoutProvider.phone = _phoneController.text;
            _checkoutProvider.email = _emailController.text;
          }
          sendOrders(_cartProvider, _checkoutProvider);
        },
      ),
      body: SafeArea(
        child: Form(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 20,
              ),
              InputComponent(
                key: _nameKey,
                validator: _emptyValidate,
                controller: _nameController,
                hint: 'Nombre',
              ),
              InputComponent(
                key: _lastNameKey,
                validator: _emptyValidate,
                controller: _lastNameController,
                hint: 'Apellidos',
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(
              //     horizontal: 18.0,
              //     vertical: 10.0,
              //   ),
              //   child: DropdownButtonFormField(
              //     hint: Text('Tipo de Documento'),
              //     items: <DropdownMenuItem<int>>[
              //       DropdownMenuItem<int>(
              //         child: Text('DNI'),
              //         value: 0,
              //       ),
              //       DropdownMenuItem<int>(
              //         child: Text('Carnet de Extranjería'),
              //         value: 1,
              //       ),
              //       DropdownMenuItem<int>(
              //         child: Text('Pasaporte'),
              //         value: 2,
              //       ),
              //     ],
              //     onChanged: (int v) {
              //       setState(() {
              //         _idType = v;
              //       });
              //     },
              //     value: _idType,
              //   ),
              // ),
              // InputComponent(
              //   key: _idNumKey,
              //   validator: _emptyValidate,
              //   controller: _idNumberController,
              //   hint: 'Número de Documento',
              //   keyboard: TextInputType.number,
              // ),
              InputComponent(
                key: _phoneKey,
                validator: _emptyValidate,
                controller: _phoneController,
                hint: 'Teléfono',
                keyboard: TextInputType.phone,
              ),
              InputComponent(
                key: _emailKey,
                validator: _emptyValidate,
                controller: _emailController,
                hint: 'Dirección de Correo',
                keyboard: TextInputType.emailAddress,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _emptyValidate(String s) {
    if (s.isEmpty || s == '') return ErrorsCommon.required;
    return null;
  }

  void sendOrders(
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
    woocommerce.createOrder(orderPayload);
  }
}
