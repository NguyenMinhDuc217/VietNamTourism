import 'dart:convert';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:vietnamtourism/chitietdiadanh.dart';

class TaiKhoan extends StatefulWidget {
  TaiKhoan({Key? key, required this.id, required this.userId})
      : super(key: key);
  final String id;
  final String userId;
  @override
  State<TaiKhoan> createState() => _TaiKhoanState();
}

class _TaiKhoanState extends State<TaiKhoan> {
  Iterable user = [];
  Iterable baiViet = [];
  Iterable ttUser = [];
  //Iterable tuongTac = [];

  Future<String> layInfoUser() async {
    String userid = widget.id;
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

  // Future<String> layTuongTacOfUser() async {
  //   String id1 = widget.id;
  //   String userid = widget.userId;
  //   String url =
  //       "http://10.0.2.2/vietnamtourism/api/lay_tuong_tac.php?id=$id1&user_id=$userid";
  //   var res = await http.get(Uri.parse(url));
  //   var resBody = json.decode(res.body);
  //   setState(() {
  //     tuongTac = resBody;
  //     print(tuongTac);
  //   });

  //   return "Sucess";
  // }

  Future<String> layBaiVietOfUser() async {
    String userid = widget.id;

    String url =
        "http://10.0.2.2/vietnamtourism/api/lay_ds_bai_viet.php?id=$userid";
    var res = await http.get(Uri.parse(url));
    var resBody = json.decode(res.body);
    setState(() {
      baiViet = resBody;
      print(baiViet);
    });

    return "Sucess";
  }

  Future<String> layTrangThaiOfUser() async {
    String userid = widget.id;
    String url =
        "http://10.0.2.2/vietnamtourism/api/lay_trang_thai.php?id=$userid";
    var res = await http.get(Uri.parse(url));
    var resBody = json.decode(res.body);
    setState(() {
      ttUser = resBody;
      print(ttUser);
    });

    return "Sucess";
  }

  @override
  void initState() {
    super.initState();
    this.layInfoUser();
    this.layBaiVietOfUser();
    this.layTrangThaiOfUser();
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildRatingStars(double rating) {
      return RatingBarIndicator(
        rating: rating,
        itemBuilder: (context, index) => Icon(
          Icons.star,
          color: Colors.amber,
        ),
        itemCount: 5,
        itemSize: 25.0,
      );
    }

    Widget _buildListTitle(IconData icon, String text) {
      return ListTile(
        leading: Icon(
          icon,
          color: Colors.black,
        ),
        title: Text(text),
      );
    }
    Widget _TrangThaiTrong() {
      if (ttUser.elementAt(0)["tt_ten"].toString() == "2" &&
          ttUser.elementAt(0)["tt_email"].toString() == "2" &&
          ttUser.elementAt(0)["tt_sdt"].toString() == "2") {
        return Text("Rieng tu");
      }
      return Row();
    }

    return Scaffold(
      appBar: AppBar(
        title:
            Text(user.elementAt(0)["ten_nguoi_dung"].toString().toUpperCase()),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(15),
              child: CircleAvatar(
                radius: 100,
                backgroundImage: AssetImage('assets/images/santorini.jpg'),
              ),
            ),
            Text(
              user.elementAt(0)["ten_nguoi_dung"].toString().toUpperCase(),
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Card(
              margin: const EdgeInsets.all(20),
              child: Column(
                children: [
                  ListTile(
                    leading: Text(
                      "Giới thiệu",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    
                  ),
                  _TrangThaiTrong(),
                  ttUser.elementAt(0)["tt_ten"].toString() == "1"
                      ? _buildListTitle(Icons.account_circle,
                          user.elementAt(0)["ten_nguoi_dung"].toString())
                      : Row(),
                  ttUser.elementAt(0)["tt_email"].toString() == "1"
                      ? _buildListTitle(
                          Icons.email, user.elementAt(0)["email"].toString())
                      : Row(),
                  ttUser.elementAt(0)["tt_sdt"].toString() == "1"
                      ? _buildListTitle(
                          Icons.phone, user.elementAt(0)["sdt"].toString())
                      : Row(),
                ],
              ),
            ),
            Column(
              children: List.generate(baiViet.length, (index) {
                return Card(
                        margin: const EdgeInsets.all(20),
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                leading: CircleAvatar(
                                  radius: 25,
                                  backgroundImage:
                                      AssetImage('assets/images/santorini.jpg'),
                                ),
                                title: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      user
                                          .elementAt(0)["ten_nguoi_dung"]
                                          .toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Text(
                                      " đã chia sẽ về ",
                                    ),
                                    Flexible(
                                      child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ChiTietDiaDanh(
                                                            userId:
                                                                widget.userId,
                                                            diaDanhId: baiViet
                                                                .elementAt(index)[
                                                                    "dia_danh_id"]
                                                                .toString())));
                                          },
                                          child: Text(
                                            baiViet
                                                .elementAt(
                                                    index)["ten_dia_danh"]
                                                .toString(),
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          )),
                                    ),
                                  ],
                                ),
                                subtitle: Text(baiViet
                                    .elementAt(index)["thoi_gian"]
                                    .toString()),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                                child: _buildRatingStars(double.parse(baiViet
                                    .elementAt(index)['danh_gia']
                                    .toString())),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                                child: Text(
                                  baiViet
                                      .elementAt(index)["cam_nghi"]
                                      .toString(),
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                                child: Image.asset('assets/images/paris.jpg'),
                              ),
                              Divider(
                                color: Colors.black,
                              ),
                              Padding(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        IconButton(
                                            onPressed: () {},
                                            icon: baiViet
                                                            .elementAt(index)[
                                                                "trang_thai_like"]
                                                            .toString() ==
                                                        "1" &&
                                                    baiViet
                                                            .elementAt(index)[
                                                                "user_id"]
                                                            .toString() ==
                                                        widget.userId
                                                ? Icon(
                                                    Icons.thumb_up_alt_rounded,
                                                    color: Colors.blue,
                                                  )
                                                : Icon(Icons
                                                    .thumb_up_alt_rounded)),
                                        Text("(" +
                                            baiViet
                                                .elementAt(
                                                    index)["so_luong_like"]
                                                .toString() +
                                            ")")
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                            onPressed: () {},
                                            icon: baiViet
                                                            .elementAt(index)[
                                                                "trang_thai_like"]
                                                            .toString() ==
                                                        "2" &&
                                                    baiViet
                                                            .elementAt(index)[
                                                                "user_id"]
                                                            .toString() ==
                                                        widget.userId
                                                ? Icon(
                                                    Icons
                                                        .thumb_down_alt_rounded,
                                                    color: Colors.blue,
                                                  )
                                                : Icon(Icons
                                                    .thumb_down_alt_rounded)),
                                        Text("(" +
                                            baiViet
                                                .elementAt(
                                                    index)["so_luong_unlike"]
                                                .toString() +
                                            ")")
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(Icons.remove_red_eye_sharp),
                                        Text("(" +
                                            baiViet
                                                .elementAt(
                                                    index)["so_luong_view"]
                                                .toString() +
                                            ")")
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ));
              })
            )
          ],
        ),
      ),
    );
  }
}
