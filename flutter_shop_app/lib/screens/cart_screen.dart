import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart' show Cart;
import '../widgets/cart_item.dart';
import '../providers/orders.dart';
import '../widgets/app_drawer.dart';
import '../screens/orders_screen.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/cart';

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  var _isOrderProcessing = false;
  Widget build(BuildContext context) {
    final cartContainer = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your cart!'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  SizedBox(
                    width: 10,
                  ),
                  Chip(
                    label: Text(
                      '${cartContainer.totalAmount.toStringAsFixed(2)} Ft',
                      style: TextStyle(
                          color: Theme.of(context)
                              .primaryTextTheme
                              .headline1
                              .color),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  FlatButton(
                    onPressed: cartContainer.getItemCount > 0
                        ? () async {
                            try {
                              setState(() {
                                _isOrderProcessing = true;
                              });
                              await Provider.of<Orders>(context, listen: false)
                                  .addOrder(cartContainer.items.values.toList(),
                                      cartContainer.totalAmount);
                              cartContainer.clear();

                              Navigator.of(context)
                                  .pushNamed(OrdersScreem.routeName);
                            } catch (error) {
                              showDialog(
                                  context: context,
                                  builder: (ctx) {
                                    return AlertDialog(
                                      title: Text('Error Occurred'),
                                      content: Text('Something went wrong'),
                                      actions: [
                                        FlatButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text('OK'))
                                      ],
                                    );
                                  });
                            } finally {
                              setState(() {
                                _isOrderProcessing = false;
                              });
                            }
                          }
                        : null,
                    child: _isOrderProcessing
                        ? CircularProgressIndicator()
                        : Text(
                            'ORDER NOW',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
              child: ListView.builder(
            itemCount: cartContainer.getItemCount,
            itemBuilder: (context, index) => CartItem(
              cartItemid: cartContainer.items.values.toList()[index].id,
              productId: cartContainer.items.keys.toList()[index],
              title: cartContainer.items.values.toList()[index].title,
              quantity: cartContainer.items.values.toList()[index].quantity,
              price: cartContainer.items.values.toList()[index].price,
            ),
          ))
        ],
      ),
      drawer: AppDrawer(),
    );
  }
}
