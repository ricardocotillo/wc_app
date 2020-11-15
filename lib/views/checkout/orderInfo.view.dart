import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OrderInfoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Column(
          children: [
            Icon(Icons.check_box),
            Text('Gracias, tu orden ha sido recibida'),
          ],
        ),
      ),
    );
  }
}
