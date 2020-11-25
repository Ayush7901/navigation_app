import 'package:flutter/material.dart';
import '../screen/filter_screen.dart';

class MainDrawer extends StatelessWidget {
  _buidListTile(String text, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text,
          style: TextStyle(
            fontSize: 25,
          ),),
      onTap: () {
        tapHandler();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            child: Text(
              'Cooking Up!!',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            color: Theme.of(context).accentColor,
            height: 100,
            alignment: Alignment.center,
          ),
          _buidListTile('Settings', Icons.settings, () {
            Navigator.of(context).pushReplacementNamed('/');
          }),
          _buidListTile('Filters', Icons.restaurant, () {
            Navigator.of(context).pushReplacementNamed(
              FilterScreen.routeName
            );
          }),
        ],
      ),
    );
  }
}
