import 'package:flutter/material.dart';
import '../dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal_detail_screen';
  final Function favoriteHandler;
  final Function checkerFunction;
  MealDetailScreen(this.checkerFunction, this.favoriteHandler);

  _buildCardItems(BuildContext context, List<String> texts) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.grey,
          )),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 150,
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return ListTile(
            leading: CircleAvatar(
              radius: 20,
              child: Text('# ${index + 1}'),
            ),
            title: Text('${texts[index]}'),
          );
        },
        itemCount: texts.length,
      ),
    );
  }

  _buildListItems(BuildContext context, List<String> texts) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.grey,
          )),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 150,
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
              color: Theme.of(context).accentColor,
              child: Text('${texts[index]}'));
        },
        itemCount: texts.length,
      ),
    );
  }

  _buildContainer(BuildContext context, String text) {
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            text,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealID = ModalRoute.of(context).settings.arguments as String;
    final displayedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealID);
    return Scaffold(
      appBar: AppBar(
        title: Text('${displayedMeal.title}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image.network(
              displayedMeal.imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            /*Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(10),
              height: 150,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 5,
                    ),
                    child: Text(
                      'Ingredients',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  _buildListItems(context, displayedMeal),
                  /*Container(
                    height: 80,
                    child: ListView.builder(
                      itemBuilder: (ctx, index) {
                        return Text('${displayedMeal.ingredients[index]}');
                      },
                      itemCount: displayedMeal.ingredients.length,
                    ),
                  )*/
                ],
              ),
            )*/
            _buildContainer(context, 'Ingredients'),
            _buildListItems(context, displayedMeal.ingredients),
            _buildContainer(context, 'Steps'),
            _buildCardItems(context, displayedMeal.steps),
            Divider(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => favoriteHandler(displayedMeal.id),
        child: checkerFunction(displayedMeal.id)
            ? Icon(Icons.star)
            : Icon(Icons.star_border),
      ),
    );
  }
}
