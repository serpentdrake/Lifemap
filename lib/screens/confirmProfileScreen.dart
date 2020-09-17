import 'package:flutter/material.dart';

class confirmProfile extends StatefulWidget {
  @override
  _confirmProfile createState() => _confirmProfile();
}

class _confirmProfile extends State<confirmProfile> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirm Screen'),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
//            decoration: BoxDecoration(
//              image: DecorationImage(
//                image: AssetImage('images/assets/background2.jpg'),
//                fit: BoxFit.cover,
//              ),
//            ),
            child: SingleChildScrollView(physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: 48.0,
                vertical: 100.0,
              ),
              child: Container(
                padding: EdgeInsets.all(24.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20.0,),
                    // form(),
                    Padding(
                      padding: const EdgeInsets.only(left: 45.0),
                      child: Row(
                        children: <Widget>[
                          Text('First Name: ',
                            style:TextStyle(
                             fontSize: 18,
                             fontWeight: FontWeight.w400
                            ),
                          ),
                          SizedBox(width: 10.0,),
                          Text('Jake',
                            style:TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400
                            ),),
                        ],
                      ),
                    ),
                    SizedBox(height: 15.0,),
                    Padding(
                      padding: const EdgeInsets.only(left: 45.0),
                      child: Row(

                        children: <Widget>[
                          Text('Last Name: ',
                            style:TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400
                            ),),
                          SizedBox(width: 10.0,),
                          Text('Wally',
                            style:TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400
                            ),),
                        ],
                      ),
                    ),
                    SizedBox(height: 15.0,),
                    Padding(
                      padding: const EdgeInsets.only(left: 45.0),
                      child: Row(

                        children: <Widget>[
                          Text('Date of Birth: ',
                            style:TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400
                            ),),
                          SizedBox(width: 10.0,),
                          Text('12/22/97',
                            style:TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400
                            ),),
                        ],
                      ),
                    ),



                    SizedBox(height: 30.0,),

                    RaisedButton(onPressed: null, child: null)


                  ],
                ),
              ),
            ),
          ),

        ],

      ),
    );
  }
}