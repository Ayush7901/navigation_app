import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favoriteList;
  FavoritesScreen(this.favoriteList);
  @override
  Widget build(BuildContext context) {
    if (favoriteList.isEmpty) {
      return Center(
        child: Text('You have no favorites yet !!'),
      );
    } else {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: favoriteList[index].id,
            title: favoriteList[index].title,
            imageUrl: favoriteList[index].imageUrl,
            affordability: favoriteList[index].affordability,
            duration: favoriteList[index].duration,
            complexity: favoriteList[index].complexity,
          );
        },
        itemCount: favoriteList.length,
      );
    }
  }
}
