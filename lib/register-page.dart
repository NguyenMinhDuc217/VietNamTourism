import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget{
  @override
  _RegisterPageState createState()=>_RegisterPageState();
}
class _RegisterPageState extends State<RegisterPage>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Color(0xff1278f3),
      appBar: AppBar(title: Text('Đăng ký'),centerTitle:true),
      body: Center(child: Column(children: [
        
      ],),),
    );
  }
}