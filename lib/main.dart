import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense/models/transition.dart';
import 'package:personal_expense/widgets/chart.dart';
import 'package:personal_expense/widgets/newTransactionList.dart';
import 'package:personal_expense/widgets/transaction_list.dart';


void main(){
 /* WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);*/
  runApp(MyApp());
}

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

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver{
  final List<Transition>_transition = [
    /*Transition(id: "12", title: "Cost", amount: 12.9, dateTime: DateTime.now()),
    Transition(id: "13", title: "Lost", amount: 14.9, dateTime: DateTime.now())*/
  ] ;

  List<Transition> get recentTransaction {
     return _transition.where((tx){
       return tx.dateTime.isAfter(DateTime.now().subtract(Duration(days: 7)));
     }).toList();
  }
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }
  @override
  void didChangeAppLifecycleChange(AppLifecycleState state){
    print(state);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
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


  List<Widget> _buildPortraitContent(MediaQueryData medeaQury,AppBar appbar,Widget textListWidget){
    return [Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Show Chart'),
        Switch(value:_stateChange, onChanged: (valuee){
          setState(() {
            _stateChange = valuee;
          });
        })
      ],
    ), _stateChange?  Container(
        height: (medeaQury.size.height - appbar.preferredSize.height
            - MediaQuery.of(context).padding.top)*0.7,
        child: Chart(recentTransaction)):textListWidget,];
  }

  List<Widget> _buildLandscapContent(MediaQueryData medeaQury,AppBar appbar,Widget textListWidget){
    return [
      Container(
          height: (medeaQury.size.height - appbar.preferredSize.height
              - MediaQuery.of(context).padding.top)*0.4,
          child: Chart(recentTransaction)),
      textListWidget,
    ];
  }

  var _stateChange = false;



  @override
  Widget build(BuildContext context) {
    final medeaQury = MediaQuery.of(context);
    final appbar = AppBar(
      title: Text("Personal expense calculate"),
      actions: [
        IconButton(icon: Icon(Icons.add) , onPressed:  () => _showNewTransacitoninBottom(context))
      ],
    );
    var textListWidget = Container(
        height: (MediaQuery.of(context).size.height - appbar.preferredSize.height
            - MediaQuery.of(context).padding.top)*0.6,
        child: TransactionList(_transition,_deleteTransaction));
    final isLandscap = MediaQuery.of(context).orientation == Orientation.landscape;

    return Scaffold(
        appBar: appbar,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [

              if(isLandscap) ..._buildPortraitContent(medeaQury,appbar,textListWidget),

             if(!isLandscap) ..._buildLandscapContent(medeaQury, appbar, textListWidget),



            ],

          ),
        ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        margin: EdgeInsets.only(bottom: 10),
        child: FloatingActionButton(
          child:Icon(Icons.add),onPressed: ()=> _showNewTransacitoninBottom(context),),
      ),
    );
  }
}
