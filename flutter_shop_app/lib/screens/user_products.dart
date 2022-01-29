import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/screens/edit_product_screen.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../widgets/app_drawer.dart';

import '../widgets/user_product_item.dart';

class UserProductsScree extends StatelessWidget {
  static String routeName = "/manageProducts";
  @override
  Widget build(BuildContext context) {
    final allProducts = Provider.of<Products>(context).items;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your products'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.routeName);
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
          itemBuilder: (_, index) => UserProductItem(allProducts[index].id,
              allProducts[index].title, allProducts[index].imageUrl),
          itemCount: allProducts.length,
        ),
      ),
      drawer: AppDrawer(),
    );
  }
}
