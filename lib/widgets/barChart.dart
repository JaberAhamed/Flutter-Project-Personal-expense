import 'package:flutter/material.dart';

class BarChart extends StatelessWidget {
  final String label;
  final double amount;
  final double spandingAmount;

   BarChart( this.label, this.amount, this.spandingAmount);

  @override
  Widget build(BuildContext context) {
    print(spandingAmount.toString());
    return LayoutBuilder(builder:(context,constraints){
      return Column(
        children: [
          Container(
              height: constraints.maxHeight*0.15,
              child: FittedBox(child: Text('\$${amount.toStringAsFixed(0)}'))),
          SizedBox(height: constraints.maxHeight*0.05,),
          Container(
            height:constraints.maxHeight*0.6,
            width: 10.0,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey,width: 1.0),
                    color: Color.fromARGB(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(10),

                  ),

                ),
                FractionallySizedBox(heightFactor: spandingAmount,
                  child:Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10)
                    ),
                  ),
                )
              ],
            ),

          ),
          SizedBox(height: constraints.maxHeight*0.05,),
          Container(
              height: constraints.maxHeight*0.15,
              child: FittedBox(
                child: Text(label),
              ))
        ],
      );
    });
  }
}
