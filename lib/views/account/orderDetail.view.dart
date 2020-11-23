import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wc_app/components/summaryLine.component.dart';
import 'package:woocommerce/woocommerce.dart';
import 'package:intl/intl.dart';

class OrderDetailView extends StatelessWidget {
  final WooOrder order;

  OrderDetailView({Key key, this.order}) : super(key: key);

  final DateFormat _format = DateFormat.yMd('es');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Orden #${order.id}'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Esta orden fue ingresada el ${_format.format(DateTime.parse(order.dateCreated))}, y se encuentra en estado ${order.status}',
                style: TextStyle(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: order.lineItems
                    .map((e) => ListTile(
                          title: Text.rich(
                            TextSpan(
                              text: e.name,
                              children: <TextSpan>[
                                TextSpan(
                                  text: ' x${e.quantity}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                          ),
                          trailing: Text('S/${e.total}'),
                        ))
                    .toList(),
              ),
            ),
            order.couponLines.length > 0
                ? Column(children: <Widget>[
                    SummaryLineComponent(
                      title: 'Subtotal:',
                      summary: 'S/' +
                          (double.parse(order.total) +
                                  double.parse(order.discountTotal) -
                                  double.parse(order.shippingTotal))
                              .toStringAsFixed(2),
                    ),
                    SummaryLineComponent(
                      title: 'Descuento:',
                      summary: '- S/' + order.discountTotal,
                    ),
                    SummaryLineComponent(
                      title: 'Envío:',
                      summary: 'S/' + order.shippingTotal,
                    ),
                    SummaryLineComponent(
                      title: 'Total:',
                      summary: 'S/' + order.total,
                    ),
                  ])
                : Column(
                    children: [
                      SummaryLineComponent(
                        title: 'Subtotal:',
                        summary: 'S/' +
                            (double.parse(order.total) -
                                    double.parse(order.shippingTotal))
                                .toStringAsFixed(2),
                      ),
                      SummaryLineComponent(
                        title: 'Envío:',
                        summary: 'S/' + order.shippingTotal,
                      ),
                      SummaryLineComponent(
                        title: 'Total:',
                        summary: 'S/' + order.total,
                      ),
                    ],
                  ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Datos de facturación',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
              child:
                  Text(order.billing.firstName + ' ' + order.billing.lastName),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
              child: Text(order.billing.address1),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
              child: Text(order.billing.city),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
              child: Text(order.billing.country),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
              child: Text(order.billing.phone),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
              child: Text(order.billing.email),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Datos de delivery',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
              child:
                  Text(order.shipping.firstName + ' ' + order.billing.lastName),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
              child: Text(order.shipping.address1),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
              child: Text(order.shipping.city),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
              child: Text(order.billing.country),
            ),
          ],
        ),
      ),
    );
  }
}
