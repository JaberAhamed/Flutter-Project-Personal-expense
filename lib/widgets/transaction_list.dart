import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense/widgets/transactionItem.dart';
import '../models/transition.dart';

class TransactionList extends StatelessWidget {
  final List<Transition> transition;
  final Function deleteTransacion;
  TransactionList(this.transition,this.deleteTransacion);

  @override
  Widget build(BuildContext context) {
    return   Container(

      child:transition.isEmpty?LayoutBuilder(builder: (context,constraints){
        return Column(children: [
          Text("No transaction is not available",
              style:Theme.of(context).textTheme.headline6),
          Container(
              height: constraints.maxHeight* 0.6,
              child: Image.asset('asset/images/waiting.png'))
        ],);

      }) :ListView (
             children: transition.map((tex) {
      return TransactionItem(key :ValueKey(tex.id) ,transition: tex, deleteTransacion: deleteTransacion);
    }).toList(),
          /*Card(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).primaryColor,
                            width: 2,
                          )),
                      padding: EdgeInsets.all(10),
                      child: Text(
                        '${transition[index].amount.toStringAsFixed(2)}',
                        style:
                        TextStyle(color: Colors.purple, fontSize: 20.0),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transition[index].title,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      Text(
                        DateFormat().format(transition[index].dateTime),
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  )
                ],
              ),
            );*/


      ),
    );
  }
}


