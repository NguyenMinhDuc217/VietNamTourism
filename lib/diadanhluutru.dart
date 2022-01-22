import 'package:flutter/material.dart';
class DiaDanhLuuTru extends StatefulWidget{
    @override
    State<DiaDanhLuuTru> createState()=>DiaDanhLucTruState();
  }
class DiaDanhLucTruState extends State<DiaDanhLuuTru>{
  Text _buildRatingStars(int rating) {
    String stars = '';
    for (int i = 0; i < rating; i++) {
      stars += '⭐ ';
    }
    stars.trim();
    return Text(stars);
  }
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              itemCount: 3,
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
                                    'King Hotel Dalat',
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
                              'Khách sạn hàng đầu tại thành phố Đà Lạt',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            _buildRatingStars(4),
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
                                    onPressed: (){},
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
                          'https://t-cf.bstatic.com/xdata/images/hotel/max1280x900/264037166.jpg?k=9a7b5015488129317b1d1bd9ad9eb862569b800d061d027c73e5f5281ac80432&o=&hp=1',
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