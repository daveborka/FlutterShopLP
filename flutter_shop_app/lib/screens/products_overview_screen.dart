import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/products_grid.dart';
import '../widgets/badge.dart';
import '../screens/cart_screen.dart';
import '../providers/cart.dart';

enum FilterOptions { Favorites, All }

class ProductsOverviewScreen extends StatefulWidget {
  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavoritesData = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              if (selectedValue == FilterOptions.Favorites) {
                setState(() {
                  _showOnlyFavoritesData = true;
                });
              } else {
                setState(() {
                  _showOnlyFavoritesData = false;
                });
              }
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favorites!'),
                value: FilterOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text('Show all!'),
                value: FilterOptions.All,
              ),
            ],
            icon: Icon(Icons.more_vert),
          ),
          Consumer<Cart>(
            builder: (_, actualCart, child) => Badge(
                child: IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {
                    Navigator.of(context).pushNamed(CartScreen.routeName);
                  },
                ),
                value: actualCart.getItemCount.toString()),
          ),
        ],
      ),
      body: ProductsGrid(_showOnlyFavoritesData),
    );
  }
}
