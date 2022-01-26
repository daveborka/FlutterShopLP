import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CartItem extends StatelessWidget {
  final String cartItemid;
  final String productId;
  final double price;
  final String title;
  final int quantity;
  const CartItem({
    this.cartItemid,
    this.productId,
    this.price,
    this.title,
    this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(cartItemid),
      background: Container(
          color: Theme.of(context).errorColor,
          child: Icon(
            Icons.delete,
            color: Colors.white,
            size: 50,
          ),
          alignment: Alignment.centerRight,
          padding: EdgeInsets.only(right: 20),
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4)),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: Padding(
              padding: const EdgeInsets.all(8),
              child: CircleAvatar(
                child: FittedBox(child: Text('${price} Ft')),
              ),
            ),
            title: Text('$title'),
            subtitle: Text('Total: ${price * quantity}'),
            trailing: Text('Quantity: ${quantity}X'),
          ),
        ),
      ),
    );
  }
}
