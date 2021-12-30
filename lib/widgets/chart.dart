
import 'package:flutter/material.dart';
import 'package:personal_expense/models/transition.dart';
import 'package:intl/intl.dart';
import 'package:personal_expense/widgets/barChart.dart';

class Chart extends StatelessWidget {
  final List<Transition> transitionList;
   Chart(this.transitionList);

  List<Map<String,Object>> get groupTransacitonValue{

    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;
      for (int i  = 0 ;i<transitionList.length; i++){
        if(weekday.day == transitionList[i].dateTime.day
        &&weekday.month == transitionList[i].dateTime.month
        &&weekday.year == transitionList[i].dateTime.year){
          totalSum = totalSum + transitionList[i].amount;

        }
      }
      print(DateFormat.E().format(weekday).toString()+"  "+index.toString());
      return {'day':DateFormat.E().format(weekday).substring(0,1),'amount':totalSum};
    }).reversed.toList();
   }
   double get totalSpendingAmount{
          return groupTransacitonValue.fold(0.0, (sum, item) {
            return sum+item['amount'];
          });
  }

  @override
  Widget build(BuildContext context) {
    //print(groupTransacitonValue.toString());
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),

      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: groupTransacitonValue.map((date) {
            return Flexible(
              fit:FlexFit.tight,
              child: BarChart(date['day'], date['amount'],
                  totalSpendingAmount == 0.0?0.0:(date['amount'] as double)/totalSpendingAmount),
            );
          }).toList()
        ),
      ),
    );
  }
}
