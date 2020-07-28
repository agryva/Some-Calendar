# some calendar
[![pub package](https://img.shields.io/pub/v/some_calendar.svg)](https://pub.dev/packages/some_calendar#-readme-tab-)
![License](https://img.shields.io/badge/license-MIT-blue.svg)
[![support](https://img.shields.io/badge/platform-flutter%7Cflutter%20web-ff69b4.svg?style=flat-square)](https://github.com/agryva/Some-Calendar)

<a href="https://github.com/Solido/awesome-flutter">
   <img alt="Awesome Flutter" src="https://img.shields.io/badge/Awesome-Flutter-blue.svg?longCache=true&style=flat-square" />
</a>

Custom calendar with Multi-select & range configurable calendar

## New Features
+ Added View Mode Somecalendar #15


## Help Maintenance
I've taken the time to make this library, help support to develop it or buy me coffee and snacks to be even more enthusiastic
<br/>
<a href="https://www.buymeacoffee.com/agryva" target="_blank"><img src="https://www.buymeacoffee.com/assets/img/custom_images/purple_img.png" alt="Buy Me A Coffee" style="height: auto !important;width: auto !important;" ></a>
[![Paypal](https://www.paypalobjects.com/webstatic/mktg/Logo/pp-logo-100px.png)](https://paypal.me/agryva)

## <a name="#gifDialog"></a>Gif Somecalendar (Dialog)

| <img src="https://raw.githubusercontent.com/agryva/Some-Calendar/master/screen/multi.gif" width="379px;"/><br /><sub><b>Multi</b></sub> | <img src="https://raw.githubusercontent.com/agryva/Some-Calendar/master/screen/range.gif" width="379px;"/><br /><sub><b>Range</b></sub> | <img src="https://raw.githubusercontent.com/agryva/Some-Calendar/master/screen/single.gif" width="379px;"/><br /><sub><b>Single</b></sub> |
| :---: | :---: | :---: |


## <a name="#getting-started"></a>Requirements to run the demo ##

### Setup
Add dependency to your pubspec.yaml:

```dart
some_calendar: ^{latest_version}
```

### Basic use
First, add an import to your code:
```dart
import 'package:some_calendar/some_calendar.dart';
```

### Setting Locale
First, add an import to your code:
```dart
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

  @override
  void initState() {
    initializeDateFormatting();
    Intl.systemLocale = 'en_En'; // to change the calendar format based on localization
    super.initState();
  }

```

### with dialog
Single Mode, add to your code:
```dart
    showDialog(
        context: context,
        builder: (_) => SomeCalendar(
          mode: SomeMode.Single,
          isWithoutDialog: false,
          selectedDate: selectedDate,
          labels: new Labels(
              dialogDone: 'Selesai',
              dialogCancel: 'Batal',
              dialogRangeFirstDate: 'Tanggal Pertama',
              dialogRangeLastDate: 'Tanggal Terakhir',
          ),
          startDate: Jiffy().subtract(years: 3),
          lastDate: Jiffy().add(months: 9),
          done: (date) {
            setState(() {
              selectedDate = date;
              showSnackbar(selectedDate.toString());
            });
          },
        ));
```

Multi Mode, add to your code:
```dart
    showDialog(
        context: context,
        builder: (_) => SomeCalendar(
          mode: SomeMode.Multi,
          startDate: Jiffy().subtract(years: 3),
          lastDate: Jiffy().add(months: 9),
          isWithoutDialog: false,
          selectedDates: selectedDates,
          viewMode: ViewMode.Edit,
          done: (date) {
            setState(() {
              selectedDates = date;
              showSnackbar(selectedDates.toString());
            });
          },
        ));
```

Range Mode, add to your code:
```dart
    showDialog(
        context: context,
        builder: (_) => SomeCalendar(
          mode: SomeMode.Range,
          startDate: Jiffy().subtract(years: 3),
          lastDate: Jiffy().add(months: 9),
          selectedDates: selectedDates,
          isWithoutDialog: false,
          viewMode: ViewMode.Edit,
          primaryColor: Colors.red,
          done: (date) {
            setState(() {
              selectedDates = date;
              showSnackbar(selectedDates.toString());
            });
          },
        ));
```

## SomeMode
| SomeMode |
| :---------------------- |
| Range
| Single
| Multi

## Parameters
| parameter                   | types           | defaultValues                                                                                                     |
| :---------------------- | :-------------: | :---------------------------------------------------------------------------------------------------------------: |
| primaryColor        | `color`        | Color(0xff365535) |
| textColor        | `color`        | Colors.black |
| selectedDate       | `Date`     | Date.now() |
| selectedDates| `Date[]`     | Date.now() + 4 days|
| isWithoutDialog| `bool`     | true|
| scrollDirection| `Axis`     | Axis.vertical|
| startDate| `Date`     | |
| lastDate| `Date`     | |
| mode| `SomeMode`     |  |
| viewMode| `ViewMode`     | ViewMode.Edit |

