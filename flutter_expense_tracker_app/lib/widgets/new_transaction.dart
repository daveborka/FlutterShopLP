import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  NewTransaction(this.addNewTransaction);
  final Function addNewTransaction;
  final titlecontroller = TextEditingController();
  final amountcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Title',
              ),
              controller: titlecontroller,
              //onChanged: (str) => {titleInput = str},
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountcontroller,
              //onChanged: (str) => {amountInput = str},
            ),
            FlatButton(
              onPressed: () => {
                addNewTransaction(
                    titlecontroller.text, double.parse(amountcontroller.text))
              },
              child: Text('Add transaction'),
              textColor: Colors.purple,
            )
          ],
        ),
      ),
    );
  }
}
