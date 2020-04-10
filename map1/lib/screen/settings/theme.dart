import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeChanger with ChangeNotifier {
  ThemeData _themeData;

  ThemeChanger(this._themeData);

  getTheme() => _themeData;

  setTheme(ThemeData theme){
    _themeData = theme;
    notifyListeners();
  }

}

// Example to use dark theme
class Example extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeChanger>(
      create: (_) => ThemeChanger(ThemeData.dark()),
      child: MaterialAppWithTheme(),
    );
  }
}

class MaterialAppWithTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    return MaterialApp(
      home: ThemeHomePage(),
      theme: theme.getTheme(),
    );
  }
}

class ThemeHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            FlatButton(
              child: Text('Dark Theme'),
              onPressed: (){
                _themeChanger.setTheme(ThemeData.dark());
              }
            ),
            FlatButton(
              child: Text('Light Theme'),
              onPressed: (){
                _themeChanger.setTheme(ThemeData.light());
              }
            ),
          ],
        ),
      )
    );
  }
}