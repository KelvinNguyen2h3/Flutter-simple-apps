import 'package:flutter/material.dart';
import 'package:analog_clock/analog_clock.dart';
void main() => runApp(MyApp());
class MyApp extends StatelessWidget { @override
Widget build(BuildContext context) {
  return MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Clock'),
        backgroundColor: Colors.blueGrey, // Đặt màu nền cho thanh tiêu đề
        centerTitle: true, // Căn giữa tiêu đề
        titleTextStyle: TextStyle(
          color: Colors.white, // Đặt màu chữ cho tiêu đề
          fontSize: 24, // Đặt kích thước chữ cho tiêu đề
        ),
      ),
      body: Center(
        child: AnalogClock(
          decoration: BoxDecoration(
              border: Border.all(width: 3.0, color: Colors.black),
              color: Colors.black,
              shape: BoxShape.circle), // decoration
          width: 350.0,
          height: 350,
          isLive: true,
          hourHandColor: Colors.white,
          minuteHandColor: Colors.white,
          showSecondHand: true,
          numberColor: Colors.white,
          showNumbers: true,
          textScaleFactor: 1.5,
          showTicks: true,
          showDigitalClock: true,
          digitalClockColor: Colors.white,
//datetime: DateTime(2024, 1, 15, 9, 18, 0),
        ),
      ),
    ),
  );
}}