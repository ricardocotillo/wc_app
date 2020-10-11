import 'package:flutter/material.dart';

void showLoading(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    child: Dialog(
      child: Theme(
        data: ThemeData(
          accentColor: Color(0xFF003E45),
          backgroundColor: Colors.white,
        ),
        child: LinearProgressIndicator(),
      ),
    ),
  );
}

showSnackBar({
  @required BuildContext context,
  @required String msg,
  SnackBarType type = SnackBarType.info,
}) {
  Color background = type == SnackBarType.info
      ? Colors.blue
      : type == SnackBarType.danger ? Colors.red : Colors.green;
  Scaffold.of(context).showSnackBar(SnackBar(
    backgroundColor: background,
    content: Text(
      msg,
      style: TextStyle(
        color: Colors.white,
      ),
    ),
  ));
}

enum SnackBarType {
  success,
  danger,
  info,
}

String getFormattedPrice(String price) {
  return 'S/' + double.parse(price).toStringAsFixed(2);
}
