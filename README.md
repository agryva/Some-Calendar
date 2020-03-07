# some calendar
[![pub package](https://img.shields.io/pub/v/some_calendar.svg)](https://pub.dev/packages/some_calendar#-readme-tab-)
![License](https://img.shields.io/badge/license-MIT-blue.svg)

Custom calendar (multi select, single select, date range) for Flutter


## New Features
+ You can use favorite color :tada:.

## Table of contents

* [Getting Started](#getting-started)
* [Screenshoot](#screenshot)

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

Single Mode, add to your code:
```dart
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
```

Multi Mode, add to your code:
```dart
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
| startDate| `Date`     | |
| lastDate| `Date`     | |
| selectedDate       | `Date`     | Date.now() |
| selectedDates| `Date`     | Date.now() + 4 days|
| mode| `SomeMode`     |  |

## <a name="#screenshot"></a>Screenshoot ##

| <img src="https://raw.githubusercontent.com/agryva/Some-Calendar/master/screen/multi.jpg" width="379px;"/><br /><sub><b>Multi</b></sub> | <img src="https://raw.githubusercontent.com/agryva/Some-Calendar/master/screen/range.jpg" width="379px;"/><br /><sub><b>Range</b></sub> | <img src="https://raw.githubusercontent.com/agryva/Some-Calendar/master/screen/single.jpg" width="379px;"/><br /><sub><b>Single</b></sub> |
| :---: | :---: | :---: |

## Help Maintenance
I've taken the time to make this library, help support to develop it or buy me coffee and snacks to be even more enthusiastic
<br/>
[![Paypal](https://www.paypalobjects.com/webstatic/mktg/Logo/pp-logo-100px.png)](https://paypal.me/agryva)