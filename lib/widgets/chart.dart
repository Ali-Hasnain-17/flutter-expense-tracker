import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import './chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> transactions;

  Chart(this.transactions);

  List<Map<String, Object>> get transactionsWithDays {
    return List.generate(7, (index) {
      final day = DateTime.now().subtract(Duration(days: index));
      var amount = 0.0;

      for (var i = 0; i < transactions.length; i++) {
        if (transactions[i].date.day == day.day &&
            transactions[i].date.month == day.month &&
            transactions[i].date.year == day.year) {
          amount += transactions[i].amount;
        }
      }

      return {
        "day": DateFormat.E().format(day).substring(0, 1),
        "amount": amount,
      };
    }).reversed.toList();
  }

  double get totalAmount {
    return transactionsWithDays.fold(
      0.0,
      (total, data) => total += data["amount"],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(10.0),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: transactionsWithDays.map((data) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  data["day"],
                  data["amount"],
                  totalAmount == 0.0
                      ? 0.0
                      : (data["amount"] as double) / totalAmount),
            );
          }).toList(),
        ),
      ),
    );
  }
}
