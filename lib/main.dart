import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense/models/transition.dart';
import 'package:personal_expense/widgets/chart.dart';
import 'package:personal_expense/widgets/newTransactionList.dart';
import 'package:personal_expense/widgets/transaction_list.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal expense ',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
          headline6: TextStyle(
            fontFamily: 'Quicksand',
            fontWeight: FontWeight.normal,
            fontSize: 18,
          ),
          button:TextStyle(color: Colors.white),
        ),

        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
          headline6: TextStyle(
          fontFamily: 'OpenSans',
          fontWeight: FontWeight.bold,
          fontSize: 18
        )
      )
      )


      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transition>_transition = [
    /*Transition(id: "12", title: "Cost", amount: 12.9, dateTime: DateTime.now()),
    Transition(id: "13", title: "Lost", amount: 14.9, dateTime: DateTime.now())*/
  ] ;

  List<Transition> get recentTransaction {
     return _transition.where((tx){
       return tx.dateTime.isAfter(DateTime.now().subtract(Duration(days: 7)));
     }).toList();
  }

  void _addTransaction(String title,double amount,DateTime selectDate){
    final tx = Transition(id: DateTime.now().toString(),
        title: title, amount: amount, dateTime: selectDate);
    setState(() {
      _transition.add(tx);
      print(_transition.length.toString());
    });

  }
  void _deleteTransaction(String id){
    setState(() {
      _transition.removeWhere((tx) => tx.id == id );
    });
  }
  void _showNewTransacitoninBottom(BuildContext ctx){
    showModalBottomSheet(context: ctx, builder: (_){
      return GestureDetector(
          onTap:(){} ,
          child: NewTransactionList(_addTransaction),
          behavior: HitTestBehavior.opaque,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Personal expense calculate"),

          actions: [
            IconButton(icon: Icon(Icons.add) , onPressed:  () => _showNewTransacitoninBottom(context))
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Chart(recentTransaction),
              TransactionList(_transition,_deleteTransaction)

            ],

          ),
        ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(child:Icon(Icons.add),onPressed: ()=> _showNewTransacitoninBottom(context),),
    );
  }
}
