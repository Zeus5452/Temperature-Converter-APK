import 'dart:io';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const String _title = 'Temp Convert';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
      //debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(MyApp._title)),
      body: TempNumWidget(),
    );
  }
}

class TempNumWidget extends StatefulWidget {
  TempNumWidget({Key key}) : super(key: key);

  @override
  _TempNumWidgetState createState() => _TempNumWidgetState();
}

class _TempNumWidgetState extends State<TempNumWidget> {
  final _formKey = GlobalKey<FormState>();

  String output;
  String output2;
  TextEditingController inputController;

  void tempConverter(String input) {
    setState(() {
      input = input.trim();
      String inputSubstring;

      for (var i = 0; i < input.length; i++) {
        inputSubstring = input[i].toUpperCase();
        if (inputSubstring.contains('C')) {
          output = (double.parse(input.substring(0, i)) + 273.15)
                  .toStringAsFixed(2) +
              ' \u00B0K';
          output2 = ((double.parse(input.substring(0, i)) * 9 / 5) + 32)
                  .toStringAsFixed(2) +
              '\u00B0F';
        } else if (inputSubstring.contains('F')) {
          output = ((double.parse(input.substring(0, i)) - 32) * 5 / 9 + 273.15)
                  .toStringAsFixed(2) +
              ' \u00B0K';
          output2 = ((double.parse(input.substring(0, i)) - 32) * 5 / 9)
                  .toStringAsFixed(2) +
              ' \u00B0C';
        } else if (inputSubstring.contains('K')) {
          output = (double.parse(input.substring(0, i)) - 273.15)
                  .toStringAsFixed(2) +
              ' \u00B0C';
          output2 =
              ((double.parse(input.substring(0, i)) - 273.15) * 9 / 5 + 32)
                      .toStringAsFixed(2) +
                  ' \u00B0F';
        } else {
          output = 'Invalid input';
          output2 = output;
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Enter a Temp',
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.only(left: 200.0, top: 10.0, right: 00.0),
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10.0),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              //color: Theme.of(context).primaryColor,
              child: Text(
                "\u00B0F: ",
                style: TextStyle(color: Colors.black, fontSize: 20.0),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 200.0, top: 10.0, right: 00.0),
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10.0),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              //color: Theme.of(context).primaryColor,
              child: Text(
                "\u00B0C: ",
                style: TextStyle(color: Colors.black, fontSize: 20.0),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 200.0, top: 10.0, right: 00.0),
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10.0),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              //color: Theme.of(context).primaryColor,
              child: Text(
                "\u00B0K: ",
                style: TextStyle(color: Colors.black, fontSize: 20.0),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate will return true if the form is valid, or false if
                // the form is invalid.
                if (_formKey.currentState.validate()) {
                  // Process data.
                }
              },
              child: Text('Submit'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: TextField(
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: 'Ex: 150 \u00B0C',
              ),
              controller: inputController,
              onSubmitted: (text) {
                tempConverter(text);
              },
            ),
          ),
          //Auto Temp Convert
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 10.0, right: 20.0),
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10.0),
              color: Theme.of(context).primaryColor,
              child: Text(
                output ?? 'No input provided.',
                style: TextStyle(color: Colors.black, fontSize: 20.0),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 10.0, right: 20.0),
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10.0),
              color: Theme.of(context).primaryColor,
              child: Text(
                output2 ?? 'No input provided.',
                style: TextStyle(color: Colors.black, fontSize: 20.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
