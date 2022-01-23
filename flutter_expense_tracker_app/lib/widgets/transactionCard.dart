import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionCard extends StatelessWidget {
  final Transaction _transaction;
  final Function _deletTransaction;
  TransactionCard(this._transaction, this._deletTransaction);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      elevation: 8,
      child: ListTile(
        leading: CircleAvatar(
            radius: 30,
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: FittedBox(
                  child: Text("${_transaction.amount.toStringAsFixed(0)} Ft")),
            )),
        title: Text(
          _transaction.title,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(_transaction.date),
          style: TextStyle(
              fontWeight: FontWeight.normal,
              color: Theme.of(context).primaryColorLight,
              fontSize: 18),
        ),
        trailing: MediaQuery.of(context).size.width > 450
            ? FlatButton.icon(
                textColor: Theme.of(context).primaryColor,
                onPressed: () => _deletTransaction(_transaction.id),
                icon: Icon(Icons.delete),
                label: const Text('Delete'),
              )
            : IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () => _deletTransaction(_transaction.id),
              ),
      ),
    );

    // return Card(
    //   child: Row(
    //     children: [
    //       Container(
    //         margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
    //         child: ListTile(
    //             leading: CircleAvatar(
    //                 radius: 30,
    //                 child:
    //                     Text("${_transaction.amount.toStringAsFixed(0)} Ft"))),
    //         // decoration: BoxDecoration(
    //         //     border: Border.all(
    //         //         color: Theme.of(context).primaryColor, width: 2)),
    //         // padding: EdgeInsets.all(5),
    //         // width: 120,
    //       ),
    //       Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Text(
    //             _transaction.title,
    //             style: Theme.of(context).textTheme.bodyText1,
    //           ),
    //           Text(
    //             DateFormat.yMMMd().format(_transaction.date),
    //             style: TextStyle(
    //                 fontWeight: FontWeight.normal,
    //                 color: Theme.of(context).primaryColorLight,
    //                 fontSize: 14),
    //           )
    //         ],
    //       ),
    //     ],
    //   ),
    // );
  }
}
