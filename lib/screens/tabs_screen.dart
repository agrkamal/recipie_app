import 'package:flutter/material.dart';

import './categories_screen.dart';
import './favorite_screen.dart';
import '../models/meals.dart';
import './filters_screen.dart';
import '../const.dart';

class TabsScreen extends StatefulWidget {
  TabsScreen(this.favMeals, this.saveFilters, this.filters);

  final List<Meal> favMeals;
  final Function saveFilters;
  final Map<String, bool> filters;

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _page;

  int _selectedIndex = 0;

  @override
  void initState() {
    _page = [
      {
        'title': 'Categories',
        'page': CategoriesScreen(),
      },
      {
        'title': 'Favorite Meals',
        'page': FavoriteScreen(widget.favMeals),
      }
    ];
    super.initState();
  }

  void _selectPage(newVal) {
    setState(() {
      _selectedIndex = newVal;
    });
  }

  void showFilters() {
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => FiltersScreen(widget.saveFilters, widget.filters),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          if (_selectedIndex == 0)
            FlatButton.icon(
              label: Text(
                'Filters',
                style: TextStyle(fontSize: 17),
              ),
              textColor: kPrimaryColor,
              icon: Icon(
                Icons.filter_list,
                color: kPrimaryColor,
              ),
              onPressed: showFilters,
            ),
        ],
        backgroundColor: kTextColor,
        title: Text(
          'Home\'s Chef',
          style: TextStyle(
            color: kAccentColor,
          ),
        ),
      ),
      body: _page[_selectedIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kTextColor,
        elevation: 10,
        iconSize: 26,
        unselectedItemColor: kAccentColor.withOpacity(0.4),
        currentIndex: _selectedIndex,
        onTap: _selectPage,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.grain),
            title: Text('Categories'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            title: Text('Favorites'),
          ),
        ],
      ),
    );
  }
}
