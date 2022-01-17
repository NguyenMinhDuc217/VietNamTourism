import 'package:flutter/material.dart';
import 'package:vietnamtourism/model/tai-khoan.dart';

import 'destination.dart';
import 'login-page.dart';

void main() {
  runApp(MaterialApp(
    title: 'Viet Name Tourism',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      fontFamily: 'Roboto',
    ),
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LoginPage();
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({required this.tk});
  final ThongTinTaiKhoan tk;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;
  Widget _diaDanh = DiaDanh();
  Widget _diaDanhLuuTru = DiaDanhLuuTru();
  Widget _vung = Vung();
  Widget _taiKhoan = TaiKhoan();

  Widget getBody() {
    if (this.selectedIndex == 0) {
      return this._diaDanh;
    } else if (this.selectedIndex == 1) {
      return this._diaDanhLuuTru;
    } else if (this.selectedIndex == 2) {
      return this._vung;
    } else {
      return this._taiKhoan;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Viet Name Tourism'),
      ),
      body: this.getBody(),
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Row(
                children: [
                  CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('images/logo/logoMU.jpg'),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(30),
                        onTap: () {},
                      )),
                  Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Flexible(child:Text(
                        widget.tk.ten_nguoi_dung,
                        //'PaHuHo',
                        style: TextStyle(fontSize: 15),
                      ))),
                ],
              )),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.person),
                Container(
                    margin: EdgeInsets.only(left: 10), child: Text('Tài khoản')),
              ],
            ),
            onTap: () {},
          ),
          ListTile(
            title: Row(
              children: [
                Icon(Icons.logout),
                Container(
                    margin: EdgeInsets.only(left: 10), child: Text('Đăng xuất'))
              ],
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
          )
        ],
      )),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: this.selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.edit_location),
            title: Text('Địa danh'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit_location_outlined),
            title: Text('Địa danh lưu trú'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_location_alt_rounded),
            title: Text('Vùng'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('Cá nhân'),
          ),
        ],
        onTap: (int index) {
          this.onTapHandler(index);
        },
      ),
    );
  }

  void onTapHandler(int index) {
    this.setState(() {
      this.selectedIndex = index;
    });
  }
}

class DiaDanhLuuTru extends StatefulWidget {
  @override
  State<DiaDanhLuuTru> createState() => _DiaDanhLucTruState();
}

class _DiaDanhLucTruState extends State<DiaDanhLuuTru> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Địa danh lưu trú'));
  }
}

class Vung extends StatefulWidget {
  @override
  State<Vung> createState() => _VungState();
}

class _VungState extends State<Vung> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Vùng'));
  }
}

class TaiKhoan extends StatefulWidget {
  @override
  State<TaiKhoan> createState() => _TaiKhoanState();
}

class _TaiKhoanState extends State<TaiKhoan> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Tài khoản'));
  }
}
