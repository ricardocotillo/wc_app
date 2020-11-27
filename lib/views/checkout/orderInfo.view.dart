import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wc_app/views/home.view.dart';
import 'package:woocommerce/woocommerce.dart';

class OrderInfoView extends StatelessWidget {
  final WooOrder order;

  const OrderInfoView({Key key, this.order}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String orderNumber = order.metaData
        .firstWhere((element) => element.key == '_order_number')
        .value;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.check,
              color: Colors.white,
              size: 50,
            ),
            Text(
              'Gracias, tu orden #$orderNumber ha sido recibida.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Tap para regresar al inicio',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontStyle: FontStyle.italic,
              ),
            ),
            RaisedButton(
              color: Theme.of(context).colorScheme.primaryVariant,
              elevation: 1,
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => HomeView(),
                ));
              },
              child: Text(
                'Volver',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
