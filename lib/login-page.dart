import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vietnamtourism/main.dart';
import './model/tai-khoan.dart';
import 'package:vietnamtourism/register-page.dart';

import 'api.dart';
import 'manager-page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _controller1 = TextEditingController();
  final _controller2 = TextEditingController();
  List<ThongTinTaiKhoan> _taiKhoan = [];
  @override
  Widget build(BuildContext context) {
    bool CheckLogin(String username, String pass) {
      Iterable s = [];
      API(url: "http://10.0.2.2/vietnamtourism/api/dang_nhap.php?username=$username&password=$pass")
          .getDataString()
          .then((value) {
        s = json.decode(value);
        if (_taiKhoan.isNotEmpty) {
          s = [];
          _taiKhoan.clear();
        }
        if (s.isNotEmpty) {
          _taiKhoan.add(new ThongTinTaiKhoan(
              id: int.parse(s.elementAt(0)["id"].toString()),
              ten_nguoi_dung: s.elementAt(0)["ten_nguoi_dung"].toString(),
              email: s.elementAt(0)["email"].toString(),
              mat_khau: s.elementAt(0)["mat_khau"].toString(),
              sdt: s.elementAt(0)["sdt"].toString().isNotEmpty?s.elementAt(0)["sdt"].toString():"",
              trangThai: int.parse(s.elementAt(0)["trang_thai"].toString()),
              loai_tai_khoan:
                  int.parse(s.elementAt(0)["loai_tai_khoan"].toString())));
        }
        setState(() {});
      });
      if (_taiKhoan.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    }

    Widget imgSection = Image.network(
      'https://upload.wikimedia.org/wikipedia/commons/thumb/2/21/Flag_of_Vietnam.svg/1200px-Flag_of_Vietnam.svg.png',
      alignment: Alignment.center,
      width: 150,
      height: 150,
    );
    Widget TextSection = Container(
      child: Column(
        children: [
          Container(
            child: Text(
              'SignIn',
              style: TextStyle(fontSize: 50, color: Colors.white),
            ),
          ),
          Text('Speak, friend, and enter'),
        ],
      ),
    );
    Widget LoginSection = Container(
      child: Column(
        children: [
          Container(
            width: 450,
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
            width: 450,
            height: 50,
            child: TextField(
              controller: _controller2,
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
        ],
      ),
    );
    Widget SignInButton = Container(
      width: 450,
      height: 50,
      child: TextButton(
        child: Text(
          'SIGN IN',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          if (_controller1.text.trim() == " " ||
              _controller2.text.trim() == "") {
            showDialog(
                context: context,
                builder: (BuildContext) => AlertDialog(
                      title: Text('Thông báo'),
                      content: Text('Chưa nhập thông tin!'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("OK"),
                        ),
                      ],
                    ));
          } else if (_controller1.text==_controller2.text) {
            // CheckLogin(_controller1.text, _controller2.text)
            // if (_taiKhoan.first.loai_tai_khoan == 1) {
            //   Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => ManagerPage(tk: _taiKhoan.first)));
            // } else {
            //   Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //           builder: (context) => MyHomePage(tk: _taiKhoan.first)));
            // }
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => MyHomePage()));
          } else {
            showDialog(
                context: context,
                builder: (BuildContext) => AlertDialog(
                      title: Text('Thông báo'),
                      content:
                          Text('Tài khoản và mật khẩu không trùng khớp !!!'),
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
          backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
        ),
      ),
    );
    Widget RegisterButton = Container(
      margin: EdgeInsets.only(top: 10),
      width: 450,
      height: 50,
      child: TextButton(
        child: Text(
          'REGISTER NOW',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => RegisterPage()));
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
        ),
      ),
    );
    Widget ButtonSection = Container(
      child: Column(
        children: [SignInButton, RegisterButton],
      ),
    );
    return Scaffold(
      backgroundColor: Color(0xff1278f3),
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [imgSection, TextSection, LoginSection, ButtonSection],
        ),
      )),
    );
  }
}
