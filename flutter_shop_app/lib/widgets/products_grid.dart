import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/product_item.dart';
import '../providers/products.dart';
import '../providers/product.dart';

class ProductsGrid extends StatelessWidget {
  var showOnlyfavoritesData;
  ProductsGrid(this.showOnlyfavoritesData);
  @override
  Widget build(BuildContext context) {
    var dataContainer = Provider.of<Products>(context);
    List<Product> loadedProducts = showOnlyfavoritesData
        ? dataContainer.favoritesItems
        : dataContainer.items;

    return GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: loadedProducts.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
              value: loadedProducts[index],
              child: ProductItem(),
            ));
  }
}
