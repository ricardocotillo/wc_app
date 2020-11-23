import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:wc_app/common/errors.common.dart';
import 'package:wc_app/components/input.component.dart';
import 'package:wc_app/providers/checkout.provider.dart';
import 'package:wc_app/providers/customer.provider.dart';
import 'package:wc_app/views/checkout/pay.view.dart';

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

  final GlobalKey<InputComponentState> _nameKey =
      GlobalKey<InputComponentState>();
  final GlobalKey<InputComponentState> _lastNameKey =
      GlobalKey<InputComponentState>();
  final GlobalKey<InputComponentState> _phoneKey =
      GlobalKey<InputComponentState>();
  final GlobalKey<InputComponentState> _emailKey =
      GlobalKey<InputComponentState>();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _lastNameController.dispose();
    _idNumberController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final CheckoutProvider _checkoutProvider =
        Provider.of<CheckoutProvider>(context);
    final CustomerProvider _customerProvider =
        Provider.of<CustomerProvider>(context);

    _nameController.text = _customerProvider.customer.firstName;
    _lastNameController.text = _customerProvider.customer.lastName;
    _emailController.text = _customerProvider.customer.email;
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
              _phoneKey.currentState.validate() &&
              _emailKey.currentState.validate()) {
            _checkoutProvider.name = _nameController.text;
            _checkoutProvider.lastName = _lastNameController.text;
            _checkoutProvider.phone = _phoneController.text;
            _checkoutProvider.email = _emailController.text;
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PayView(),
              ),
            );
          }
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
}
