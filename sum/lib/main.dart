import 'package:flutter/material.dart';

void main() {
  runApp(SumCalculator());
}

class SumCalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Sum'),
        ),
        body: SumCalculatorScreen(),
      ),
    );
  }
}

class SumCalculatorScreen extends StatefulWidget {
  @override
  _SumCalculatorScreenState createState() => _SumCalculatorScreenState();
}

class _SumCalculatorScreenState extends State<SumCalculatorScreen> {
  TextEditingController num1Controller = TextEditingController();
  TextEditingController num2Controller = TextEditingController();
  double result = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: num1Controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Nhập số thứ nhất'),
          ),
          TextField(
            controller: num2Controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Nhập số thứ hai'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              calculateSum();
            },
            child: Text('Tính Tổng'),
          ),
          SizedBox(height: 20),
          Text(
            'Tổng: $result',
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }

  void calculateSum() {
    double num1 = double.tryParse(num1Controller.text) ?? 0;
    double num2 = double.tryParse(num2Controller.text) ?? 0;

    setState(() {
      result = num1 + num2;
    });
  }
}
