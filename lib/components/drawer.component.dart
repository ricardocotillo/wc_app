import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wc_app/config/wc.config.dart';
import 'package:wc_app/providers/customer.provider.dart';
import 'package:wc_app/views/account/account.view.dart';
import 'package:wc_app/views/auth/login.view.dart';

class DrawerComponent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CustomerProvider _customerProvider = Provider.of<CustomerProvider>(context);
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Image.asset(
              'assets/logos/logo_original.png',
              width: 70,
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Inicio'),
            ),
            if (_customerProvider.isLoggedIn)
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('Mis datos'),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AccountView(),
                  ));
                },
              ),
            if (_customerProvider.isLoggedIn)
              ListTile(
                leading: Icon(Icons.history),
                title: Text('Historial'),
              ),
            _customerProvider.isLoggedIn
                ? ListTile(
                    leading: Icon(Icons.exit_to_app),
                    title: Text('Salir'),
                    onTap: () {
                      woocommerce.logUserOut();
                      _customerProvider.isLoggedIn = false;
                      Navigator.pop(context);
                    },
                  )
                : ListTile(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => LoginView(),
                    )),
                    leading: Icon(
                      FontAwesomeIcons.userAlt,
                      size: 18,
                    ),
                    title: Text('Ingresar'),
                  ),
          ],
        ),
      ),
    );
  }
}
