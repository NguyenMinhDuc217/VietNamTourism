import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:vietnamtourism/chitietdiadanh.dart';
import 'package:vietnamtourism/chitietvung.dart';
import 'package:vietnamtourism/model/vung-model.dart';

import 'api.dart';

class Vung extends StatefulWidget {
  Vung({Key? key ,required this.userId}) : super(key: key);
  final String userId;
  @override
  State<Vung> createState() => _VungState();
}

class _VungState extends State<Vung> {
  List<VungModel> lsVung = [];

  Future<String> loadDSDiaDanhTheoVung() async {
    Iterable dsDiaDanh = [];
    Iterable dsVung = [];
    API(url: "http://10.0.2.2/vietnamtourism/api/lay_ds_vung.php?ver=0")
        .getDataString()
        .then((value) {
      dsVung = json.decode(value);
      for (int i = 0; i < dsVung.length; i++) {
        String id = dsVung.elementAt(i)["id"].toString();
        API(url: "http://10.0.2.2/vietnamtourism/api/lay_ds_dia_danh_theo_vung.php?id=$id")
            .getDataString()
            .then((value) {
          dsDiaDanh = json.decode(value);
          setState(() {
            VungModel vungTemp = VungModel(dsVung.elementAt(i)["id"].toString(),
                dsVung.elementAt(i)["ten_vung"].toString(), dsDiaDanh);
            lsVung.add(vungTemp);
          });
        });
      }

      setState(() {});
    });

    return "Succes";
  }

  @override
  void initState() {
    super.initState();
    this.loadDSDiaDanhTheoVung();
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
        itemSize: 20.0,
      );
    }

    // if (isUpdate == true) {
    //   Iterable dsVung=[];
    //   API(url: "http://10.0.2.2/vietnamtourism/api/lay_ds_vung.php?ver=0")
    //       .getDataString()
    //       .then((value) {
    //     dsVung = json.decode(value);
    //     for(int i=0;i<dsVung.length;i++){
    //         VungModel vungTemp=VungModel(dsVung.elementAt(i)["id"].toString(), dsVung.elementAt(i)["ten_vung"].toString(), layLoaiDiaDanh());
    //     }
    //     isUpdate = false;
    //     setState(() {});
    //   });
    // }
    return Scaffold(
      body: ListView.builder(
          itemCount: lsVung.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    lsVung[index].ten.toUpperCase(),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Container(
                      margin: EdgeInsets.symmetric(vertical: 20.0),
                      height: 300.0,
                      child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: List.generate(
                              lsVung[index].dsDiaDanh.length, (i) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ChiTietDiaDanh(
                                            diaDanhId: lsVung[index]
                                                .dsDiaDanh
                                                .elementAt(i)["id"]
                                                .toString(),
                                            userId: widget.userId)));
                              },
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: Image.asset(
                                        'assets/images/newyork.jpg',
                                        width: 200,
                                        height: 300,
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      left: 30.0,
                                      bottom: 30.0,
                                      child: Column(
                                        children: [
                                          Text(
                                              lsVung[index]
                                                  .dsDiaDanh
                                                  .elementAt(i)["ten_dia_danh"]
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white)),
                                          _buildRatingStars(double.parse(
                                              lsVung[index]
                                                  .dsDiaDanh
                                                  .elementAt(i)["sao_danh_gia"]
                                                  .toString()))
                                        ],
                                      )),
                                ],
                              ),
                            );
                          }))),
                ],
              ),
            );
          }),
    );
  }
}
//lsVung[index].dsDiaDanh.elementAt(i)["ten_dia_danh"].toString()
//Stack(
        //     children: <Widget>[
        //       Container(
        //         margin: EdgeInsets.fromLTRB(40.0, 0, 20.0, 0),
        //         height: 210.0,
        //         width: double.infinity,
        //         decoration: BoxDecoration(
        //           color: Colors.white,
        //           borderRadius: BorderRadius.circular(20.0),
        //         ),
        //         child: Padding(
        //           padding: EdgeInsets.fromLTRB(100.0, 20.0, 20.0, 20.0),
        //           child: Column(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: <Widget>[
        //               Row(
        //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: <Widget>[
        //                   Container(
        //                     width: 200.0,
        //                     child: Text(
        //                       dsVung.elementAt(index)["ten_vung"].toString(),
        //                       style: TextStyle(
        //                         fontSize: 20.0,
        //                         fontWeight: FontWeight.w600,
        //                       ),
        //                       overflow: TextOverflow.fade,
        //                       maxLines: 4,
        //                     ),
        //                   ),
        //                 ],
        //               ),                                                                                                 
        //             ],
        //           ),
        //         ),
        //       ),
        //       Positioned(
        //         left: 20.0,
        //         top: 15.0,
        //         bottom: 15.0,
        //         child: ClipRRect(
        //           borderRadius: BorderRadius.circular(20.0),
        //           child: Image.asset(
        //             'assets/images/hotel2.jpg',
        //             width: 110,
        //             fit: BoxFit.cover,
        //           ),
        //         ),
        //       ),
        //     ],
        //   );
        // },