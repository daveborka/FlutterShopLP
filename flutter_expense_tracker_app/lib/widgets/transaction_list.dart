import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/transaction.dart';
import 'package:flutter_complete_guide/widgets/transactionCard.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _userTransaction;
  final Function _deleteTransaction;
  TransactionList(this._userTransaction, this._deleteTransaction);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: _userTransaction.isEmpty
          ? Column(
              children: [
                Text(
                  'No transaction added yet.',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets\\images\\waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) =>
                  TransactionCard(_userTransaction[index], _deleteTransaction),
              itemCount: _userTransaction.length,
            ),
    );
  }
}
