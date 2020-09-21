import 'package:flutter/material.dart';
import 'package:lifemap_v7/constants.dart';
import 'file:///C:/Users/serpe/Desktop/lifemap_v7/lib/screens/profileScreens/confirmProfileScreen.dart';
import 'package:lifemap_v7/screens/homescreen.dart';
// import 'package:testing_app/userCreation/page_4.dart';
// import 'package:testing_app/userCreation/page_2.dart';

class retireScreen extends StatefulWidget {
  String passedFname, passedLname, birthDate;
  retireScreen({this.passedFname, this.passedLname, this.birthDate});

  @override
  _retireScreen createState() => _retireScreen(passedFname, passedLname, birthDate);

}

class _retireScreen extends State<retireScreen>{

  String passedFname, passedLname, birthDate, retireAge;
  _retireScreen(this.passedFname, this.passedLname, this.birthDate);

  bool yes = false;
  bool no = false;
  static int selectedAge = 60;
  static TextEditingController selAge = TextEditingController();
  static String customRetAge = selAge.text;

  // final GlobalKey<FormState> _key3 = GlobalKey<FormState>();
  final formKey = new GlobalKey<FormState>();

  Widget _yes(){
    return Container(
        height: 20.0,
        child: Row(
            children: <Widget>[
              Theme(data: ThemeData(unselectedWidgetColor: Colors.black),
                child: Checkbox(value: yes,
                  checkColor: Colors.green,
                  activeColor: Colors.white,
                  onChanged: (value){
                    setState(() {

                      yes = value;

                    });


                  },
                ),
              ),
            ]
        )
    );
  }
  Widget _no(){
    return Container(
        height: 20.0,
        child: Row(
            children: <Widget>[
              Theme(data: ThemeData(unselectedWidgetColor: Colors.black,),
                child: Checkbox(value: no,
                  checkColor: Colors.green,
                  activeColor: Colors.white,
                  onChanged: (value){
                    setState(() {
                      no = value;
                    });

                  },
                ),
              ),
            ]
        )
    );
  }

  // Widget nextButton(){
  //   return   RaisedButton(
  //       child: Text('Next',
  //         style: TextStyle(
  //             fontSize: 20,
  //             fontWeight: FontWeight.w400
  //         ),
  //       ),
  //       onPressed: (){
  //
  //         if (!_key3.currentState.validate()) {
  //           return;
  //
  //         }
  //         _key3.currentState.save();
  //         // Navigator.push(context, MaterialPageRoute(builder: (context) => UserCreationScreen4(customRetAge: customRetAge,)));
  //
  //       });
  // }

  // yesOrNo(value){
  //   if (yes = true)
  //     {
  //       value = selectedAge;
  //       return value;
  //     }
  //   else if( no = true){
  //     selectedAge = int.parse(customRetAge);
  //     value = selectedAge;
  //     return value;
  //   }
  // }

  Widget backButton(){
    return RaisedButton(
      child: Text('Back',
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w400
        ),),
      onPressed: () => Navigator.pop(context),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                form(),
                // Center(
                //   child: Text('Will you retire by the age 60?',
                //     style: TextStyle(
                //       fontWeight: FontWeight.w400,
                //       fontSize: 20,
                //     ),
                //   ),
                // ),
                // SizedBox(height: 10.0,),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: <Widget>[
                //     Text('Yes',
                //       style: TextStyle(
                //           fontSize: 15,
                //           fontWeight: FontWeight.w400
                //       ) , ),
                //     _yes(),
                //     SizedBox(width: 10,),
                //     Text('No',
                //       style: TextStyle(
                //           fontSize: 15,
                //           fontWeight: FontWeight.w400
                //       ) , ),
                //     _no(),
                //   ],
                // ),
                // Visibility(
                //     visible: no,
                //     child: Form(
                //         key: _key3,
                //         child: Container(
                //           width: 250,
                //           child: TextFormField(
                //             decoration: InputDecoration(labelText: 'What Age will you retire?'),
                //             controller: selAge,
                //             validator: (String value){
                //               if(value.isEmpty){
                //                 return "Age is required";
                //               }
                //             },
                //             onSaved: (String value){
                //               selectedAge = int.parse(value);
                //             },
                //
                //           ),
                //         )
                //     )
                // ),
                //
                // SizedBox(height: 20.0,),
                //
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: <Widget>[
                //     backButton(),
                //     SizedBox(width: 30,),
                //     nextButton(),
                //   ],
                // )
              ],
            ),
          )
        ],
      ),
    );

  }


  form() {
    return Form (
      key: formKey,
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            TextFormField(
              keyboardType: TextInputType.number,
              style: TextStyle(color: Colors.black54,
                fontFamily: 'ArialMtBold',),
              decoration: InputDecoration(
                labelText: 'Retirement Age',
                hintText: 'Age',
//                contentPadding: EdgeInsets.only(top: 20.0,),
                hintStyle: kHintTextStyle,
              ),

              // validator: (val) => val.length ==  0 ? 'This field is required.' : null,
              onChanged: (text) => retireAge = text,
            ),


            SizedBox(height: 7.0,),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FlatButton(
                  splashColor: Colors.blueGrey,
                  onPressed: () {
                    Navigator.push(
                      context,
                      // MaterialPageRoute(builder: (context) => homeScreen()),
                      MaterialPageRoute(builder: (context) => confirmProfile(fName: passedFname, lName: passedLname, birthDate: birthDate, retire: retireAge,)),
                    );
                  },
                  child: Text('Next'),
                ),
                // FlatButton(
                //   splashColor: Colors.blueGrey,
                //   onPressed: (){},
                //   child: Text('Cancel'),
                // ),
              ],
            ),

            SizedBox(height: 30.0,),
//            Text ('Age: '+age.toString()),
          ],
        ),
      ),
    );
  }


}