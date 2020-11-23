import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wc_app/providers/cart.provider.dart';
import 'package:wc_app/providers/checkout.provider.dart';
import 'package:wc_app/providers/customer.provider.dart';
import 'package:wc_app/providers/mainView.provider.dart';
import 'package:wc_app/views/splash/splash.view.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox<String>('cart');
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<CustomerProvider>(
        create: (_) => CustomerProvider(),
      ),
      ChangeNotifierProvider<CartProvider>(
        create: (_) => CartProvider(),
      ),
      Provider<MainViewProvider>(
        create: (_) => MainViewProvider(),
      ),
      Provider<CheckoutProvider>(
        create: (_) => CheckoutProvider(),
      )
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Woocommerce app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.ralewayTextTheme(),
        appBarTheme: AppBarTheme(
          color: Color(0xFF003e45),
        ),
        primaryColor: Color(0xFF003E45),
        colorScheme: ColorScheme(
          primary: Color(0xFF003E45),
          primaryVariant: Color(0xFFBA9A69),
          secondary: Color(0xFF4E686E),
          secondaryVariant: Color(0xFFCBB189),
          surface: Colors.white,
          background: Colors.white,
          error: Colors.red,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Color(0xFF003E45),
          onBackground: Color(0xFF003E45),
          onError: Colors.red,
          brightness: Brightness.light,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashView(),
    );
  }
}
