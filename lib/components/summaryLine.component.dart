import 'package:flutter/material.dart';

class SummaryLineComponent extends StatelessWidget {
  final String title;
  final String summary;

  const SummaryLineComponent({Key key, this.title, this.summary})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width - 15.0 * 2;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 4.0),
      child: Row(
        children: <Widget>[
          Container(
            width: width / 2,
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            width: width / 2,
            child: Text(
              summary,
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
