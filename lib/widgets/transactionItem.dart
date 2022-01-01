import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense/models/transition.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key key,
    @required this.transition,
    @required this.deleteTransacion,
  }) : super(key: key);

  final Transition transition;
  final Function deleteTransacion;

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  var _bgColor;
  @override
  void initState() {
    const availaibleColor =[
      Colors.red,
      Colors.amber,
      Colors.purple,
      Colors.blue
    ];
    _bgColor = availaibleColor[Random().nextInt(4)];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:_bgColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(
              child: Text(widget.transition.amount.toStringAsFixed(2)),
            ),
          ),
        
        ),
        title: Text(
          widget.transition.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(widget.transition.dateTime),
          style: TextStyle(color: Colors.grey),
        ),
        trailing: MediaQuery.of(context).size.width > 360
            ? FlatButton.icon(
                onPressed: () => widget.deleteTransacion(widget.transition.id),
                icon: const Icon(Icons.delete),
                textColor: Theme.of(context).errorColor,
                label: const Text("Delete"))
            : IconButton(
                icon: const Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () => widget.deleteTransacion(widget.transition.id),
              ),
      ),
    );
  }
}
