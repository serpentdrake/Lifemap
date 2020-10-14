import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifemap_v7/constants.dart';
import 'package:lifemap_v7/screens/homescreen.dart';

import 'dart:math' as math;

import 'file:///C:/Users/serpe/Desktop/lifemap_v7/lib/screens/setUpScreens/surplusCashScreen.dart';

class monthlyExpensesScreen extends StatefulWidget {
  @override
  _monthlyExpensesScreen createState() => _monthlyExpensesScreen();
}

class _monthlyExpensesScreen extends State<monthlyExpensesScreen> {
  TextEditingController _controller = TextEditingController();

  final formKey = new GlobalKey<FormState>();

  String x;
  bool retFund = false;
  bool locField;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('Assets/background2.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListView(
            children: <Widget>[
              SizedBox(
                height: 80.0,
              ),
              //Step 1 Text
              Container(
                height: 120.0,
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Step 3",
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'ArialMtBold',
                        ),
                      ),
                      Text('Identify your Target Retirement Fund'),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              //form
              form(),
              SizedBox(
                height: 10.0,
              ),
              Column(
                children: <Widget>[
                  RaisedButton(
                    elevation: 5.0,
                    child: Text(
                      'Next',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'ArialMtBold'),
                    ),
                    onPressed: next,
                  ),
                ],
              ),




            ],
          ),
        ],
      ),
    );
  }

  form() {
    return Form(
        key: formKey,
        child: Container(
          height: 200,
          padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: <Widget>[
              Container(
                height: 60,
                width: 300,
                child: TextFormField(
                  // keyboardType: TextInputType.number,
                  inputFormatters: [DecimalTextInputFormatter(decimalRange: 2)],
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: "Estimated Monthly Expenses",
                    hintText: "0.00",
                    hintStyle: kHintTextStyle,
                  ),
                  onChanged: (val) => x = val,
                ),
              ),
            ],
          ),
        ));
  }



  next() {
    print(double.parse(x));
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => surplusCashScreen()));
  }
}

class DecimalTextInputFormatter extends TextInputFormatter {
  DecimalTextInputFormatter({this.decimalRange})
      : assert(decimalRange == null || decimalRange > 0);

  final int decimalRange;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, // unused.
      TextEditingValue newValue,
      ) {
    TextSelection newSelection = newValue.selection;
    String truncated = newValue.text;

    if (decimalRange != null) {
      String value = newValue.text;

      if (value.contains(".") &&
          value.substring(value.indexOf(".") + 1).length > decimalRange) {
        truncated = oldValue.text;
        newSelection = oldValue.selection;
      } else if (value == ".") {
        truncated = "0.";

        newSelection = newValue.selection.copyWith(
          baseOffset: math.min(truncated.length, truncated.length + 1),
          extentOffset: math.min(truncated.length, truncated.length + 1),
        );
      }

      return TextEditingValue(
        text: truncated,
        selection: newSelection,
        composing: TextRange.empty,
      );
    }
    return newValue;
  }
}