import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionCard extends StatelessWidget {
  final Transaction _transaction;
  TransactionCard(this._transaction);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Text(
              "${_transaction.amount.toStringAsFixed(0)} Ft",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Theme.of(context).primaryColor),
            ),
            decoration: BoxDecoration(
                border: Border.all(
                    color: Theme.of(context).primaryColor, width: 2)),
            padding: EdgeInsets.all(5),
            width: 120,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _transaction.title,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Text(
                DateFormat.yMMMd().format(_transaction.date),
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: Theme.of(context).primaryColorLight,
                    fontSize: 14),
              )
            ],
          ),
        ],
      ),
    );
  }
}
