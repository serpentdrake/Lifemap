import 'package:flutter/material.dart';
import 'package:lifemap_betav1/providers/db_provider.dart';

class userInfoSummary extends StatelessWidget {
  const userInfoSummary({
    Key key,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DBProvider.db.getAllUser(),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        if(!snapshot.hasData){
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.separated(
            separatorBuilder: (context, index) => Divider(
              color: Colors.black12,
            ),
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index){
              return Text('${snapshot.data[index].monthIn.toString()}');
            },
          );
        }
      },
    );
  }
}