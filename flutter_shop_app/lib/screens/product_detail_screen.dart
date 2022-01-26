import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/products.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static String routeName = "/product-details";
  Widget build(BuildContext context) {
    var id = ModalRoute.of(context).settings.arguments as String;
    var selectedProduct =
        Provider.of<Products>(context, listen: false).findById(id);
    //..

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedProduct.title),
      ),
    );
  }
}
