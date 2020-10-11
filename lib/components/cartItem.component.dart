import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:woocommerce/models/cart.dart';

class CartItemComponent extends StatefulWidget {
  final WooCartItems item;
  final Function(int quantity) onChangeQuantity;
  // final Function() onAddToFav;
  final Function() onRemoveFromCart;
  final bool orderComplete;

  const CartItemComponent(
      {Key key,
      @required this.item,
      @required this.onChangeQuantity,
      // @required this.onAddToFav,
      @required this.onRemoveFromCart,
      this.orderComplete = false})
      : super(key: key);

  @override
  _CartItemComponentState createState() => _CartItemComponentState();
}

class _CartItemComponentState extends State<CartItemComponent> {
  bool showPopup = false;

  @override
  Widget build(BuildContext context) {
    var _theme = Theme.of(context);
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4.0 * 2),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[200].withOpacity(0.3),
                  blurRadius: 8,
                  offset: Offset(0.0, 8))
            ],
            color: Colors.white),
        child: Stack(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 104,
                  child: CachedNetworkImage(
                    imageUrl: widget.item.images[0].src,
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(left: 15),
                    width: width - 134,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                width: width - 200,
                                child: Text(
                                  widget.item.name,
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: _theme.colorScheme.primary,
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(FontAwesomeIcons.times),
                                iconSize: 14,
                                color: Colors.red,
                                onPressed: widget.onRemoveFromCart,
                              )
                            ],
                          ),
                          Padding(padding: EdgeInsets.only(bottom: 4.0 * 2)),
                          Padding(
                            padding: EdgeInsets.only(bottom: 4.0 * 2),
                          ),
                          Row(children: <Widget>[
                            widget.onChangeQuantity != null
                                ? Container(
                                    width: 120,
                                    child: Row(
                                      children: <Widget>[
                                        InkWell(
                                            onTap: () => {
                                                  widget.onChangeQuantity(
                                                      widget.item.quantity - 1)
                                                },
                                            child: Container(
                                                alignment: Alignment.center,
                                                width: 36,
                                                height: 36,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            18),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Colors
                                                              .grey[200]
                                                              .withOpacity(0.3),
                                                          blurRadius: 8,
                                                          offset:
                                                              Offset(0.0, 8))
                                                    ]),
                                                child: Icon(Icons.remove))),
                                        Container(
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.all(4.0 * 2),
                                          child: Text(
                                            widget.item.quantity.toString(),
                                          ),
                                        ),
                                        InkWell(
                                            onTap: (() => {
                                                  widget.onChangeQuantity(
                                                      widget.item.quantity + 1)
                                                }),
                                            child: Container(
                                                alignment: Alignment.center,
                                                width: 36,
                                                height: 36,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            18),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color: Colors
                                                              .grey[200]
                                                              .withOpacity(0.3),
                                                          blurRadius: 8,
                                                          offset:
                                                              Offset(0.0, 8))
                                                    ]),
                                                child: Icon(Icons.add))),
                                      ],
                                    ),
                                  )
                                : Container(
                                    width: 110,
                                    child: Row(children: <Widget>[
                                      Text('Units: '),
                                      Text(widget.item.quantity.toString(),
                                          style: _theme.textTheme.body1
                                              .copyWith(
                                                  color: _theme.primaryColor)),
                                    ])),
                            Container(
                              width: width - 280,
                              alignment: Alignment.centerRight,
                              child: Text(
                                'S/' + (widget.item.price),
                              ),
                            )
                          ])
                        ]))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
