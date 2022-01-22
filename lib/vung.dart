import 'package:flutter/material.dart';
import 'package:vietnamtourism/chitietvung.dart';

class Vung extends StatefulWidget{
  @override
  State<Vung> createState()=>_VungState();
}
class _VungState extends State<Vung>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (BuildContext context, int Index){
          return Card(
            child: ListTile(
              leading: Positioned(
                left: 20.0,
                top: 15.0,
                bottom: 15.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image.network('https://upload.wikimedia.org/wikipedia/commons/thumb/a/ae/Da_Lat%2C_view_to_Xuan_Huong_lake_2.jpg/330px-Da_Lat%2C_view_to_Xuan_Huong_lake_2.jpg',
                  width: 110),
                ),
              ),
              title: Text('Tây Nguyên'),
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ChitietvungPage()));
              },
            ),
          );
        },
      ),
    );
  }
}