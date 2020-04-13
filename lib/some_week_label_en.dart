import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SomeWeekLabelEN extends StatelessWidget {
  final Color textColor;

  const SomeWeekLabelEN({Key key, this.textColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
            child: Text(
          "Mon",
          textAlign: TextAlign.center,
          style: textStyle(),
        )),
        Expanded(
            child:
                Text("Tue", textAlign: TextAlign.center, style: textStyle())),
        Expanded(
            child:
                Text("Wed", textAlign: TextAlign.center, style: textStyle())),
        Expanded(
            child:
                Text("Thu", textAlign: TextAlign.center, style: textStyle())),
        Expanded(
            child:
                Text("Fri", textAlign: TextAlign.center, style: textStyle())),
        Expanded(
            child:
                Text("Sat", textAlign: TextAlign.center, style: textStyle())),
        Expanded(
            child:
                Text("Sun", textAlign: TextAlign.center, style: textStyle())),
      ],
    );
  }

  TextStyle textStyle() => TextStyle(
      fontFamily: "playfair-regular",
      fontSize: 14.2,
      fontWeight: FontWeight.w600,
      letterSpacing: 1,
      color: textColor);
}
