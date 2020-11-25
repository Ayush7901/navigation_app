import 'package:flutter/material.dart';
import './screen/filter_screen.dart';
import './screen/meal_detail_screen.dart';
import './screen/tab_screen.dart';
import './screen/categories_screen.dart';
import './screen/categories_meals_screen.dart';
import './models/meal.dart';
import './dummy_data.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  List<Meal> _availaibleMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeal = [];
  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availaibleMeals = DUMMY_MEALS.where((meals) {
        if (_filters['gluten'] && !meals.isGlutenFree) {
          return false;
        }
        if (_filters['lactose'] && !meals.isLactoseFree) {
          return false;
        }
        if (_filters['vegan'] && !meals.isVegan) {
          return false;
        }
        if (_filters['vegetarian'] && !meals.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealid) {
    final _existingIndex =
        _favoriteMeal.indexWhere((meal) => meal.id == mealid);
    if (_existingIndex >= 0) {
      setState(() {
        _favoriteMeal.removeAt(_existingIndex);
      });
    }
    if (_existingIndex <= 0) {
      setState(() {
        _favoriteMeal
            .add(DUMMY_MEALS.firstWhere((element) => element.id == mealid));
      });
    }
  }

  bool _isFavoriteMeal(String id) {
    return _favoriteMeal.any((meal) {
      return meal.id == id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primaryColor: Colors.pinkAccent,
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        /*fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                bodyText2: TextStyle(
                  color: Color.fromRGBO(20, 51, 51, 1),
                ),
                headline6: TextStyle(
                  fontSize: 24,
                  fontFamily: 'RobotoCondensed',
                ),
              )*/
      ),
      //home: CategoriesScreen(),
      //initialRoute: '/',
      routes: {
        '/': (ctx) => TabScreen(_favoriteMeal),
        CategoryMealScreen.routeName: (ctx) =>
            CategoryMealScreen(_availaibleMeals),
        MealDetailScreen.routeName: (ctx) =>
            MealDetailScreen(_isFavoriteMeal, _toggleFavorite),
        FilterScreen.routeName: (ctx) => FilterScreen(_filters, _setFilters),
      },
      /*onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (ctx) => CategoriesScreen(),
        );
      },*/
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (ctx) => CategoriesScreen(),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePageState createState() {
    return MyHomePageState();
  }
}

class MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DeliMeals'),
      ),
      body: Center(
        child: Text('Navigation Time!!'),
      ),
    );
  }
}
