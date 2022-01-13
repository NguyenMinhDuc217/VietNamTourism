import 'dart:convert';

import 'package:flutter/material.dart';

import 'api.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _controller1 = TextEditingController();
  final _controller2 = TextEditingController();
  final _controller3 = TextEditingController();
  final _controller4 = TextEditingController();

  bool RegisterCheck(String username, String nick, String pass) {
    Iterable s = [];
    API(url: "http://10.0.2.2/vietnamtourism/api/dang_ki.php?username=$username&nick=$nick&password=$pass")
        .getDataString()
        .then((value) {
      if (s.isNotEmpty) {
        s = [];
      }
      s = json.decode(value);

      setState(() {});
    });
    if (s.length > 0) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1278f3),
      appBar: AppBar(title: Text('Đăng ký'), centerTitle: true),
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 350,
                  height: 50,
                  margin: EdgeInsets.only(bottom: 10),
                  child: TextField(
                    controller: _controller1,
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
                  width: 350,
                  height: 50,
                  margin: EdgeInsets.only(bottom: 10),
                  child: TextField(
                    controller: _controller2,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Tên người dùng',
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    textAlign: TextAlign.center,
                    textAlignVertical: TextAlignVertical.center,
                  ),
                ),
                Container(
                  width: 350,
                  height: 50,
                  margin: EdgeInsets.only(bottom: 10),
                  child: TextField(
                    controller: _controller3,
                    obscureText: true,
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
                  width: 350,
                  height: 50,
                  margin: EdgeInsets.only(bottom: 10),
                  child: TextField(
                    controller: _controller4,
                    obscureText: true,
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
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 50),
              width: 350,
              height: 50,
              child: TextButton(
                child: Text(
                  'REGISTER NOW',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  if (_controller1.text.trim() == " " ||
                      _controller2.text.trim() == "" ||
                      _controller3.text.trim() == "" ||
                      _controller4.text.trim() == "") {
                    showDialog(
                        context: context,
                        builder: (BuildContext) => AlertDialog(
                              title: Text('Thông báo'),
                              content: Text('Chưa nhập đủ thông tin!'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("OK"),
                                ),
                              ],
                            ));
                  } else if (_controller3.text == _controller4.text) {
                    if (RegisterCheck(_controller1.text, _controller2.text,
                        _controller3.text)) {
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
                    }
                  } else {
                    showDialog(
                        context: context,
                        builder: (BuildContext) => AlertDialog(
                              title: Text('Thông báo'),
                              content: Text('mật khẩu không trùng nhau !!!'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("OK"),
                                ),
                              ],
                            ));
                  }
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
