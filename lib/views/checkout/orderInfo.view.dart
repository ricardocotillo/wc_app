import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wc_app/views/home.view.dart';

class OrderInfoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
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
              'Gracias, tu orden ha sido recibida.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Tap para regresar al inicio',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
              ),
            ),
            FlatButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => HomeView(),
                ));
              },
              child: Text('Volver'),
            ),
          ],
        ),
      ),
    );
  }
}
