import 'dart:html';

import 'package:flutter/material.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import 'models/transaction.dart';
import 'widgets/chart.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //   [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp],
  // );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyText1: TextStyle(fontFamily: 'OpenSans', fontSize: 18),
            button: TextStyle(fontFamily: 'OpenSans', color: Colors.white)),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  bool _showChart = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
  }

  //clearing life cycle listeners
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    // TODO: implement dispose
    super.dispose();
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) => GestureDetector(
        child: NewTransaction(_addNewTransaction),
        onTap: () => {},
        behavior: HitTestBehavior.opaque,
      ),
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((transaction) => transaction.id == id);
    });
  }

  final List<Transaction> _userTransaction = [
    // Transaction(
    //   id: 't1',
    //   title: 'New shoes',
    //   amount: 25400,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't1',
    //   title: 'Virág szerelmemnek',
    //   amount: 5400,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't1',
    //   title: 'Telefon',
    //   amount: 254000,
    //   date: DateTime.now(),
    // )
  ];

  List<Transaction> get _recentTransactions {
    return _userTransaction.where(
      (transaction) {
        return transaction.date.isAfter(
          DateTime.now().subtract(Duration(days: 7)),
        );
      },
    ).toList();
  }

  void _addNewTransaction(String txTitle, double amount, DateTime date) {
    final newTransaction = Transaction(
      title: txTitle,
      amount: amount,
      date: date,
      id: DateTime.now().toString(),
    );
    setState(() {
      _userTransaction.add(newTransaction);
    });
  }

  List<Widget> _buildLandscapeContent(MediaQueryData mediaQueryData,
      AppBar appBar, Widget transactionListWidget) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Show Chart'),
          Switch.adaptive(
            value: _showChart,
            onChanged: (val) {
              setState(() {
                _showChart = val;
              });
            },
          )
        ],
      ),
      _showChart
          ? Container(
              height: (mediaQueryData.size.height -
                      appBar.preferredSize.height -
                      mediaQueryData.padding.top) *
                  0.7,
              child: Chart(_userTransaction))
          : transactionListWidget
    ];
  }

  List<Widget> _buildPortraitContent(
      MediaQueryData mediaQueryData, AppBar appBar, Widget txList) {
    return [
      Container(
          height: (mediaQueryData.size.height -
                  appBar.preferredSize.height -
                  mediaQueryData.padding.top) *
              0.3,
          child: Chart(_userTransaction)),
      txList
    ];
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuuery = MediaQuery.of(context);
    final isLandscape = mediaQuuery.orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text(
        'Personal Expenses',
      ),
      actions: [
        IconButton(
            onPressed: () => _startAddNewTransaction(context),
            icon: Icon(Icons.add))
      ],
    );

    var transactionListWidget = Container(
      child: TransactionList(_userTransaction, _deleteTransaction),
      height: (mediaQuuery.size.height -
              appBar.preferredSize.height -
              mediaQuuery.padding.top) *
          0.7,
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isLandscape)
              ..._buildLandscapeContent(
                  mediaQuuery, appBar, transactionListWidget),
            if (!isLandscape)
              ..._buildPortraitContent(
                  mediaQuuery, appBar, transactionListWidget),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
