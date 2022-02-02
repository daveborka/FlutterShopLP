import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/orders.dart' as ord;

class OrderItem extends StatefulWidget {
  final ord.OrderItem order;

  const OrderItem({this.order});

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var _expanded = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: Duration(milliseconds: 400),
        curve: Curves.bounceIn,
        height: _expanded
            ? min(widget.order.products.length * 70.0 + 110, 210)
            : 120,
        margin: EdgeInsets.all(10),
        child: Card(
          child: Column(
            children: [
              ListTile(
                title: Text('${widget.order.amount} Ft'),
                subtitle: Text(DateFormat('dd/MM/yyy hh:mm')
                    .format(widget.order.dateTime)),
                trailing: IconButton(
                  icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
                  onPressed: () {
                    setState(() {
                      _expanded = !_expanded;
                    });
                  },
                ),
              ),
              AnimatedContainer(
                curve: Curves.ease,
                duration: Duration(milliseconds: 300),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                height: _expanded
                    ? min(widget.order.products.length * 50.0 + 10, 100)
                    : 0,
                child: ListView.builder(
                  itemBuilder: (_, index) => Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 100,
                          child: Text(
                            widget.order.products[index].title,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          width: 100,
                          child: Text(
                            '${widget.order.products[index].quantity}db x ${widget.order.products[index].price}',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                        )
                      ],
                    ),
                  ),
                  itemCount: widget.order.products.length,
                ),
              )
            ],
          ),
        ));
  }
}
