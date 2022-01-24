import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const String routeName = "/filters";
  final Function saveFilters;
  final Map<String, bool> _currentFilters;
  FiltersScreen(this.saveFilters, this._currentFilters);
  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  Widget buildListTile(String title, String subTitle, Function onChangedHandler,
      bool currentValue) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      onChanged: onChangedHandler,
      subtitle: Text(subTitle),
    );
  }

  var _glutenFree = false;
  var _vegeterian = false;
  var _lactoseFree = false;
  var _vegan = false;
  @override
  void initState() {
    _glutenFree = widget._currentFilters['gluten'];
    _lactoseFree = widget._currentFilters['lactose'];
    _vegan = widget._currentFilters['vegan'];
    _vegeterian = widget._currentFilters['vegetarian'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Filters'),
          actions: [
            IconButton(
                onPressed: () => widget.saveFilters({
                      'gluten': _glutenFree,
                      'lactose': _lactoseFree,
                      'vegan': _vegan,
                      'vegetarian': _vegeterian,
                    }),
                icon: Icon(Icons.save))
          ],
        ),
        drawer: MainDrawer(),
        body: Column(children: [
          Container(
              padding: EdgeInsets.all(20),
              child: Text(
                "Adjust your meal selection",
                style: Theme.of(context).textTheme.bodyText1,
              )),
          Expanded(
              child: ListView(
            children: [
              buildListTile(
                  'Gluten-free', 'You can filter the gluten-free meals!',
                  (val) {
                setState(() {
                  _glutenFree = val;
                });
              }, _glutenFree),
              buildListTile(
                  'Lactose-free', 'You can filter the lactose-free meals!',
                  (val) {
                setState(
                  () {
                    _lactoseFree = val;
                  },
                );
              }, _lactoseFree),
              buildListTile('Vegan', 'You can filter the vegan meals!', (val) {
                setState(() {
                  _vegan = val;
                });
              }, _vegan),
              buildListTile(
                  'Vegetarian', 'You can filter the vegetarian meals!', (val) {
                setState(() {
                  _vegeterian = val;
                });
              }, _vegeterian)
            ],
          ))
        ]));
  }
}
