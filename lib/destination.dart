import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';

import 'api.dart';

class DiaDanh extends StatefulWidget {
  @override
  State<DiaDanh> createState() => _DiaDanhState();
}

class _DiaDanhState extends State<DiaDanh> {
  bool isUpdate=true;
  Iterable s=[];
  Future<void> _openGoogleMap(double x,double y) async {
    final availableMaps = await MapLauncher.installedMaps;
    await availableMaps.first.showMarker(
       //coords: Coords(37.759392, -122.5107336),
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
      API(url: "http://10.0.2.2/vietnamtourism/api/lay_ds_dia_danh.php")
          .getDataString()
          .then((value) {
        s = json.decode(value);
        //s=value;
        isUpdate = false;
        setState(() {});
      });
    }
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              itemCount: s.length,
              itemBuilder: (BuildContext context, int index) {
                return Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(40.0, 0, 20.0, 0),
                      height: 200.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(100.0, 20.0, 20.0, 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: 200.0,
                                  child: Text(
                                    s.elementAt(index)['ten_dia_danh'].toString(),
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    overflow: TextOverflow.fade,
                                    maxLines: 4,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              s.elementAt(index)['gia'].toString()+ " VNĐ",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            _buildRatingStars(int.parse(s.elementAt(index)['sao_danh_gia'].toString())),
                            SizedBox(height: 10.0),
                            Row(
                              children: <Widget>[
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.thumb_up_alt)),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.thumb_down_alt)),
                                IconButton(
                                    onPressed: ()=>_openGoogleMap(double.parse(s.elementAt(index)['kinh_do'].toString()), double.parse(s.elementAt(index)['vi_do'].toString())),
                                    icon: Icon(Icons.map_outlined)),
                                Flexible(
                                    child: IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.share))),
                              ],
                            ),
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
                          'https://upload.wikimedia.org/wikipedia/commons/thumb/2/21/Flag_of_Vietnam.svg/1200px-Flag_of_Vietnam.svg.png',
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
