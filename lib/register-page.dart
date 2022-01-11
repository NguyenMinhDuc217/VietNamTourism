import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1278f3),
      appBar: AppBar(title: Text('Đăng ký'), centerTitle: true),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
              Container(
              width: 450,
              height: 50,
              margin: EdgeInsets.only(bottom: 10),
              child: const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Email',
                  fillColor: Colors.white,
                  filled: true,
                ),
                textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical.center,
              ),
            ),
            Container(
              width: 450,
              height: 50,
              margin: EdgeInsets.only(bottom: 10),
              child: const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Password',
                  fillColor: Colors.white,
                  filled: true,
                ),
                textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical.center,
              ),
            ),
            Container(
              width: 450,
              height: 50,
              margin: EdgeInsets.only(bottom: 10),
              child: const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Confirm Password',
                  fillColor: Colors.white,
                  filled: true,
                ),
                textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical.center,
              ),
            ),
            ],),
            
            Container(
              margin: EdgeInsets.only(top: 50),
              width: 450,
              height: 50,
              child: TextButton(
                child: Text(
                  'REGISTER NOW',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  showDialog(
                context: context,
                builder: (BuildContext) => AlertDialog(
                      title: Text('Thông báo'),
                      content: Text('Đăng ký thành công'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: Text("OK"),
                        ),
                      ],
                    ));
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
