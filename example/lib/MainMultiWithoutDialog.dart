import 'package:flutter/material.dart';
import 'package:some_calendar/some_calendar.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:jiffy/jiffy.dart';

class MainMultiWithoutDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainMultiWithoutDialogState();
  
}

class MainMultiWithoutDialogState extends State<MainMultiWithoutDialog> {
  
  List<DateTime> _selectedDates = [
    DateTime.utc(2020, 5, 26),
    DateTime.utc(2020, 5, 27),
    DateTime.utc(2020, 5, 28),
  ];
  
  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
    Intl.systemLocale = 'en_En';
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("SomeCalendar without Dialog"),
        ),
        body: Builder(
            builder: (context) {
              return Center(
                  child: SomeCalendar(
                    selectedDates: _selectedDates,
                    mode: SomeMode.Multi,
                    onPageChanged: (date) {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text(
                            'Current date is ' + date.toString()),
                        duration: Duration(seconds: 1),
                      ));
                    },
                    isWithoutDialog: true,
                    scrollDirection: Axis.horizontal,
                    startDate: Jiffy().subtract(years: 3),
                    lastDate: Jiffy().add(months: 9),
                    done: (dates) {
//        setState(() {
                      dates = _selectedDates;
//        });
                    },
                  )
              );
            })
    );
  }
  
}