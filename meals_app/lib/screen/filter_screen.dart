import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/filters_screen';
  final Function saveFilters;
  final Map<String,bool> filterMap;
  FilterScreen(this.filterMap,this.saveFilters);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  var _isGlutenFree = false;
  var _isVegetarian = false;
  var _isVegan = false;
  var _isSomething = false;
  initState(){
    _isGlutenFree = widget.filterMap['gluten'];
    _isVegetarian = widget.filterMap['vegetarian'];
    _isVegan = widget.filterMap['vegan'];
    _isSomething = widget.filterMap['lactose'];
    
    super.initState();
  }
  Widget _builderForSwitch(
    String title,
    String subTitle,
    bool valueChanger,
    Function method,
  ) {
    return SwitchListTile(
      title: Text(title),
      value: valueChanger,
      onChanged: method,
      subtitle: Text(subTitle),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
        backgroundColor: Theme.of(context).primaryColor,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                final selectedMeals = {
                  'gluten': _isGlutenFree,
                  'lactose': _isSomething,
                  'vegan': _isVegan,
                  'vegetarian': _isVegetarian,
                };
                widget.saveFilters(selectedMeals);
              })
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Your meals adjusted according to you',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _builderForSwitch('Gluten-Free',
                    'include only gluten free diets', _isGlutenFree, (newVal) {
                  setState(
                    () {
                      _isGlutenFree = newVal;
                    },
                  );
                }),
                _builderForSwitch(
                    'Vegetarian-Diet', 'include only veg diets', _isVegetarian,
                    (newVal) {
                  setState(
                    () {
                      _isVegetarian = newVal;
                    },
                  );
                }),
                _builderForSwitch(
                    'Go-Vegan', 'include only vegan diets', _isVegan, (newVal) {
                  setState(
                    () {
                      _isVegan = newVal;
                    },
                  );
                }),
                _builderForSwitch(
                    'Lactose-Free', 'include lactose free diets', _isSomething,
                    (newVal) {
                  setState(
                    () {
                      _isSomething = newVal;
                    },
                  );
                })
              ],
            ),
          )
        ],
      ),
    );
  }
}
