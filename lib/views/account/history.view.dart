import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:wc_app/config/wc.config.dart';
import 'package:wc_app/providers/customer.provider.dart';
import 'package:wc_app/views/account/orderDetail.view.dart';
import 'package:woocommerce/woocommerce.dart';
import 'package:intl/intl.dart';

class HistoryView extends StatefulWidget {
  @override
  _HistoryViewState createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  Future<List<WooOrder>> _future;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _future = woocommerce.getOrders(
        customer: Provider.of<CustomerProvider>(context).customer.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historial'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: _future,
        builder: (BuildContext context, AsyncSnapshot<List<WooOrder>> snap) {
          switch (snap.connectionState) {
            case ConnectionState.done:
              List<WooOrder> orders = snap.data;
              return ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, int i) => ListTile(
                  title: Text(
                    '#' +
                        orders[i].id.toString() +
                        ' - ' +
                        DateFormat.yMd('es')
                            .format(DateTime.parse(orders[i].dateCreated)),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(orders[i].status),
                  trailing: IconButton(
                    icon: Icon(Icons.keyboard_arrow_right),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OrderDetailView(
                              order: orders[i],
                            ),
                          ));
                    },
                  ),
                ),
              );
              break;
            default:
              return Center(
                child: CircularProgressIndicator(),
              );
          }
        },
      ),
    );
  }
}
