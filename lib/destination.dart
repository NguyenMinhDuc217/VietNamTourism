import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:vietnamtourism/chitietdiadanh.dart';
import 'package:http/http.dart' as http;
import 'api.dart';

class DiaDanh extends StatefulWidget {
  @override
  State<DiaDanh> createState() => _DiaDanhState();
}

class _DiaDanhState extends State<DiaDanh> {
  bool isUpdate = true;
  List dsLoaiDiaDanh = [];
  bool isFilter = false;
  Iterable dsDiaDanh = [];
  Iterable dsFind = [];
  bool isFind = false;
  var _mySelection;
  final _controller = TextEditingController();
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

  Future<String> layLoaiDiaDanh() async {
    String url = "http://10.0.2.2/vietnamtourism/api/lay_ds_loai_dia_danh.php";
    var res = await http.get(Uri.parse(url));
    var resBody = json.decode(res.body);
    setState(() {
      dsLoaiDiaDanh = resBody;
      print(dsLoaiDiaDanh);
      _mySelection = dsLoaiDiaDanh.elementAt(0)["id"].toString();
    });

    return "Sucess";
  }

  @override
  void initState() {
    super.initState();
    this.layLoaiDiaDanh();
  }

  Widget _buildFilter() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "Loại địa danh: ",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: DropdownButton(
                    alignment: AlignmentDirectional.bottomStart,
                    items: dsLoaiDiaDanh.map((item) {
                      return new DropdownMenuItem(
                        child: new Text(
                          item['ten'],
                          style: TextStyle(fontSize: 14.0),
                        ),
                        value: item['id'].toString(),
                      );
                    }).toList(),
                    elevation: 16,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 25,
                        color: Colors.lightBlue),
                    underline: Container(
                      height: 2,
                      color: Colors.lightBlue,
                    ),
                    onChanged: (newVal) {
                      setState(() {
                        _mySelection = newVal.toString();
                        print(_mySelection);
                        if (_mySelection == "0") {
                          if (isFind == false) {
                            setState(() {
                              isFind = false;
                            });
                          } else {
                            dsFind = dsDiaDanh.where((element) =>
                                element["ten_dia_danh"]
                                    .toString()
                                    .startsWith(_controller.text));
                          }
                        } else {
                          if (isFind == true) {
                            dsFind = dsFind.where((element) =>
                                element["loai_dia_danh_id"].toString() ==
                                _mySelection);
                          } else {
                            dsFind = dsDiaDanh.where((element) =>
                                element["loai_dia_danh_id"].toString() ==
                                _mySelection);
                            setState(() {
                              isFind = true;
                            });
                          }
                        }
                      });
                    },
                    value: _mySelection,
                    isDense: true,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDSDiaDanh(Iterable ds) {
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
        itemCount: ds.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChiTietDiaDanh(
                              diaDanhId: ds.elementAt(index)['id'].toString(),
                            )));
              },
              child: Stack(
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
                                  ds
                                      .elementAt(index)['ten_dia_danh']
                                      .toString(),
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
                            ds.elementAt(index)['mo_ta'].toString(),
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          _buildRatingStars(int.parse(
                              ds.elementAt(index)['sao_danh_gia'].toString())),
                          SizedBox(height: 10.0),
                          Row(
                            children: <Widget>[
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.thumb_up_alt_outlined)),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.thumb_down_alt_outlined)),
                              IconButton(
                                  onPressed: () => _openGoogleMap(
                                      double.parse(ds
                                          .elementAt(index)['kinh_do']
                                          .toString()),
                                      double.parse(ds
                                          .elementAt(index)['vi_do']
                                          .toString())),
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
              ));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //Load danh sach dia danh
    if (isUpdate == true) {
      API(url: "http://10.0.2.2/vietnamtourism/api/lay_ds_dia_danh.php")
          .getDataString()
          .then((value) {
        dsDiaDanh = json.decode(value);
        isUpdate = false;
        setState(() {});
      });
    }

    return Scaffold(
      body: Column(
        children: <Widget>[
          //Area Search
          ListTile(
            leading: IconButton(
                onPressed: () {
                  if (isFilter == true) {
                    setState(() {
                      isFilter = false;
                    });
                  } else {
                    setState(() {
                      isFilter = true;
                    });
                  }
                },
                icon: Icon(Icons.filter_alt)),
            title: TextField(
              controller: _controller,
              decoration: InputDecoration(hintText: "Tìm kiếm"),
            ),
            trailing: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        _mySelection = "0";
                        _controller.text = "";
                        isFind = false;
                      });
                    },
                    icon: Icon(Icons.cancel_outlined)),
                OutlinedButton(
                  onPressed: () {
                    if (isFilter == false) {
                      dsFind = dsDiaDanh.where((element) =>
                          element["ten_dia_danh"]
                              .toString()
                              .startsWith(_controller.text));
                    } else {
                      dsFind = dsDiaDanh
                          .where((element) => element["ten_dia_danh"]
                              .toString()
                              .startsWith(_controller.text))
                          .where((element) =>
                              element["loai_dia_danh_id"].toString() ==
                              _mySelection);
                    }

                    setState(() {
                      isFind = true;
                    });
                  },
                  child: Text("Search", style: TextStyle(color: Colors.white)),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue)),
                ),
              ],
            ),
          ),

          //Area Filter
          isFilter == false ? Text("") : _buildFilter(),

          //Area List DiaDanh
          isFind == true ? _buildDSDiaDanh(dsFind) : _buildDSDiaDanh(dsDiaDanh),
        ],
      ),
    );
  }
}
