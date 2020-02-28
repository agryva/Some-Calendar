import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:jiffy/jiffy.dart';
import 'package:some_calendar/some_calendar.dart';

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
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'SomeCalendar',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
      floatingActionButton: SpeedDial(
        // both default to 16
        marginRight: 18,
        marginBottom: 20,
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        tooltip: 'Some calendar',
        heroTag: 'Some-calendar',
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 8.0,
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
              child: Icon(Icons.calendar_today),
              backgroundColor: Colors.red,
              label: 'Single',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (_) => SomeCalendar(
                          mode: SomeMode.Single,
                          selectedDate: selectedDate,
                          startDate: Jiffy().subtract(years: 3),
                          lastDate: Jiffy().add(months: 9),
                          done: (date) {
                            setState(() {
                              selectedDate = date;
                              showSnackbar(selectedDate.toString());
                            });
                          },
                        ));
              }),
          SpeedDialChild(
            child: Icon(Icons.calendar_today),
            backgroundColor: Colors.blue,
            label: 'Multi',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (_) => SomeCalendar(
                        mode: SomeMode.Multi,
                        startDate: Jiffy().subtract(years: 3),
                        lastDate: Jiffy().add(months: 9),
                        selectedDates: selectedDates,
                        done: (date) {
                          setState(() {
                            selectedDates = date;
                            showSnackbar(selectedDates.toString());
                          });
                        },
                      ));
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.calendar_today),
            backgroundColor: Colors.green,
            label: 'Range',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () {
              print("test $selectedDates");
              showDialog(
                  context: context,
                  builder: (_) => SomeCalendar(
                    mode: SomeMode.Range,
                    startDate: Jiffy().subtract(years: 3),
                    lastDate: Jiffy().add(months: 9),
                    selectedDates: selectedDates,
                    done: (date) {
                      setState(() {
                        selectedDates = date;
                        showSnackbar(selectedDates.toString());
                      });
                    },
                  )).then((s) {
                print("test1 $selectedDates");
              });
            },
          ),
        ],
      ),
    );
  }

  void showSnackbar(String x) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(x),));
  }
}
