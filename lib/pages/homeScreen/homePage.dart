import 'package:flutter/material.dart';
import 'package:lifemap_betav1/pages/setUpScreens/createUser.dart';
import 'package:lifemap_betav1/providers/db_provider.dart';
import 'package:lifemap_betav1/pages/screens/userInfoScreen.dart';

class homePage extends StatefulWidget {
  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  var isLoading = false;
  var help;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    help = userInfoSummary();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'Assets/background2.png',
            fit: BoxFit.cover,
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent.withOpacity(0.2),
            ),
            body: ListView(
              scrollDirection: Axis.vertical,
              physics: ScrollPhysics(),
              children: [
                SizedBox(height: 40.0,),
                Container(
                  child: Column(
                    children: [
                      Container(
                        child: Text(
                          'Summary',
                          style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
                Container(child: userInfoSummary(),),
              ],
            ),
          ),
        ],
      ),
    );
  }



  _loadFromApi() async {
    setState(() {
      isLoading = true;
    });

    var dbProvider = DBProvider.db;
    await dbProvider.getAllUser();

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });
  }

  _deleteData() async {
    setState(() {
      isLoading = true;
    });

    await DBProvider.db.deleteAllUser();

    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      isLoading = false;
    });

    print('Deleted');
  }
}


