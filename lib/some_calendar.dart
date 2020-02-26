library some_calendar;

import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:some_calendar/some_calendar_page.dart';
import 'package:some_calendar/some_date_range.dart';
import 'package:some_calendar/some_utils.dart';

typedef void OnTapFunction(DateTime date);
typedef void OnDoneFunction(date);

enum SomeMode { Range, Single, Multi }

class SomeCalendar extends StatefulWidget {
  final SomeMode mode;
  final OnDoneFunction done;

  DateTime startDate;
  DateTime lastDate;

  SomeCalendar({@required this.mode, this.startDate, this.lastDate, this.done}) {
    assert(mode != null);
  }

  @override
  SomeCalendarState createState() => SomeCalendarState(
      lastDate: lastDate, startDate: startDate, mode: mode, done: done);

  static SomeCalendarState of(BuildContext context) =>
      context.findAncestorStateOfType();
}

class SomeCalendarState extends State<SomeCalendar> {
  final OnDoneFunction done;

  DateTime startDate;
  DateTime lastDate;
  SomeMode mode;

  PageView pageView;
  PageController controller;

  int pagesCount;
  String month;
  String year;
  String date;

  String monthEndDate;
  String yearEndDate;
  String dateEndDate;

  List<DateTime> selectedDates;
  DateTime selectedDate;
  DateTime firstRangeDate;
  DateTime endRangeDate;

  DateTime now;

  SomeCalendarState(
      {@required this.done,
      this.startDate,
      this.lastDate,
      this.selectedDates,
      this.mode});

  @override
  void initState() {
    now = Jiffy().dateTime;
    if (startDate == null) startDate = SomeUtils.getStartDateDefault();
    if (lastDate == null) lastDate = SomeUtils.getLastDateDefault();
    if (selectedDates == null) selectedDates = List();
    if (mode == SomeMode.Single) {
      selectedDate = Jiffy(DateTime(now.year, now.month, now.day)).dateTime;
      date = Jiffy(selectedDate).format("dd");
    } else if (mode == SomeMode.Range) {
      firstRangeDate = Jiffy(DateTime(now.year, now.month, now.day)).dateTime;
      endRangeDate = Jiffy(DateTime(now.year, now.month, now.day)).add(days: 4);

      date = Jiffy(firstRangeDate).format("dd");
      dateEndDate = Jiffy(endRangeDate).format("dd");
      monthEndDate = Jiffy(endRangeDate).format("MMM");
      yearEndDate = Jiffy(endRangeDate).format("yyyy");
      generateListDateRange();
    }

    startDate = SomeUtils.setToMidnight(startDate);
    lastDate = SomeUtils.setToMidnight(lastDate);

    month = Jiffy(startDate).format("MMM");
    year = Jiffy(startDate).format("yyyy");
    pagesCount = SomeUtils.getCountFromDiffDate(startDate, lastDate);
    controller = PageController(initialPage: 0);

    pageView = PageView.builder(
      controller: controller,
      scrollDirection: Axis.vertical,
      itemCount: pagesCount,
      onPageChanged: (index) {
        SomeDateRange someDateRange = getDateRange(index);
        setState(() {
          month = Jiffy(someDateRange.startDate).format("MMM");
          year = Jiffy(someDateRange.startDate).format("yyyy");
          if (mode == SomeMode.Range) date = Jiffy(firstRangeDate).format("dd");
          else date = Jiffy(selectedDate).format("dd");

          dateEndDate = Jiffy(endRangeDate).format("dd");
          monthEndDate = Jiffy(endRangeDate).format("MMM");
          yearEndDate = Jiffy(endRangeDate).format("yyyy");
        });
      },
      itemBuilder: (context, index) {
        SomeDateRange someDateRange = getDateRange(index);
        return Container(
            child: SomeCalendarPage(
          startDate: someDateRange.startDate,
          lastDate: someDateRange.endDate,
          onTapFunction: onCallback,
          state: SomeCalendar.of(context),
          mode: mode,
        ));
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return show();
  }

  void onCallback(DateTime a) {
    if (mode == SomeMode.Multi) {
      if (selectedDates.contains(a))
        selectedDates.remove(a);
      else
        selectedDates.add(a);
      selectedDates.sort((a, b) {
        return a.compareTo(b);
      });
    } else if (mode == SomeMode.Single) {
      selectedDate = a;
      setState(() {
        date = Jiffy(selectedDate).format("dd");
      });

    } else {
      if (a.isBefore(firstRangeDate)) {
        firstRangeDate = a;
      } else {
        endRangeDate = a;
      }
      selectedDates.clear();
      generateListDateRange();
      selectedDates.sort((a, b) {
        return a.compareTo(b);
      });
      setState(() {
        date = Jiffy(firstRangeDate).format("dd");
        dateEndDate = Jiffy(endRangeDate).format("dd");
        monthEndDate = Jiffy(endRangeDate).format("MMM");
        yearEndDate = Jiffy(endRangeDate).format("yyyy");
      });
    }
  }

  void generateListDateRange() {
    var diff = endRangeDate.difference(firstRangeDate).inDays + 1;
    var date = firstRangeDate;
    for (int i = 0; i < diff; i++) {
      selectedDates.add(date);
      date = Jiffy(date).add(days: 1);
    }
  }

  SomeDateRange getDateRange(int position) {
    DateTime pageStartDate;
    DateTime pageEndDate;

    if (position == 0) {
      pageStartDate = startDate;
      if (pagesCount <= 1) {
        pageEndDate = lastDate;
      } else {
        var last = Jiffy(DateTime(startDate.year, startDate.month))
          ..add(months: 1);
        var lastDayOfMonth = last..subtract(days: 1);
        pageEndDate = lastDayOfMonth.dateTime;
      }
    } else if (position == pagesCount - 1) {
      var start = Jiffy(DateTime(lastDate.year, lastDate.month))
        ..subtract(months: 1);
      pageStartDate = start.dateTime;
      pageEndDate = Jiffy(lastDate).subtract(days: 1);
    } else {
      var firstDateOfCurrentMonth =
          Jiffy(DateTime(startDate.year, startDate.month))
            ..add(months: position);
      pageStartDate = firstDateOfCurrentMonth.dateTime;
      var a = firstDateOfCurrentMonth
        ..add(months: 1)
        ..subtract(days: 1);
      pageEndDate = a.dateTime;
    }
    return SomeDateRange(pageStartDate, pageEndDate);
  }

  show() {
    var heightContainer = 48 * 6;
    var endDateWording = " - $dateEndDate $monthEndDate $yearEndDate";
    return AlertDialog(
      titlePadding: EdgeInsets.fromLTRB(0, 16, 0, 5),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      title: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                if (mode == SomeMode.Range) ...[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "First Date",
                          style: TextStyle(
                              fontFamily: "playfair-regular", fontSize: 12,
                          color: Colors.black),
                        ),
                        SizedBox(
                          height: 2
                          ,
                        ),
                        Text(
                          "$date $month, $year",
                          style: TextStyle(
                              fontFamily: "playfair-regular",
                              color: Color(0xff365535).withAlpha(150),
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "last Date",
                          style: TextStyle(
                              fontFamily: "playfair-regular", fontSize: 12,
                          color: Colors.black),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          "$dateEndDate $monthEndDate, $yearEndDate",
                          style: TextStyle(
                              fontFamily: "playfair-regular",
                              color: Color(0xff365535),
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ] else if(mode == SomeMode.Single) ...[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Selected Date",
                          style: TextStyle(
                              fontFamily: "playfair-regular", fontSize: 12,
                              color: Colors.black),
                        ),
                        Text(
                          "$date $month, $year",
                          style: TextStyle(
                              fontFamily: "playfair-regular",
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ] else ...[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Selected Date",
                          style: TextStyle(
                              fontFamily: "playfair-regular", fontSize: 12,
                              color: Colors.black),
                        ),
                        Text(
                          "$month, $year",
                          style: TextStyle(
                              fontFamily: "playfair-regular",
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ]
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Divider(
            color: Color(0xffdedede),
            height: 1,
          ),
          SizedBox(
            height: 14,
          ),
        ],
      ),
      contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 10),
      content: Container(
        height: heightContainer.toDouble(),
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Container(
                      height: heightContainer.toDouble(), child: pageView),
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    elevation: 0,
                    color: Color(0xff365535),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(18)),
                    ),
                    onPressed: () {
                      if (mode == SomeMode.Multi || mode == SomeMode.Range) {
                        done(selectedDates);
                      } else if (mode == SomeMode.Single) {
                        done(selectedDate);
                      }
                      Navigator.of(context).pop();
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: 8, bottom: 8),
                      child: Text(
                        "Done",
                        style: TextStyle(
                            fontFamily: "Avenir",
                            fontSize: 14,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                RaisedButton(
                  elevation: 0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 8, bottom: 8),
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                          fontFamily: "Avenir",
                          fontSize: 14,
                          color: Color(0xff365535)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
