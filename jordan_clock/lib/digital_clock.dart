import 'dart:async';

import 'package:flutter_clock_helper/model.dart';
import 'package:jordan_clock/utils/uidata.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

enum _Element { background, text, shadow, gradient }

final _lightTheme = {
  _Element.background: Color(0xFF81B3FE),
  _Element.text: Colors.black,
  _Element.shadow: Colors.white,
  _Element.gradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFCCCCCC), Color(0xFFAAAAAA),
    ],
  ),
};

final _darkTheme = {
  _Element.background: Colors.black,
  _Element.text: Colors.white,
  _Element.shadow: Color(0xFF174EA6),
  _Element.gradient: LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF111111), Color(0xFF000000),
    ],
  ),
};

class DigitalClock extends StatefulWidget {
  const DigitalClock(this.model);

  final ClockModel model;

  @override
  _DigitalClockState createState() => _DigitalClockState();
}

class _DigitalClockState extends State<DigitalClock> {
  DateTime _dateTime = DateTime.now();
  Timer _timer;

  @override
  void initState() {
    super.initState();
    widget.model.addListener(_updateModel);
    _updateTime();
    _updateModel();
  }

  @override
  void didUpdateWidget(DigitalClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.model.removeListener(_updateModel);
    widget.model.dispose();
    super.dispose();
  }

  void _updateModel() {
    setState(() {
    });
  }

  void _updateTime() {
    setState(() {
      _dateTime = DateTime.now();
      
      _timer = Timer(
        Duration(seconds: 1) - Duration(milliseconds: _dateTime.millisecond),
        _updateTime,
      );
    });
  }

  _returnShoe(str, h, w) {
    switch(str) {
      case "0" : { return Image.asset(UIData.jordan_0, height: double.parse(h), width: double.parse(w), ); }
      case "1" : { return Image.asset(UIData.jordan_1, height: double.parse(h), width: double.parse(w), ); }
      case "2" : { return Image.asset(UIData.jordan_2, height: double.parse(h), width: double.parse(w), ); }
      case "3" : { return Image.asset(UIData.jordan_3, height: double.parse(h), width: double.parse(w), ); }
      case "4" : { return Image.asset(UIData.jordan_4, height: double.parse(h), width: double.parse(w), ); }
      case "5" : { return Image.asset(UIData.jordan_5, height: double.parse(h), width: double.parse(w), ); }
      case "6" : { return Image.asset(UIData.jordan_6, height: double.parse(h), width: double.parse(w), ); }
      case "7" : { return Image.asset(UIData.jordan_7, height: double.parse(h), width: double.parse(w), ); }
      case "8" : { return Image.asset(UIData.jordan_8, height: double.parse(h), width: double.parse(w), ); }
      case "9" : { return Image.asset(UIData.jordan_9, height: double.parse(h), width: double.parse(w), ); }
      case "10" : { return Image.asset(UIData.jordan_10, height: double.parse(h), width: double.parse(w), ); }
      case "11" : { return Image.asset(UIData.jordan_11, height: double.parse(h), width: double.parse(w), ); }
      case "12" : { return Image.asset(UIData.jordan_12, height: double.parse(h), width: double.parse(w), ); }
      default : { return Image.asset(UIData.jordan_0, height: double.parse(h), width: double.parse(w), ); }
      break;
    } 
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    final colors = Theme.of(context).brightness == Brightness.light ? _lightTheme : _darkTheme;
    final hour = DateFormat(widget.model.is24HourFormat ? "HH" : "h").format(_dateTime);
    final minute = DateFormat("mm").format(_dateTime);
    final second = DateFormat("ss").format(_dateTime);
    final am_pm = DateFormat("a").format(_dateTime);
    final defaultTextStyle = TextStyle(
      color: colors[_Element.text],
      fontFamily: "JordanBoldGrunge",
      fontSize: 50,
    );

    return Container(
      decoration: BoxDecoration( gradient: colors[_Element.gradient] ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: Theme.of(context).brightness == Brightness.light
            ? <Widget>[ Image.asset(UIData.jordan_b, height:50, width:50) ]
            : <Widget>[ Image.asset(UIData.jordan_w, height:50, width:50) ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.model.is24HourFormat
            ? <Widget>[
                _returnShoe(hour[0], "170", "170"),
                _returnShoe(hour[1], "170", "170"),
              ]
            : <Widget>[
                _returnShoe(hour, "170", "170")
              ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _returnShoe(minute[0], "85", "85"),
              _returnShoe(minute[1], "85", "85"),
              Text(" : ", style: defaultTextStyle),
              _returnShoe(second[0], "85", "85"),
              _returnShoe(second[1], "85", "85"),
            ]
          ),
          SizedBox( height: 27.0 ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(hour + ":" + minute + ":" + second + " " + am_pm, style:defaultTextStyle),
            ]
          ),
        ],
      ),
    );
  }
}
