import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';

import 'api.dart';

class ChiTietDiaDanh extends StatefulWidget {
  ChiTietDiaDanh({Key? key, required this.diaDanhId}) : super(key: key);
  final String diaDanhId;
  @override
  State<ChiTietDiaDanh> createState() => _ChiTietDiaDanhState();
}

class _ChiTietDiaDanhState extends State<ChiTietDiaDanh> {
  Iterable diaDanh = [];
  bool isUpdate = true;
  Future<void> _openGoogleMap(double x, double y) async {
    final availableMaps = await MapLauncher.installedMaps;
    await availableMaps.first.showMarker(
      coords: Coords(x, y),
      title: "Ocean Beach",
    );
  }

  Text _buildRatingStars(int rating) {
    String stars = '';
    for (int i = 0; i < rating; i++) {
      stars += '⭐ ';
    }
    stars.trim();
    return Text(stars);
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
              Image.network(
                'https://upload.wikimedia.org/wikipedia/commons/thumb/2/21/Flag_of_Vietnam.svg/1200px-Flag_of_Vietnam.svg.png',
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
                          Icon(
                            Icons.share,
                            color: Colors.white,
                            size: 24,
                          ),
                          SizedBox(
                            width: 24,
                          ),
                          Icon(
                            Icons.favorite,
                            color: Colors.white,
                            size: 24,
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                diaDanh.elementAt(0)["ten_dia_danh"].toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 23),
                              ),
                              _buildRatingStars(int.parse(diaDanh
                                  .elementAt(0)['sao_danh_gia']
                                  .toString())),
                            ],
                          ),
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
              itemCount: 3,
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
                                    'Thung lũng tình yêu',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      '100000',
                                      style: TextStyle(
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      'per pax',
                                      style: TextStyle(
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Text(
                              'abc',
                              style: TextStyle(
                                color: Colors.grey[700],
                              ),
                            ),
                            _buildRatingStars(3),
                            SizedBox(height: 10.0),
                            Row(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(5.0),
                                  width: 70.0,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).accentColor,
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
                                    color: Theme.of(context).accentColor,
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
                        child: Image.network(
                            'https://t-cf.bstatic.com/xdata/images/hotel/max1280x900/264037166.jpg?k=9a7b5015488129317b1d1bd9ad9eb862569b800d061d027c73e5f5281ac80432&o=&hp=1',
                            width: 110),
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
