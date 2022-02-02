import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/screens/edit_product_screen.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../widgets/app_drawer.dart';

import '../widgets/user_product_item.dart';

class UserProductsScree extends StatelessWidget {
  static String routeName = "/manageProducts";
  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false)
        .fetchAndSetProducts(true);
  }

  @override
  Widget build(BuildContext context) {
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
      body: FutureBuilder(
        future: _refreshProducts(context),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () {
                      return _refreshProducts(context);
                    },
                    child: Consumer<Products>(
                      builder: (ctx, productsData, child) => Padding(
                        padding: const EdgeInsets.all(8),
                        child: ListView.builder(
                          itemBuilder: (_, index) => UserProductItem(
                              productsData.items[index].id,
                              productsData.items[index].title,
                              productsData.items[index].imageUrl),
                          itemCount: productsData.items.length,
                        ),
                      ),
                    ),
                  ),
      ),
      drawer: AppDrawer(),
    );
  }
}
