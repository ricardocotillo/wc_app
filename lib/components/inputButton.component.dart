import 'package:flutter/material.dart';

class InputButtonComponent extends StatelessWidget {
  final String placeHolder;
  final VoidCallback onClick;
  final double width;
  final TextEditingController controller;

  const InputButtonComponent(
      {Key key,
      @required this.placeHolder,
      @required this.onClick,
      @required this.width,
      @required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      width: width,
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[400].withOpacity(0.3),
                  blurRadius: 8.0,
                  offset: Offset(0.0, 8.0),
                )
              ],
            ),
            height: 38,
            width: width - 40,
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: placeHolder,
              ),
            ),
          ),
          Positioned(
            right: 5,
            child: InkWell(
              onTap: onClick,
              child: Container(
                height: 38,
                width: 38,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(19)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[400].withOpacity(0.3),
                      blurRadius: 8.0,
                      offset: Offset(0.0, 8.0),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
