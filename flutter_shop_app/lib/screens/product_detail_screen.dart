import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Image.network(
                selectedProduct.imageUrl,
                fit: BoxFit.cover,
              ),
              width: double.infinity,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '${selectedProduct.price} Ft',
              style: TextStyle(color: Colors.grey, fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                child: Text(
                  selectedProduct.description,
                  softWrap: true,
                  textAlign: TextAlign.center,
                ))
          ],
        ),
      ),
    );
  }
}
