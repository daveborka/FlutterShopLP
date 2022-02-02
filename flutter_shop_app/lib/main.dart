import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/providers/auth.dart';

import 'package:provider/provider.dart';

import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './screens/orders_screen.dart';
import './screens/user_products.dart';
import './providers/products.dart';
import './providers/cart.dart';
import './screens/cart_screen.dart';
import './providers/orders.dart';
import './screens/auth_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (ctx) => Auth(),
          ),
          ChangeNotifierProxyProvider<Auth, Products>(
            update: (ctx, auth, previousProducts) => Products(
                auth.Token,
                auth.UserId,
                previousProducts == null ? [] : previousProducts.items),
          ),
          ChangeNotifierProvider(
            create: (ctx) => Cart(),
          ),
          ChangeNotifierProxyProvider<Auth, Orders>(
              update: (ctx, auth, previousOrders) => Orders(
                  auth.Token,
                  previousOrders == null ? [] : previousOrders.orders,
                  auth.UserId))
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, child) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'MyShop',
            theme: ThemeData(
              primarySwatch: Colors.purple,
              accentColor: Colors.deepOrange,
              fontFamily: 'Lato',
            ),
            home: auth.isAuth
                ? ProductsOverviewScreen()
                : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (ctx, authResult) =>
                        authResult.connectionState == ConnectionState.waiting
                            ? SplashScreen()
                            : AuthScreen()),
            routes: {
              ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
              CartScreen.routeName: (ctx) => CartScreen(),
              OrdersScreem.routeName: (ctx) => OrdersScreem(),
              UserProductsScree.routeName: (ctx) => UserProductsScree(),
              EditProductScreen.routeName: (ctx) => EditProductScreen()
            },
          ),
        ));
  }
}
