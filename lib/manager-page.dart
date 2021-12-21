import 'package:flutter/material.dart';

class ManagerPage extends StatefulWidget {
  @override
  _ManagerPageState createState() => _ManagerPageState();
}

class _ManagerPageState extends State<ManagerPage> {
  int selectedIndex = 0;
  Widget _quanLy = QuanLy();
  Widget _thongKe = ThongKe();

  Widget getBody() {
    if (this.selectedIndex == 0) {
      return this._quanLy;
    } else  {
      return this._thongKe;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Viet Name Tourism'),
      ),
      body: this.getBody(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: this.selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.folder),
            title: Text('Quản lý'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_sharp),
            title: Text('Thóng kê'),
          ),
        ],
        onTap: (int index) {
          this.onTapHandler(index);
        },
      ),
    );
  }

  void onTapHandler(int index) {
    this.setState(() {
      this.selectedIndex = index;
    });
  }
}

class QuanLy extends StatefulWidget {
  @override
  State<QuanLy> createState() => _QuanLyState();
}

class _QuanLyState extends State<QuanLy> {
  Container _buildDSDiaDanh() {
    return Container(
        child: Expanded(
            child: ListView.builder(
                itemCount: 11,
                itemBuilder: (context, index) => ListTile(
                      leading: Image.network(
                        'https://upload.wikimedia.org/wikipedia/commons/thumb/2/21/Flag_of_Vietnam.svg/1200px-Flag_of_Vietnam.svg.png',
                        height: 50,
                        width: 50,
                      ),
                      title: Text('Địa danh $index'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () {}, icon: Icon(Icons.update,color: Colors.blue,)),
                          IconButton(
                              onPressed: () {}, icon: Icon(Icons.delete,
                              color: Colors.red)),
                        ],
                      ),
                    ))));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(20),
          child: TextField(
            decoration: new InputDecoration(
              icon: new Icon(Icons.search),
              labelText: "Tìm kiếm địa danh",
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                borderSide: const BorderSide(
                  color: Colors.grey,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                borderSide: BorderSide(color: Colors.blue),
              ),
            ),
          ),
        ),
        TextButton.icon(
            style: TextButton.styleFrom(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            onPressed: () => {},
            icon: Icon(
              Icons.add,color: Colors.green,size: 20,
            ),
            label: Text(
              'Thêm địa danh',style: TextStyle(color: Colors.green,fontSize: 20),
            ),
        ),
        _buildDSDiaDanh()
      ],
    );
  }
}

class ThongKe extends StatefulWidget {
  @override
  State<ThongKe> createState() => _ThongKeState();
}

class _ThongKeState extends State<ThongKe> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Thống kê'));
  }
}
