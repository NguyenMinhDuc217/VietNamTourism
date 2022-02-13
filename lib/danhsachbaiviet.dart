import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:vietnamtourism/chitietdiadanh.dart';
import 'package:vietnamtourism/trangcanhan.dart';

class BaiVietDiaDanh extends StatefulWidget {
  BaiVietDiaDanh({Key? key, required this.diaDanhId, required this.userId})
      : super(key: key);
  final String diaDanhId;
  final String userId;
  @override
  State<BaiVietDiaDanh> createState() => _BaiVietDiaDanhState();
}

class _BaiVietDiaDanhState extends State<BaiVietDiaDanh> {
  Iterable baiViet = [];
  Future<String> layBaiVietOfUser() async {
    String diaDanhid = widget.diaDanhId;
    String url =
        "http://10.0.2.2/vietnamtourism/api/lay_ds_bai_viet_theo_dia_danh.php?id=$diaDanhid";
    var res = await http.get(Uri.parse(url));
    var resBody = json.decode(res.body);
    setState(() {
      baiViet = resBody;
      print(baiViet);
    });

    return "Sucess";
  }

  @override
  void initState() {
    super.initState();
    this.layBaiVietOfUser();
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

    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: Text("Bài viết"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: List.generate(baiViet.length, (index) {
              return Card(
                  margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
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
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => TaiKhoan(
                                                id: baiViet
                                                    .elementAt(
                                                        index)["tai_khoan_id"]
                                                    .toString(),
                                                userId: widget.userId,
                                              )));
                                },
                                child: Text(
                                  baiViet
                                      .elementAt(index)["ten_nguoi_dung"]
                                      .toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
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
                                                      userId: widget.userId,
                                                      diaDanhId: baiViet
                                                          .elementAt(index)[
                                                              "dia_danh_id"]
                                                          .toString())));
                                    },
                                    child: Text(
                                      baiViet
                                          .elementAt(index)["ten_dia_danh"]
                                          .toString(),
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                              ),
                            ],
                          ),
                          subtitle: Text(
                              baiViet.elementAt(index)["thoi_gian"].toString()),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: _buildRatingStars(double.parse(
                              baiViet.elementAt(index)['danh_gia'].toString())),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child: Text(
                            baiViet.elementAt(index)["cam_nghi"].toString(),
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                          child:Image.asset('assets/images/paris.jpg'),
                        ),
                        Divider(
                          color: Colors.black,
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                      .elementAt(
                                                          index)["user_id"]
                                                      .toString() ==
                                                  widget.userId
                                          ? Icon(
                                              Icons.thumb_up_alt_rounded,
                                              color: Colors.blue,
                                            )
                                          : Icon(Icons.thumb_up_alt_rounded)),
                                  Text("(" +
                                      baiViet
                                          .elementAt(index)["so_luong_like"]
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
                                                      .elementAt(
                                                          index)["user_id"]
                                                      .toString() ==
                                                  widget.userId
                                          ? Icon(
                                              Icons.thumb_down_alt_rounded,
                                              color: Colors.blue,
                                            )
                                          : Icon(Icons.thumb_down_alt_rounded)),
                                  Text("(" +
                                      baiViet
                                          .elementAt(index)["so_luong_unlike"]
                                          .toString() +
                                      ")")
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.remove_red_eye_sharp),
                                  Text("(" +
                                      baiViet
                                          .elementAt(index)["so_luong_view"]
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
            }),
          ),
        ));
  }
}
