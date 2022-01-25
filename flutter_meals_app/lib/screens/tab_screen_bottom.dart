import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../screens/categories_screen.dart';
import '../screens/favorites_screen.dart';
import '../widgets/main_drawer.dart';

class TabsScreenBottom extends StatefulWidget {
  final List<Meal> favoriteMeals;
  TabsScreenBottom(this.favoriteMeals);

  @override
  _TabsScreenBottomState createState() => _TabsScreenBottomState();
}

class _TabsScreenBottomState extends State<TabsScreenBottom> {
  List<Map<String, Object>> _pages;
  int _selectedStateIndex = 0;

  @override
  void initState() {
    _pages = [
      {'page': CategoriesScreen(), 'title': 'Categories'},
      {
        'page': FavoritesScreen(widget.favoriteMeals),
        'title': 'Yout Favorites'
      },
    ];
    // TODO: implement initState
    super.initState();
  }

  void _selectPage(int index) {
    setState(() {
      _selectedStateIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedStateIndex]['title']),
      ),
      drawer: MainDrawer(),
      body: _pages[_selectedStateIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedStateIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.category),
            title: Text('Categories'),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.favorite_outline),
            title: Text('Favorites'),
          )
        ],
      ),
    );
  }
}
