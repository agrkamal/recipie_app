import 'package:flutter/material.dart';

import '../const.dart';

class FiltersScreen extends StatefulWidget {
  FiltersScreen(this.saveFilters, this.filters);

  final Function saveFilters;
  final Map<String, bool> filters;

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _lactoseFree = false;
  var _isVegan = false;
  var _isVegetarian = false;

  @override
  void initState() {
    _glutenFree = widget.filters['gluten'];
    _lactoseFree = widget.filters['lactose'];
    _isVegan = widget.filters['isVegan'];
    _isVegetarian = widget.filters['isVegetarian'];
    super.initState();
  }

  Widget _switchListTile(
    String title,
    String subtitle,
    bool currentValue,
    Function updateValue,
    Color shadowColor,
  ) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(3),
      height: 70,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: shadowColor),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 10,
            // spreadRadius: 3,
          ),
        ],
        color: shadowColor,
      ),
      child: SwitchListTile(
        activeColor: kBackgroundColor,
        inactiveThumbColor: kTextColor,
        activeTrackColor: kTextColor,
        title: Text(title),
        subtitle: Text(subtitle),
        value: currentValue,
        onChanged: updateValue,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        brightness: Brightness.light,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
        title: Text('Filters'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: kBackgroundColor,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 10),
                _switchListTile(
                  'Gluten Free',
                  'This Will include only gluten free meal',
                  _glutenFree,
                  (newVal) {
                    setState(() {
                      _glutenFree = newVal;
                    });
                  },
                  kAccentColor,
                ),
                _switchListTile(
                  'Lactose Free',
                  'This Will Include Only Lactose Free Meals',
                  _lactoseFree,
                  (newVal) {
                    setState(() {
                      _lactoseFree = newVal;
                    });
                  },
                  kPrimaryColor,
                ),
                _switchListTile(
                  'Vegan',
                  'This Will Include Only Vegan Meals',
                  _isVegan,
                  (newVal) {
                    setState(() {
                      _isVegan = newVal;
                    });
                  },
                  kAccentColor,
                ),
                _switchListTile(
                  'Vegetarian',
                  'This Will Include Only Vegetarian Meals',
                  _isVegetarian,
                  (newVal) {
                    setState(() {
                      _isVegetarian = newVal;
                    });
                  },
                  kPrimaryColor,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton.icon(
                    color: kAccentColor,
                    textColor: kTextColor,
                    onPressed: () {
                      final saveFilters = {
                        'gluten': _glutenFree,
                        'lactose': _lactoseFree,
                        'isVegan': _isVegan,
                        'isVegetarian': _isVegetarian,
                      };
                      Navigator.of(context).pop();
                      return widget.saveFilters(saveFilters);
                    },
                    label: Text('Apply'),
                    icon: Icon(Icons.save),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
