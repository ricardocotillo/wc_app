import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:html/parser.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wc_app/common/errors.common.dart';
import 'package:wc_app/common/functions.common.dart';
import 'package:wc_app/components/button.component.dart';
import 'package:wc_app/components/input.component.dart';
import 'package:wc_app/providers/customer.provider.dart';
import 'package:wc_app/views/auth/register.view.dart';

class LoginView extends StatelessWidget {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  final GlobalKey<InputComponentState> _emailKey =
      GlobalKey<InputComponentState>();
  final GlobalKey<InputComponentState> _passKey =
      GlobalKey<InputComponentState>();

  final String passURL =
      'https://dev.bp-peru.com/my-account/lost-password/?trust=yes';
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final CustomerProvider _customerProvider =
        Provider.of<CustomerProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              'assets/logos/logo_original.png',
              width: size.width / 1.8,
            ),
            InputComponent(
              key: _emailKey,
              validator: _userValidator,
              controller: _userController,
              hint: 'Nombre de usuario',
            ),
            InputComponent(
              key: _passKey,
              validator: _passValidator,
              controller: _passController,
              hint: 'Contraseña',
              isPassword: true,
            ),
            Builder(
              builder: (context) => ButtonComponent(
                title: 'Ingresar',
                onPressed: () async {
                  if (_emailKey.currentState.validate() &&
                      _passKey.currentState.validate()) {
                    showLoading(context);
                    String error = await _customerProvider.loginCustomer(
                        _userController.text, _passController.text);
                    Navigator.of(context).pop();
                    if (_customerProvider.customer == null) {
                      showSnackBar(
                        context: context,
                        msg: parse(error).documentElement.text,
                        type: SnackBarType.danger,
                      );
                      return;
                    }
                    await _customerProvider.checkAuthentication();
                    Navigator.pop(context);
                  }
                },
              ),
            ),
            SizedBox(
              height: 30,
            ),
            FlatButton(
              onPressed: () {
                launch(passURL);
              },
              child: Text(
                '¿Olvidaste tu contraseña?',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            FlatButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => RegisterView(),
                ));
              },
              child: Text(
                '¿No tienes una cuenta?',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _userValidator(String str) {
    if (str.isEmpty) {
      return ErrorsCommon.required;
    }
    return null;
  }

  String _passValidator(String str) {
    if (str.isEmpty) {
      return ErrorsCommon.required;
    }
    return null;
  }
}
