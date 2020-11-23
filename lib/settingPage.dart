import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Items()),
        ChangeNotifierProvider(create: (_) => ColorsList())
      ],
      child: MyApp(),
    );
    // return ChangeNotifierProvider(
      // create: (_) => Items(),
      // child: MyApp(),
    // );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('设置'),
        ),
        body: CardsList(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.hd),
          onPressed: () => {
            context
                .read<Items>()
                .addEnabledItem(LogItem('moyu', Colors.blue, Colors.white))
          },
        ),
      ),
    );
  }
}

class CardsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        EnAbledCard(),
        DisAbledCard(),
        ChoseColorCard(),
      ],
    );
  }
}

class EnAbledCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(true);
  }
}

class DisAbledCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(false);
  }
}

class ChoseColorCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          '主题颜色',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16.0,
          ),
        ),
        Container(
          child: Column(
            children: context.watch<ColorsList>().colorsList,
          ),
        ),
      ],
    );
  }
}

class Card extends StatelessWidget {
  final bool isEnalbe;
  Card(isEnalbe) : isEnalbe = isEnalbe;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          isEnalbe ? '启用中' : '未启用',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16.0,
          ),
        ),
        Container(
          // height: 100,
          constraints: BoxConstraints(
            minWidth: double.infinity,
            minHeight: 100.0,
          ),
          margin: EdgeInsets.all(8.0),
          padding: EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.white30, width: 2.0),
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey,
                blurRadius: 4.0,
                spreadRadius: 1.0,
                offset: Offset(-1.0, 1.0),
              ),
            ],
          ),
          child: Wrap(
            alignment: WrapAlignment.spaceAround,
            spacing: 2,
            runSpacing: 5,
            children: isEnalbe
                ? context.watch<Items>().enabledItems
                : context.watch<Items>().disabledItems,
          ),
        ),
      ],
    );
  }
}

class Items with ChangeNotifier {
  List<LogItem> _enabledItems = <LogItem>[];
  List<LogItem> get enabledItems => _enabledItems;

  List<LogItem> _disabledItems = <LogItem>[];
  List<LogItem> get disabledItems => _disabledItems;

  void addEnabledItem(LogItem logItem) {
    _enabledItems.add(logItem);
    notifyListeners();
  }

  void addDisabledItem(LogItem logItem) {
    _disabledItems.add(logItem);
    notifyListeners();
  }
}

class LogItem extends StatelessWidget {
  final String content;
  final Color backgroundColor;
  final Color fontColor;

  LogItem(content, backgroundColor, fontColor)
      : content = content,
        backgroundColor = backgroundColor,
        fontColor = fontColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
      child: GestureDetector(
        child: Text(
          content,
          style: TextStyle(
            color: fontColor,
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        // border: Border.all(color: Colors.black, width: 1.2),
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey,
            blurRadius: 8.0,
            spreadRadius: 0.1,
            offset: Offset(-0.2, 0.2),
          ),
        ],
      ),
    );
  }
}

class ColorsList with ChangeNotifier{
  List<Container> _colorsList = <Container>[];
  List<Container> get colorsList => _colorsList;

  ColorsList() {
    for (var i in [Colors.blue, Colors.pink, Colors.amber, Colors.red, Colors.green, Colors.black]){
      _colorsList.add(
        Container(
          height: 20.0,
          margin: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: i,
            borderRadius: BorderRadius.circular(12.0),
          ),
        )
      );
    }
  }

  void changeColor(int index){
    notifyListeners();
  }
}

