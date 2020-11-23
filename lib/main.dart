import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'homePage.dart';
import 'dataPage.dart';
import 'settingPage.dart';

main() {
  runApp(
    MainPage(),
  );
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Pages(),
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  final List<Widget> pages = <Widget>[HomePage(), Data(), Setting()];
  final List<String> title = <String>['活动', '数据', '设置'];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: pages[context.watch<Pages>().index],
          // child: context.watch<Pages>().pages[context.watch<Pages>().index],
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: '记录'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.date_range), label: '数据'),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: '设置'),
            ],
            currentIndex: context.watch<Pages>().index,
            selectedItemColor: Colors.pink,
            onTap: (index) => {
              context.read<Pages>().changePage(index),
            },
          )),
    );
  }
}

class Pages with ChangeNotifier {
  int _index = 0;
  int get index => _index;

  void changePage(int index) {
    _index = index;
    notifyListeners();
  }
}

class AppConfig with ChangeNotifier{
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  MaterialColor _appColor = Colors.amber;
  MaterialColor get appColor => _appColor;

  AppConfig(){
    initConfig();
  }

  void initConfig() async{
    final SharedPreferences prefs = await _prefs;
    final String colorName = prefs.getString('APP_COLOR');
    _appColor = getColor(colorName);
  }

// blue, pink, amber, red, green, black
  MaterialColor getColor(String name){
    switch(name){
      case 'BLUE': 
        return Colors.blue;
      case 'PINK': 
        return Colors.pink;
      case 'AMBER': 
        return Colors.amber;
      case 'RED': 
        return Colors.red;
      case 'GREEN': 
        return Colors.green;
      case 'BLACK': 
        return Colors.black;
      default:
        return Colors.amber;
    }
  }

  void changeColor(String color) async{
    _appColor = getColor(color);
    final SharedPreferences prefs = await _prefs;
    prefs.setString('APP_COLOR', color);
    notifyListeners();
  }
}

