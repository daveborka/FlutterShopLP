import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String id;
  UserProductItem(this.id, this.title, this.imageUrl);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: ListTile(
        title: Text(title),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
        ),
        trailing: Container(
          width: 100,
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(EditProductScreen.routeName,
                      arguments: this.id);
                },
                icon: Icon(Icons.edit),
                color: Theme.of(context).primaryColor,
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
