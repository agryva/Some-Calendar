# some calendar
[![pub package](https://img.shields.io/pub/v/some_calendar.svg)](https://pub.dev/packages/some_calendar#-readme-tab-)

Custom calendar (multi select, single select, date range) for Flutter

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
          done: (date) {
            setState(() {
              selectedDates = date;
              showSnackbar(selectedDates.toString());
            });
          },
        ));
```

## <a name="#screenshot"></a>Screenshoot ##

| <img src="https://raw.githubusercontent.com/agryva/Some-Calendar/master/screen/multi.jpg" width="379px;"/><br /><sub><b>Multi</b></sub> | <img src="https://raw.githubusercontent.com/agryva/Some-Calendar/master/screen/range.jpg" width="379px;"/><br /><sub><b>Range</b></sub> | <img src="https://raw.githubusercontent.com/agryva/Some-Calendar/master/screen/single.jpg" width="379px;"/><br /><sub><b>Single</b></sub> |
| :---: | :---: | :---: |

## License MIT License

Copyright (c) 2020 Irvan Lutfi Gunawan

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.