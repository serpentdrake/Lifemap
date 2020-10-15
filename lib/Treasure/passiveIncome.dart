import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifemap_v7/constants.dart';
import 'dart:math' as math;
import 'package:lifemap_v7/models/asset.dart';
import 'package:lifemap_v7/db/database_helper.dart';
import 'package:lifemap_v7/screens/homescreen.dart';


class passiveIncome extends StatefulWidget {
  @override
  _passiveIncomeState createState() => _passiveIncomeState();
}

class _passiveIncomeState extends State<passiveIncome> {
  Future <List<Asset>> asset;

  int userId, updateAssetId;
  String assetVal, assetDesc;

  final formKey = new GlobalKey<FormState>();
  var dbHelper;
  bool isUpdate = false;

  TextEditingController _controllerAssetDesc = TextEditingController();
  TextEditingController _controllerAssetVal = TextEditingController();

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
                            Text('Passive Income',
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
      future: asset,
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

  SingleChildScrollView dataTableUser(List<Asset> asset) {
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
              rows: asset
                  .map(
                    (asset) => DataRow(cells: [
                  DataCell(
                    Text(asset.assetDesc),
                    onTap: () {
                      setState(() {
                        isUpdate = true;
                        updateAssetId = asset.assetId;
                      });
                      _controllerAssetDesc.text = asset.assetDesc;
                      _controllerAssetVal.text = asset.assetVal.toString();
                      _editDialog();
                    },
                  ),
                  DataCell(
                    Text(asset.assetVal.toString()),
                    onTap: () {
                      setState(() {
                        isUpdate = true;
                        updateAssetId = asset.assetId;
                      });
                      _controllerAssetDesc.text = asset.assetDesc;
                      _controllerAssetVal.text = asset.assetVal.toString();
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
                    Text("Enter your Passive Income"),
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
                      onSaved: (val) => assetDesc = val,
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
                      onSaved: (val) => assetVal = val,
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
                    Text("Update your Passive Income"),
                    // SizedBox(height: 5.0,),
                    TextFormField(
                      validator: (val) {
                        return val.length == 0 ? "Field should not be empty" : null;
                      },
                      keyboardType: TextInputType.text,
                      controller: _controllerAssetDesc,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        hintText: 'ex. Cash in Bank, Cash on Hand',
                        hintStyle: kHintTextStyle,
                        // border: InputBorder.none,
                        // contentPadding: EdgeInsets.all(8.0)
                      ),
                      onSaved: (val) => assetDesc = val,
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
                      controller: _controllerAssetVal,
                      decoration: InputDecoration(
                        labelText: "Cash Value",
                        hintText: "0.00",
                        hintStyle: kHintTextStyle,
                      ),
                      onSaved: (val) => assetVal = val,
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
      asset = dbHelper.getAsset();
    });
  }

  _save() {
    if (isUpdate) {
      if(formKey.currentState.validate()){
        formKey.currentState.save();
        Asset e = Asset(updateAssetId, assetDesc, double.parse(assetVal), userId);

        DBHelper().updateAsset(e);
      }
      setState(() {
        isUpdate = false;
      });

    } else {
      if(formKey.currentState.validate()){
        formKey.currentState.save();
        Asset e = Asset(null, assetDesc, double.parse(assetVal), userId);

        DBHelper().saveAsset(e);
      }

    }

    _refreshList();
    Navigator.pop(context);
  }

  next() {
    // print(double.parse(x));
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => homeScreen()));
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