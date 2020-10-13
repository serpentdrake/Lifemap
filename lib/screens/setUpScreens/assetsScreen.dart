import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifemap_v7/constants.dart';
import 'package:lifemap_v7/screens/homescreen.dart';
import 'package:lifemap_v7/models/asset.dart';
import 'package:lifemap_v7/db/database_helper.dart';
import 'dart:math' as math;

class assetScreen extends StatefulWidget {
  @override
  _assetScreen createState() => _assetScreen();
}

class _assetScreen extends State<assetScreen> {
  Future<List<Asset>> asset;
  TextEditingController _controller = TextEditingController();

  int userId;
  String assetDesc, assetVal;

  final formKey = new GlobalKey<FormState>();

  var dbHelper;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelper = DBHelper();
  }

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



          Container(
            // height: 120.0,
            child: Center(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 80.0,),
                  Text(
                    "Step 3",
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'ArialMtBold',
                    ),
                  ),
                  Text('Identify your Target Retirement Fund'),
                  SizedBox(height: 30.0,),
                  _listCash(),
                  // SizedBox(height: 10.0,),

                ],
              ),
            ),
          ),

          // Container(
          //   child: Center(
          //     child: RaisedButton(
          //       elevation: 5.0,
          //       child: Text("Add Entry"),
          //       onPressed: _showDialog,
          //     ),
          //   ),
          // ),
          SizedBox(height: 20.0,),





        ],
      ),
    );
  }

  _refreshList() {
    setState(() {
      asset = dbHelper.getAsset();
    });
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
                    Text("Enter your Productive Asset"),
                    // SizedBox(height: 5.0,),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        hintText: 'ex. House, Car',
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
                      inputFormatters: [DecimalTextInputFormatter(decimalRange: 2)],
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        labelText: "Asset Value",
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

  SingleChildScrollView dataTableUser(List<Asset> asset) {
//    var year;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: <Widget>[
          DataTable(
            columns: [
              DataColumn(
                label: Text('Description'),
              ),
              DataColumn(
                label: Text('Value'),
              ),
            ],
            rows: asset
                .map(
                  (asset) => DataRow(cells: [
                DataCell(
                  Text(asset.assetDesc),
                  onTap: () {},
                ),

                DataCell(
                  Text(asset.assetVal.toString()),
                  onTap: () {},
                ),
              ]),
            )
                .toList(),
          ),

          SizedBox(height: 20.0,),
          Container(
            child: Center(
              child: RaisedButton(
                elevation: 5.0,
                child: Text("Add Entry"),
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

      //Add & Next Button

    );
  }

  _listCash() {
    return Expanded(
      child: FutureBuilder(
        future: asset,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return dataTableUser(snapshot.data);

          }

          if (null == snapshot.data || snapshot.data.length == 0) {
            return Container(
              child: Column(
                children: <Widget>[
                  Center(child: Text("Click the 'Add Entry'")),
                  Center(child: RaisedButton(elevation: 5.0, child: Text("Add Entry"), onPressed: _showDialog,),),
                ],
              ),
            );
          }
//          refreshList();
          return CircularProgressIndicator();
        },
      ),
    );
  }

  _save() {
    if(formKey.currentState.validate()) {
      formKey.currentState.save();
      Asset e = Asset(null, assetDesc, double.parse(assetVal), userId);

      dbHelper.saveAsset(e);
      _refreshList();

      Navigator.pop(context);
    }
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