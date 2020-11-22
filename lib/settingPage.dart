import 'package:flutter/material.dart';

class Setting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MyApp(),
    );
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
    return Card();
  }
}

class DisAbledCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class ChoseColorCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Card extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 100,
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
        // spacing: 2,
        runSpacing: 5,
        children: <Widget>[
          LogItem.onlyContent('Test'),
          LogItem.onlyContent('Xie'),
          LogItem.onlyContent('Weijie'),
          LogItem.onlyContent('moyu'),
          LogItem.onlyContent('Study'),
          LogItem.onlyContent('longlonglonglonglonglonglonglonglonglonglong'),
          LogItem.onlyContent('Reading'),
        ],
      ),
    );
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

  LogItem.onlyContent(content)
      : content = content,
        backgroundColor = Colors.blue,
        fontColor = Colors.white;

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
