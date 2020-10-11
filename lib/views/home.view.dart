import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:wc_app/components/appBar.component.dart';
import 'package:wc_app/components/drawer.component.dart';
import 'package:wc_app/components/product.component.dart';
import 'package:wc_app/providers/mainView.provider.dart';
import 'package:wc_app/views/category/category.view.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MainViewProvider _mvProvider = Provider.of<MainViewProvider>(context);
    return Scaffold(
      appBar: appBar('BP'),
      drawer: DrawerComponent(),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _mvProvider.categories
                  .map((c) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(CupertinoPageRoute(
                              builder: (context) => CategoryView(
                                category: c,
                              ),
                            ));
                          },
                          child: Chip(
                            elevation: 1.5,
                            visualDensity: VisualDensity.compact,
                            label: Text(c.name),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
          Expanded(
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
              ),
              itemCount: _mvProvider.featured.length,
              itemBuilder: (context, int i) => ProductCompoent(
                product: _mvProvider.featured[i],
              ),
            ),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
