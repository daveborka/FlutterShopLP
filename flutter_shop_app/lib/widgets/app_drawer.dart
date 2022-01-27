import 'package:flutter/material.dart';

import '../screens/orders_screen.dart';
import '../screens/user_products.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Hello Firend!'),
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
