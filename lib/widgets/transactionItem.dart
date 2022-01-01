
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense/models/transition.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required this.transition,
    @required this.deleteTransacion,
  }) : super(key: key);

  final Transition transition;
  final Function deleteTransacion;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(
              child: Text(transition.amount.toStringAsFixed(2)),

            ),
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        title:Text(transition.title,style: Theme.of(context).textTheme.headline6,) ,
        subtitle: Text(DateFormat.yMMMd().format(transition.dateTime),style: TextStyle(color: Colors.grey),),
        trailing:MediaQuery.of(context).size.width > 360? FlatButton.icon
          (onPressed: () => deleteTransacion(transition.id),
            icon: const Icon(Icons.delete),
            textColor: Theme.of(context).errorColor,
            label: const Text("Delete")): IconButton(
          icon: const Icon(Icons.delete),
          color: Theme.of(context).errorColor,
          onPressed: () => deleteTransacion(transition.id),
        ),
      ),
    );
  }
}