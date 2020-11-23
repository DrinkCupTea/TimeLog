import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TimeLogs()),
        ChangeNotifierProvider(create: (_) => AppConfig()),
      ],
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
            title: Text('记录'),
            backgroundColor: context.watch<AppConfig>().appColor),
        body: TimeLine(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => context.read<TimeLogs>().addLog(
              '摸鱼',
              Icons.data_usage_outlined,
              DateTime.now(),
              DateTime.now().add(Duration(minutes: 120))),
          backgroundColor: Colors.red,
        ),
      ),
    );
  }
}

class TimeLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(8.0),
      itemCount: context.watch<TimeLogs>().activities.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 80,
          // color: Colors.pink[context.watch<TimeLogs>().hex[index]],
          child: Row(
            children: [
              // Icon(context.watch<TimeLogs>().icon[index]),
              Container(
                margin: EdgeInsets.all(10),
                child: Icon(
                  context.watch<TimeLogs>().icon[index],
                  // Icons.data_usage_outlined,
                  size: 30,
                  color: Colors.white,
                ),
              ),
              Expanded(
                child: Container(),
              ),
              Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5.0),
                  ),
                  Text(
                    context.watch<TimeLogs>().activities[index],
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      letterSpacing: 2.0,
                    ),
                  ),
                  // Start time - Finish time
                  Text(
                    context
                            .watch<TimeLogs>()
                            .startTime[index]
                            .hour
                            .toString()
                            .padLeft(2, '0') +
                        ":" +
                        context
                            .watch<TimeLogs>()
                            .startTime[index]
                            .minute
                            .toString()
                            .padLeft(2, '0') +
                        '-' +
                        context
                            .watch<TimeLogs>()
                            .endTime[index]
                            .hour
                            .toString()
                            .padLeft(2, '0') +
                        ":" +
                        context
                            .watch<TimeLogs>()
                            .endTime[index]
                            .minute
                            .toString()
                            .padLeft(2, '0'),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                      letterSpacing: 2.0,
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15.0),
              ),
              Expanded(
                child: Container(),
              ),
              Text(
                context
                        .watch<TimeLogs>()
                        .totalTime[index]
                        .inMinutes
                        .toString() +
                    ' 分钟',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: Colors.blue,
            // border: Border.all(color: Colors.pink, width: 3.0),
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
        );
      },
      separatorBuilder: (BuildContext context, int index) => Divider(),
    );
  }
}

class TimeLogs with ChangeNotifier {
  List<String> _activities = <String>["休息"];
  List get activities => _activities;

  List<IconData> _icon = <IconData>[Icons.free_breakfast];
  List<IconData> get icon => _icon;

  List<DateTime> _startTime = <DateTime>[DateTime(2020, 11, 21, 16, 03)];
  List<DateTime> get startTime => _startTime;

  List<DateTime> _endTime = <DateTime>[DateTime(2020, 11, 21, 18, 03)];
  List<DateTime> get endTime => _endTime;

  List<Duration> _totalTime = <Duration>[
    DateTime(2020, 11, 21, 18, 03).difference(DateTime(2020, 11, 21, 16, 03))
  ];
  List<Duration> get totalTime => _totalTime;

  void addLog(String log, IconData icon, DateTime startTime, DateTime endTime) {
    _activities.add(log);
    _icon.add(icon);
    _startTime.add(startTime);
    _endTime.add(endTime);
    _totalTime.add(endTime.difference(startTime));
    notifyListeners();
  }

  void changeLog(int index, String log) {
    _activities[index] = log;
    notifyListeners();
  }
}
