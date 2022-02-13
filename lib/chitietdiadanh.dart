import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:vietnamtourism/danhsachbaiviet.dart';

import 'api.dart';

class ChiTietDiaDanh extends StatefulWidget {
  ChiTietDiaDanh({Key? key, required this.diaDanhId, required this.userId})
      : super(key: key);
  final String diaDanhId;
  final String userId;
  @override
  State<ChiTietDiaDanh> createState() => _ChiTietDiaDanhState();
}

class _ChiTietDiaDanhState extends State<ChiTietDiaDanh> {
  Iterable diaDanh = [];
  Iterable baiViet = [];
  Iterable diaDanhLuuTru = [];
  bool isUpdate = true;
  Future<void> _openGoogleMap(double x, double y) async {
    final availableMaps = await MapLauncher.installedMaps;
    await availableMaps.first.showMarker(
      coords: Coords(x, y),
      title: "Ocean Beach",
    );
  }

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

  Future<String> layDSDiaDanhLuuTru() async {
    String diaDanhid = widget.diaDanhId;
    String url =
        "http://10.0.2.2/vietnamtourism/api/lay_ds_dia_danh_luu_tru.php?id=$diaDanhid";
    var res = await http.get(Uri.parse(url));
    var resBody = json.decode(res.body);
    setState(() {
      diaDanhLuuTru = resBody;
      print(diaDanhLuuTru);
    });

    return "Sucess";
  }

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
    this.layDSDiaDanhLuuTru();
  }

  @override
  Widget build(BuildContext context) {
    if (isUpdate == true) {
      String id = widget.diaDanhId;
      API(url: "http://10.0.2.2/vietnamtourism/api/lay_dia_danh.php?id=$id")
          .getDataString()
          .then((value) {
        diaDanh = json.decode(value);
        isUpdate = false;
        setState(() {});
      });
    }
    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(
            children: [
              Image.asset(
                'assets/images/newyork.jpg',
                height: 280,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
              Container(
                height: 280,
                color: Colors.black12,
                padding: EdgeInsets.only(top: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        left: 24,
                        right: 24,
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ),
                          Spacer(),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.share,
                                    color: Colors.white,
                                    size: 24,
                                  )),
                              baiViet.length.toString() != "0"
                                  ? GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    BaiVietDiaDanh(
                                                      diaDanhId:
                                                          widget.diaDanhId,
                                                      userId: widget.userId,
                                                    )));
                                      },
                                      child: Text(
                                        "( " +
                                            baiViet.length.toString() +
                                            " chia sẻ )",
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.white),
                                      ),
                                    )
                                  : Text("")
                            ],
                          )
                        ],
                      ),
                    ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.only(
                        left: 24,
                        right: 24,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            diaDanh.elementAt(0)["ten_dia_danh"].toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 23),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Row(
                            mainAxisAlignment : MainAxisAlignment.spaceBetween,
                            children: [
                            _buildRatingStars(double.parse(
                              diaDanh.elementAt(0)['sao_danh_gia'].toString())),
                            Container(
                                  padding: EdgeInsets.all(5.0),
                                  width: 100.0,
                                  decoration: BoxDecoration(
                                    color: Colors.lightBlue,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    diaDanh.elementAt(0)["ten_loai_dia_danh"].toString(),
                                    style: TextStyle(fontSize: 15,color: Colors.white),
                                  ),
                                ),
                          ],),
                          SizedBox(
                            height: 12,
                          ),
                          Container(
                            child: Text(
                                diaDanh.elementAt(0)["mo_ta"].toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15)),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
              itemCount: diaDanhLuuTru.length,
              itemBuilder: (BuildContext context, int index) {
                return Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                      height: 170.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(130.0, 20.0, 20.0, 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: 120.0,
                                  child: Text(
                                    diaDanhLuuTru
                                        .elementAt(index)["ten"]
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                                // Column(
                                //   children: <Widget>[
                                //     Text(
                                //       '100000',
                                //       style: TextStyle(
                                //         fontSize: 22.0,
                                //         fontWeight: FontWeight.w600,
                                //       ),
                                //     ),
                                //   ],
                                // ),
                                IconButton(
                                    onPressed: () => _openGoogleMap(
                                        double.parse(diaDanhLuuTru
                                            .elementAt(index)['kinh_do']
                                            .toString()),
                                        double.parse(diaDanhLuuTru
                                            .elementAt(index)['vi_do']
                                            .toString())),
                                    icon: Icon(Icons.map_outlined)),
                              ],
                            ),
                            Text(
                              "Số điện thoại: " +
                                  diaDanhLuuTru
                                      .elementAt(index)["sdt"]
                                      .toString(),
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                            ),
                            _buildRatingStars(double.parse(diaDanhLuuTru
                                .elementAt(index)["sao_danh_gia"]
                                .toString())),
                            SizedBox(height: 10.0),
                            Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(5.0),
                                  width: 70.0,
                                  decoration: BoxDecoration(
                                    color: Colors.lightBlue,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    '1h',
                                  ),
                                ),
                                SizedBox(width: 10.0),
                                Container(
                                  padding: EdgeInsets.all(5.0),
                                  width: 70.0,
                                  decoration: BoxDecoration(
                                    color: Colors.lightBlue,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    '2h',
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 20.0,
                      top: 15.0,
                      bottom: 15.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.asset(
                          'assets/images/hotel2.jpg',
                          width: 110,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
