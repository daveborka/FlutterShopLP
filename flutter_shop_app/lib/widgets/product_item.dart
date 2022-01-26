import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final singleProduct = Provider.of<Product>(context);
    return GridTile(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
              arguments: singleProduct.id);
        },
        child: Image.network(
          singleProduct.imageUrl,
          fit: BoxFit.cover,
        ),
      ),
      footer: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: GridTileBar(
          backgroundColor: Colors.black87,
          leading: IconButton(
            icon: Icon(singleProduct.isFavorite
                ? Icons.favorite
                : Icons.favorite_border),
            onPressed: () {
              singleProduct.toggleFavoriteStatus();
            },
            color: Theme.of(context).accentColor,
          ),
          title: Text(
            singleProduct.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {},
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
