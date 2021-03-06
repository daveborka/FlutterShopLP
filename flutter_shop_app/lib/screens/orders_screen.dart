import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';

class OrdersScreem extends StatelessWidget {
  static String routeName = "/orders";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
        builder: (ctx, datasnapshot) {
          if (datasnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (datasnapshot.error != null) {
              //error handling stuff
              return Center(child: Text('An error occurred!'));
            } else {
              return Consumer<Orders>(
                builder: (ctx, orderData, child) => ListView.builder(
                  itemBuilder: (ctx, index) => OrderItem(
                    order: orderData.orders[index],
                  ),
                  itemCount: orderData.orders.length,
                ),
              );
            }
          }
        },
      ),
      drawer: AppDrawer(),
    );
  }
}
