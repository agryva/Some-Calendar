// import 'package:example/main_single_without_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:jiffy/jiffy.dart';
import 'package:some_calendar/some_calendar.dart';

import 'main_multi_without_dialog.dart';
import 'main_range_without_dialog.dart';
import 'main_single_without_dialog.dart';

// import 'main_multi_without_dialog.dart';
// import 'main_range_without_dialog.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime selectedDate = DateTime.now();
  List<DateTime> selectedDates = List();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    initializeDateFormatting();
    Intl.systemLocale =
        'en_En'; // to change the calendar format based on localization
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Text(
                  'SomeCalendar Dialog',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  RaisedButton(
                    child: Text("Single"),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (_) => SomeCalendar(
                                primaryColor: Color(0xff5833A5),
                                mode: SomeMode.Single,
                                labels: new Labels(
                                  dialogDone: 'Selesai',
                                  dialogCancel: 'Batal',
                                  dialogRangeFirstDate: 'Tanggal Pertama',
                                  dialogRangeLastDate: 'Tanggal Terakhir',
                                ),
                                isWithoutDialog: false,
                                selectedDate: selectedDate,
                                startDate: new DateTime(2020, 6, 28),
                                lastDate: Jiffy().add(months: 9),
                                done: (date) {
                                  setState(() {
                                    selectedDate = date;
                                    showSnackbar(selectedDate.toString());
                                  });
                                },
                              ));
                    },
                  ),
                  RaisedButton(
                    child: Text("Multi"),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (_) => SomeCalendar(
                                mode: SomeMode.Multi,
                                startDate: DateTime.now(),
                                lastDate: Jiffy().add(days: 7),
                                isWithoutDialog: false,
                                selectedDates: selectedDates,
                                maxDatesToSelect: 1,
                                /*  labels: new Labels(
                                  dialogDone: 'Selesai',
                                  dialogCancel: 'Batal',
                                  dialogRangeFirstDate: 'Tanggal Pertama',
                                  dialogRangeLastDate: 'Tanggal Terakhir',
                                ), */
                                done: (date) {
                                  setState(() {
                                    selectedDates = date;
                                    showSnackbar(selectedDates.toString());
                                  });
                                },
                              ));
                    },
                  ),
                  RaisedButton(
                    child: Text("Range"),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (_) => SomeCalendar(
                                mode: SomeMode.Range,
                                labels: new Labels(
                                  dialogDone: 'Selesai',
                                  dialogCancel: 'Batal',
                                  dialogRangeFirstDate: 'Tanggal Pertama',
                                  dialogRangeLastDate: 'Tanggal Terakhir',
                                ),
                                primaryColor: Color(0xff5833A5),
                                startDate: Jiffy().subtract(years: 3),
                                lastDate: Jiffy().add(months: 9),
                                selectedDates: selectedDates,
                                isWithoutDialog: false,
                                done: (date) {
                                  setState(() {
                                    selectedDates = date;
                                    showSnackbar(selectedDates.toString());
                                  });
                                },
                              ));
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Center(
                child: Text(
                  'SomeCalendar without Dialog',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  RaisedButton(
                    child: Text("Single "),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MainSingleWithoutDialog()),
                      );
                    },
                  ),
                  RaisedButton(
                    child: Text("Multi "),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MainMultiWithoutDialog()),
                      );
                    },
                  ),
                  RaisedButton(
                    child: Text("Range"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MainRangeWithoutDialog()),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showSnackbar(String x) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(x),
    ));
  }
}
