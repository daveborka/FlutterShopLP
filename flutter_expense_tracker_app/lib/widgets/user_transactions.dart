import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'new_transaction.dart';
import 'transaction_list.dart';

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _userTransaction = [
    Transaction(
      id: 't1',
      title: 'New shoes',
      amount: 25400,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't1',
      title: 'Virág szerelmemnek',
      amount: 5400,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't1',
      title: 'Telefon',
      amount: 254000,
      date: DateTime.now(),
    )
  ];

  void _addNewTransaction(String txTitle, double amount) {
    final newTransaction = Transaction(
      title: txTitle,
      amount: amount,
      date: DateTime.now(),
      id: DateTime.now().toString(),
    );
    setState(() {
      _userTransaction.add(newTransaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(_addNewTransaction),
        TransactionList(_userTransaction),
      ],
    );
  }
}
