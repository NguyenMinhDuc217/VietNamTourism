import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class InfoPersonal extends StatefulWidget {
  InfoPersonal({required this.id});
  final String id;
  @override
  _InfoPersonalState createState() => _InfoPersonalState();
}

class _InfoPersonalState extends State<InfoPersonal> {
  Iterable user = [];
  
  Future<String> layInfoUser() async {
    String userid=widget.id;
    String url =
        "http://10.0.2.2/vietnamtourism/api/lay_thong_tin_tai_khoan.php?id=$userid";
    var res = await http.get(Uri.parse(url));
    var resBody = json.decode(res.body);
    setState(() {
      user = resBody;
      print(user);
    });

    return "Sucess";
  }

  @override
  void initState() {
    super.initState();
    this.layInfoUser();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Thông tin cá nhân"),
        centerTitle: true,
      ),
      body: Center(
          child: Column(
        children: [
          // ListTile(
          //   leading: CircleAvatar(
          //             radius: 30,
          //             backgroundImage: AssetImage('assets/images/santorini.jpg'),
          //             child: InkWell(
          //               borderRadius: BorderRadius.circular(30),
          //               onTap: () {},
          //             )),
          //   title: Text("PAHUHO"),
          //   subtitle: Text("Email: hoang@gmail.com"),
          // ),
          Padding(
            padding: EdgeInsets.all(15),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100.0),
              child: Image.asset(
                'assets/images/santorini.jpg',
                width: 200,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            user.elementAt(0)["ten_nguoi_dung"].toString().toUpperCase(),
            style: TextStyle(fontSize: 25),
          ),
          Container(
            decoration:
                BoxDecoration(border: Border.all(color: Colors.grey)),
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(5),
            child: Column(
              children: [
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Text(
                //       "Giới thiệu",
                //       style: TextStyle(
                //           fontWeight: FontWeight.bold, color: Colors.black),
                //     ),
                //     TextButton(onPressed: () {}, child: Text("Chỉnh sửa")),
                //   ],
                // ),
                ListTile(
                  leading: Text("Giới thiệu",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  trailing:TextButton(onPressed: (){}, child: Text("Chỉnh sửa",style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400))),
                ),
                ListTile(
                  leading: Icon(Icons.account_circle
                  ),
                  title: Text(user.elementAt(0)["ten_nguoi_dung"].toString()),
                ),
                ListTile(
                  leading: Icon(Icons.email
                  ),
                  title: Text(user.elementAt(0)["email"].toString()),
                ),
                ListTile(
                  leading: Icon(Icons.phone
                  ),
                  title: Text(user.elementAt(0)["sdt"].toString()),
                ),
                
              ],
            ),
          ),
        ],
      )),
    );
  }
}
