import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifemap_v7/constants.dart';
import 'dart:math' as math;
import 'package:lifemap_v7/models/surplusCash.dart';
import 'package:lifemap_v7/db/database_helper.dart';
import 'file:///C:/Users/Kristian/Desktop/Flutter/lifemap_v7/lib/Treasure/passiveIncome.dart';


class activeIncome extends StatefulWidget {
  @override
  _activeIncomeState createState() => _activeIncomeState();
}

class _activeIncomeState extends State<activeIncome> {
  Future <List<Cash>> cash;

  int userId, updateCashId;
  String cashVal, cashDesc;

  final formKey = new GlobalKey<FormState>();
  var dbHelper;
  bool isUpdate = false;

  TextEditingController _controllerCashDesc = TextEditingController();
  TextEditingController _controllerCashVal = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelper = DBHelper();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: (
      Stack(
        fit: StackFit.expand,
        children:<Widget>[
          Image.asset(
              'Assets/background2.png',
            fit: BoxFit.cover,
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: ListView(
              children: <Widget>[

                //title texts
                SizedBox(height: 40,),
                Container(
                  child: Column(
                    children: <Widget>[
                      Text('Active Income',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20.0,),
                _loader(),

              ],
            ),
          )
        ]
      )
      ),
    );
  }

  _loader() {
    return FutureBuilder(
      future: cash,
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          return dataTableUser(snapshot.data);
        }
        if (null == snapshot.data || snapshot.data.length == 0) {
          return Container(
            child: Column(
              children: <Widget>[
                // Center(child: Text("Click the 'Add Entry'")),
                Center(
                  child: FloatingActionButton(
                    elevation: 5.0,
                    child: Icon(Icons.add),
                    onPressed: _showDialog,
                  ),
                ),
              ],
            ),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  SingleChildScrollView dataTableUser(List<Cash> cash) {
//    var year;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(21),
            color: Colors.white70
        ),
        child: Column(
          children: <Widget>[
            DataTable(
              columns: [
                DataColumn(
                  label: Text(
                    'Description',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                  ),
                ),
                DataColumn(
                  label: Text('Value',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w400,
                          color: Colors.black)),
                ),
                DataColumn(label: Text("")),
              ],
              rows: cash
                  .map(
                    (cash) => DataRow(cells: [
                  DataCell(
                    Text(cash.cashDesc),
                    onTap: () {
                      setState(() {
                        isUpdate = true;
                        updateCashId = cash.cashId;
                      });
                      _controllerCashDesc.text = cash.cashDesc;
                      _controllerCashVal.text = cash.cashVal.toString();
                      _editDialog();
                    },
                  ),
                  DataCell(
                    Text(cash.cashVal.toString()),
                    onTap: () {
                      setState(() {
                        isUpdate = true;
                        updateCashId = cash.cashId;
                      });
                      _controllerCashDesc.text = cash.cashDesc;
                      _controllerCashVal.text = cash.cashVal.toString();
                      _editDialog();
                    },
                  ),
                  DataCell(
                    Icon(Icons.delete),
                    onTap: () {
                      
                    }
                  )
                ]),
              )
                  .toList(),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              child: Center(
                child: FloatingActionButton(
                  elevation: 5.0,
                  child: Icon(Icons.add),
                  onPressed: _showDialog,
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
              child: Center(
                child: RaisedButton(
                  elevation: 5.0,
                  child: Text("Next"),
                  onPressed: next,
                ),
              ),
            ),
          ],
        ),
      ),

      //Add & Next Button
    );
  }

  _showDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          // title: Text("Step 3.2"),
          // shape: RoundedRectangleBorder(),
            content: Form(
              key: formKey,
              child: Container(
                height: 140,
                child: Column(
                  children: <Widget>[
                    Text("Enter your Active Income"),
                    // SizedBox(height: 5.0,),
                    TextFormField(
                      validator: (val) {
                        return val.length == 0 ? "Field should not be empty" : null;
                      },
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        hintText: 'ex. Cash in Bank, Cash on Hand',
                        hintStyle: kHintTextStyle,
                        // border: InputBorder.none,
                        // contentPadding: EdgeInsets.all(8.0)
                      ),
                      onSaved: (val) => cashDesc = val,
                    ),
                    SizedBox(
                      height: 1.0,
                    ),
                    TextFormField(
                      validator: (val) {
                        return val.length == 0 ? "Field should not be empty" : null;
                      },
                      inputFormatters: [
                        DecimalTextInputFormatter(decimalRange: 2)
                      ],
                      keyboardType:
                      TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        labelText: "Cash Value",
                        hintText: "0.00",
                        hintStyle: kHintTextStyle,
                      ),
                      onSaved: (val) => cashVal = val,
                      // controller: test ,
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
              FlatButton(
                onPressed: _save,
                child: Text("Save"),
              ),
            ]));
  }

  _editDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          // title: Text("Step 3.2"),
          // shape: RoundedRectangleBorder(),
            content: Form(
              key: formKey,
              child: Container(
                height: 140,
                child: Column(
                  children: <Widget>[
                    Text("Update your Active Income"),
                    // SizedBox(height: 5.0,),
                    TextFormField(
                      validator: (val) {
                        return val.length == 0 ? "Field should not be empty" : null;
                      },
                      keyboardType: TextInputType.text,
                      controller: _controllerCashDesc,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        hintText: 'ex. Cash in Bank, Cash on Hand',
                        hintStyle: kHintTextStyle,
                        // border: InputBorder.none,
                        // contentPadding: EdgeInsets.all(8.0)
                      ),
                      onSaved: (val) => cashDesc = val,
                    ),
                    SizedBox(
                      height: 1.0,
                    ),
                    TextFormField(
                      validator: (val) {
                        return val.length == 0 ? "Field should not be empty" : null;
                      },
                      inputFormatters: [
                        DecimalTextInputFormatter(decimalRange: 2)
                      ],
                      keyboardType:
                      TextInputType.numberWithOptions(decimal: true),
                      controller: _controllerCashVal,
                      decoration: InputDecoration(
                        labelText: "Cash Value",
                        hintText: "0.00",
                        hintStyle: kHintTextStyle,
                      ),
                      onSaved: (val) => cashVal = val,
                      // controller: test ,
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
              FlatButton(
                onPressed: _save,
                child: Text("Save"),
              ),
            ]));
  }

  _refreshList() {
    setState(() {
      cash = dbHelper.getCash();
    });
  }

  _save() {
    if (isUpdate) {
      if(formKey.currentState.validate()){
        formKey.currentState.save();
        Cash e = Cash(updateCashId, cashDesc, double.parse(cashVal), userId);

        DBHelper().updateCash(e);
      }
      setState(() {
        isUpdate = false;
      });

    } else {
      if(formKey.currentState.validate()){
        formKey.currentState.save();
        Cash e = Cash(null, cashDesc, double.parse(cashVal), userId);

        DBHelper().saveCash(e);
      }

    }

    _refreshList();
    Navigator.pop(context);
  }

  next() {
    // print(double.parse(x));
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => passiveIncome()));
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