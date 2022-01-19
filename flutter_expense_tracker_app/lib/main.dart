import 'package:flutter/material.dart';
import './transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<Transaction> transactions = [
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            color: Colors.blue,
            child: Container(
              width: double.infinity,
              child: Text('Is a CHART!'),
            ),
            elevation: 5,
          ),
          Card(
            child: Text('List of TX!'),
          )
        ],
      ),
    );
  }
}
