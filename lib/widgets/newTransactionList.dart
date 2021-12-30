import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NewTransactionList extends StatefulWidget {
  Function addTransaction;

  NewTransactionList(this.addTransaction);

  @override
  _NewTransactionListState createState() => _NewTransactionListState();
}

class _NewTransactionListState extends State<NewTransactionList> {
  final titleController = TextEditingController();

  final amountInputController = TextEditingController();
  DateTime _dateTime;

  void addValidTransaction() {
    var title = titleController.text;
    var amount = double.parse(amountInputController.text);

    if (title.isEmpty || amount < 0) {
      return;
    }
    widget.addTransaction(
        titleController.text, double.parse(amountInputController.text),_dateTime);
    Navigator.of(context).pop();
  }
  void _pickedDateTime(){
    showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2019),
        lastDate:DateTime.now()).then((pickeDate){
         if(pickeDate == null){
           return;
         }
         setState(() {
           _dateTime = pickeDate;
         });

    } );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
                decoration: InputDecoration(labelText: "Title"),
                controller: titleController,
                keyboardType: TextInputType.text,
                onSubmitted: (_) => addValidTransaction()),
            TextField(
              decoration: InputDecoration(labelText: "Amount"),
              controller: amountInputController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => addValidTransaction(),
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Text(_dateTime == null? "No date choose":'Picked Date:${DateFormat.yMd().format(_dateTime)}'),
                  FlatButton(
                    onPressed:  _pickedDateTime,
                    child: Text(
                      "Choose Date",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            RaisedButton(
              onPressed: () {
                addValidTransaction();
              },
              color: Theme.of(context).primaryColor,
              child: Text("Add Transaction"),
              textColor: Theme.of(context).textTheme.button.color,
            )
          ],
        ),
      ),
    );
  }
}
