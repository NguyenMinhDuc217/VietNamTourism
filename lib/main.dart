import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vietnam Tourism',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Vietnam Tourism Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;
  Widget _diaDanh = DiaDanh();
  Widget _diaDanhLuuTru = DiaDanhLuuTru();
  Widget _vung=Vung();
  Widget _taiKhoan = TaiKhoan();

  Widget getBody( )  {
    if(this.selectedIndex == 0) {
      return this._diaDanh;
    } else if(this.selectedIndex==1) {
      return this._diaDanhLuuTru;
    } else if(this.selectedIndex==2){
      return this._vung;
    } else{
      return this._taiKhoan;
    }
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: this.getBody(),
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
            title: Text('Tài khoản'),
          ),
        ],
        onTap: (int index) {
          this.onTapHandler(index);
        },
      ),
    );
  }
  void onTapHandler(int index)  {
    this.setState(() {
      this.selectedIndex = index;
    });
  }
}

class DiaDanh extends StatefulWidget{
  @override
  State<DiaDanh> createState()=>_DiaDanhState();
}
class _DiaDanhState extends State<DiaDanh>{
  @override
  Widget build(BuildContext context){
    return Center(child: Text('Địa danh'));
  }
}

class DiaDanhLuuTru extends StatefulWidget{
  @override
  State<DiaDanhLuuTru> createState()=>_DiaDanhLucTruState();
}
class _DiaDanhLucTruState extends State<DiaDanhLuuTru>{
  @override
  Widget build(BuildContext context){
    return Center(child: Text('Địa danh lưu trú'));
  }
}

class Vung extends StatefulWidget{
  @override
  State<Vung> createState()=>_VungState();
}
class _VungState extends State<Vung>{
  @override
  Widget build(BuildContext context){
    return Center(child: Text('Vùng'));
  }
}

class TaiKhoan extends StatefulWidget{
  @override
  State<TaiKhoan> createState()=>_TaiKhoanState();
}
class _TaiKhoanState extends State<TaiKhoan>{
  @override
  Widget build(BuildContext context){
    return Center(child: Text('Tài khoản'));
  }
}