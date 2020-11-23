import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:wc_app/common/functions.common.dart';
import 'package:wc_app/providers/customer.provider.dart';
import 'package:woocommerce/woocommerce.dart';

class AccountView extends StatefulWidget {
  @override
  _AccountViewState createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _enabled = false;
  final TextEditingController _nameController = TextEditingController(),
      _lastNameController = TextEditingController(),
      _usernameController = TextEditingController(),
      _emailController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _lastNameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final CustomerProvider _customerProvider =
        Provider.of<CustomerProvider>(context);
    _nameController.text = _customerProvider.customer.firstName;
    _lastNameController.text = _customerProvider.customer.lastName;
    _usernameController.text = _customerProvider.customer.username;
    _emailController.text = _customerProvider.customer.email;
    return Scaffold(
      floatingActionButton: _enabled
          ? Builder(
              builder: (context) => FloatingActionButton(
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    showLoading(context);
                    WooCustomer customer = WooCustomer(
                      firstName: _nameController.text,
                      lastName: _lastNameController.text,
                      username: _usernameController.text,
                      email: _emailController.text,
                    );
                    await _customerProvider.updateCustomer(customer);
                    Navigator.of(context).pop();
                    showSnackBar(
                      context: context,
                      msg: 'Datos actualizados',
                      type: SnackBarType.success,
                    );
                  }
                },
                child: Icon(Icons.save_rounded),
              ),
            )
          : null,
      appBar: AppBar(
        title: Text('Mis datos'),
        centerTitle: true,
        actions: [
          !_enabled
              ? IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    setState(() {
                      _enabled = true;
                    });
                  },
                )
              : IconButton(
                  icon: Icon(Icons.edit_off),
                  onPressed: () {
                    setState(() {
                      _enabled = false;
                    });
                  },
                ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                validator: emptyValidate,
                decoration: InputDecoration(
                  labelText: 'Nombre',
                ),
                keyboardType: TextInputType.name,
                enabled: _enabled,
              ),
              TextFormField(
                controller: _lastNameController,
                validator: emptyValidate,
                decoration: InputDecoration(
                  labelText: 'Apellidos',
                ),
                keyboardType: TextInputType.name,
                enabled: _enabled,
              ),
              TextFormField(
                controller: _usernameController,
                validator: emptyValidate,
                decoration: InputDecoration(
                  labelText: 'Nombre de usuario',
                ),
                enabled: _enabled,
              ),
              TextFormField(
                controller: _emailController,
                validator: emptyValidate,
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
                keyboardType: TextInputType.emailAddress,
                enabled: _enabled,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
