import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/auth.dart';
import 'package:provider/provider.dart';

import '../screens/orders_screen.dart';
import '../screens/user_products.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<Auth>(context, listen: false).UserId;
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Hello ${user}'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shop),
            title: Text('Shop'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payments),
            title: Text('Orders'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(OrdersScreem.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payments),
            title: Text('ManageProducts'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserProductsScree.routeName);
            },
          )
        ],
      ),
    );
  }
}
