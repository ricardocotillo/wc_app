import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:wc_app/providers/cart.provider.dart';
import 'package:wc_app/providers/customer.provider.dart';
import 'package:wc_app/providers/mainView.provider.dart';
import 'package:wc_app/views/home.view.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.wait([
      Provider.of<MainViewProvider>(context).getCategories(),
      Provider.of<MainViewProvider>(context).getProducts(),
      Provider.of<CartProvider>(context).getCartData(),
      Provider.of<CustomerProvider>(context).checkAuthentication(),
    ]).then((_) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => HomeView(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: size.width,
          ),
          Image.asset(
            'assets/logos/logo_negativo.png',
            width: 100,
            height: 100,
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 150,
            height: 2,
            child: LinearProgressIndicator(),
          )
        ],
      ),
    );
  }
}
