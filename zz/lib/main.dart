import 'package:flutter/material.dart';
import 'column.dart';
import 'readexcel_nonglambieudo.dart';
import 'readexcel_nonglamquanly.dart';
import 'readexcel_chitieutongquan.dart';
import 'readexcel_congnghieptongquan.dart';
import 'readexcel_dancutongquan.dart';
import 'readexcel_dichvutongquan.dart';
import 'table.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
void main() {
  runApp(const MyApp());
}
class CanBo {
  String hoVaTen;
  String soDienThoai;
  String viTri;
  String linhVuc;

  CanBo({
    required this.hoVaTen,
    required this.soDienThoai,
    required this.viTri,
    required this.linhVuc,
  });
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  // Khai báo biến để theo dõi nút nào được chọn
  int _selectedButton = 0;
  int _selectedButtonBieuDoDuLieu = 0;
  int _selectedButtonQuanLyCanBoOption = 0;
  int _selectedButtonChiTieuChung = 0;
  int _selectedButtonNongLamThuySan = 0;
  int _selectedButtonCongNghiep = 0;
  int _selectedButtonDichVu = 0;
  int _selectedButtonDanCu = 0;

  List<CanBo> canBoList = [];
  String selectedLinhVuc = '';
  String selectedViTri = '';

  void _addCanBo(CanBo canBo) {
    setState(() {
      canBoList.add(canBo);
    });
  }

  void _deleteCanBo(int index) {
    setState(() {
      canBoList.removeAt(index);
    });
  }


  // Hàm này được gọi khi một TextButton được nhấn
  void _selectButton(int index) {
    setState(() {
      _selectedButton = index;
    });
  }
  void _selectButtonBieuDoDuLieu(int index) {
    setState(() {
      _selectedButtonBieuDoDuLieu = index;
    });
  }
  void _selectButtonChiTieuChung(int index) {
    setState(() {
      _selectedButtonChiTieuChung = index;
    });
  }
  void _selectButtonNongLamThuySan(int index) {
    setState(() {
      _selectedButtonNongLamThuySan = index;
    });
  }
  void _selectButtonCongNghiep(int index) {
    setState(() {
      _selectedButtonCongNghiep = index;
    });
  }
  void _selectButtonDichVu(int index) {
    setState(() {
      _selectedButtonDichVu = index;
    });
  }
  void _selectButtonDanCu(int index) {
    setState(() {
      _selectedButtonDanCu = index;
    });
  }
 //-----------------------------------------------------
 // Header và thanh Navbar
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/trongdong.jpg'), // Replace with your image path.
                fit: BoxFit
                    .cover, // This will fill the space of AppBar with the image.
              ),
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(
                left: 50.0), // Adjust the left padding if needed
            child: Row(
              children: [
                Image.network(
                  'https://thanhnien.mediacdn.vn/Uploaded/2014/Pictures20116/MinhNguyet/Thang8/26.8/QHuy1.jpg',
                  fit: BoxFit.cover,
                  height: 50, // You can adjust this height as needed
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Bảng dữ liệu KTXH X.Thuận Lợi',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(
                            255, 9, 6, 168) // Adjust the font size if needed
                    ),
                  ),
                ),
              ],
            ),
          ),
          toolbarHeight: 70, // Set the AppBar height to 200 pixels
        ),
        body: Container(
          color: const Color.fromARGB(30, 0, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width:
                double.infinity, // Set the width to fill the screen width
                height: 70,
                color: const Color.fromARGB(255, 38, 44, 142),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 40.0),
                      child: Text(
                        'KTXH X.Thuận Lợi',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0),
                      child: _buildTextButton(0, 'Tổng quan'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0),
                      child: _buildTextButton(1, 'Biểu đồ dữ liệu'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0),
                      child: _buildTextButton(2, 'Quản lý cán bộ'),
                    ),
                  ],
                ),
              ),
              _getContentForSelectedButton(context),
            ],
          ),
        ),
      ),
    );
  }

  // Hàm để xây dựng một TextButton với viền tùy chọn
  Widget _buildTextButton(int index, String text) {
    bool isSelected = _selectedButton == index;
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isSelected ? Colors.yellow : Colors.transparent,
            width: 3.0,
          ),
        ),
      ),
      child: TextButton(
        onPressed: () => _selectButton(index),
        style: TextButton.styleFrom(
          padding:
          const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
          foregroundColor:
          isSelected ? Colors.white : Colors.white70, // Màu chữ
          backgroundColor: isSelected
              ? const Color.fromARGB(255, 16, 20, 105)
              : Colors.transparent, // Màu nền
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            //color: isSelected ? Colors.white : Colors.white70, // Cập nhật màu chữ ở đây nếu cần
          ),
        ),
      ),
    );
  }

  Widget _tongQuanContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 70,
            width: 220, // Fixed width
            decoration: BoxDecoration(
              color: Color.fromARGB(40, 0, 0, 0),
              border: Border(
                left: BorderSide(
                  color: Colors.green,
                  width: 5.0,
                ),
              ),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text(
                  'X.Thuận Lợi',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          ListView( // Wrap the content inside ListView
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 200, top: 50.0),
                          child: const Text(
                            'Biểu đồ trạng thái',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 90, top: 20.0),
                          child: const Text(
                            'Biểu Đồ Tổng Quan Tỉnh Đồng Nai',
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 100.0),
                          child: SizedBox(
                            height: 400,
                            width: 400,
                            child: SfCircularChart(
                              series: <CircularSeries>[
                                DoughnutSeries<_ChartData, String>(
                                  dataSource: [
                                    _ChartData('A', 60, const Color(0xFF00B09C)),
                                    _ChartData('F', 0.09, Colors.white),
                                    _ChartData('B', 35, Colors.red),
                                  ],
                                  pointColorMapper: (_ChartData data, _) => data.color,
                                  xValueMapper: (_ChartData data, _) => data.x,
                                  yValueMapper: (_ChartData data, _) => data.y,
                                  startAngle: 270,
                                  endAngle: 90,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 250.0),
                          child: const Text('Đã hoàn thành 60%'),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 300),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Bảng Tiến Độ', style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(
                          height: 10,
                        ),
                        DataTable(
                          headingRowColor: MaterialStateProperty.all<Color>(Colors.grey.withOpacity(0.3)),
                          columns: const <DataColumn>[
                            DataColumn(
                              label: Text('KPI', style: TextStyle(fontStyle: FontStyle.normal)),
                            ),
                            DataColumn(
                              label: Text('Đạt được', style: TextStyle(fontStyle: FontStyle.normal)),
                            ),
                            DataColumn(
                              label: Text('Target%', style: TextStyle(fontStyle: FontStyle.normal)),
                            ),
                            DataColumn(
                              label: Text('Trend Line', style: TextStyle(fontStyle: FontStyle.normal)),
                            ),
                          ],
                          rows: const <DataRow>[
                            DataRow(
                              cells: <DataCell>[
                                DataCell(Text('Nông Nghiệp', style: TextStyle(color: Colors.blue))),
                                DataCell(Row(
                                  children: [
                                    Icon(
                                      Icons.arrow_drop_up,
                                      color: Colors.green,
                                    ),
                                    SizedBox(width: 5),
                                    Text('9,4567'),
                                  ],
                                )),
                                DataCell(Text('15%')),
                                DataCell(Icon(Icons.timeline, color: Colors.blue)),
                              ],
                            ),
                            DataRow(
                              cells: <DataCell>[
                                DataCell(Text('Du Lịch', style: TextStyle(color: Colors.blue))),
                                DataCell(
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.red,
                                      ),
                                      SizedBox(width: 5),
                                      Text('9,4567'),
                                    ],
                                  ),
                                ),
                                DataCell(Text('25%')),
                                DataCell(Icon(Icons.timeline, color: Colors.blue)),
                              ],
                            ),
                            DataRow(
                              cells: <DataCell>[
                                DataCell(Text('Công Nghiệp', style: TextStyle(color: Colors.blue))),
                                DataCell(Row(
                                  children: [
                                    Icon(
                                      Icons.circle,
                                      color: Colors.yellow,
                                    ),
                                    SizedBox(width: 5),
                                    Text('9,4567'),
                                  ],
                                )),
                                DataCell(Text('25%')),
                                DataCell(Icon(Icons.timeline, color: Colors.blue)),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }


  Widget _bieuDoDuLieuContent() {
    final screenWidth = MediaQuery.of(context).size.width;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 70,
          width: 220, // Chiều rộng cố định
          decoration: const BoxDecoration(
            color:
            Color.fromARGB(40, 0, 0, 0), // Màu sắc của Container
            border: Border(
              left: BorderSide(
                color: Colors.green, // Màu của viền
                width: 5.0, // Độ rộng của viền
              ),
            ),
            // Có thể thêm borderRadius hoặc các thuộc tính khác nếu muốn
          ),
          child: const Align(
            alignment: Alignment
                .centerLeft, // Căn giữa theo chiều dọc và căn trái theo chiều ngang
            child: Padding(
              padding: EdgeInsets.only(
                  left:
                  20.0), // Padding để đảm bảo khoảng cách từ viền trái
              child: Text(
                'X.Thuận Lợi',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  // Có thể thêm màu sắc và các thuộc tính khác cho text
                ),
              ),
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: screenWidth - 220,
              height: 60,
              color: Colors.white,
              child: Row(
                children: [
                  _buildTextButtonBieuDoDuLieu(0, "Chỉ Tiêu Chung"),
                  _buildTextButtonBieuDoDuLieu(1, "Nông Lâm Thủy Sản"),
                  _buildTextButtonBieuDoDuLieu(2, "Công Nghiệp"),
                  _buildTextButtonBieuDoDuLieu(3, "Dịch Vụ"),
                  _buildTextButtonBieuDoDuLieu(4, "Dân Cư"),
                ],
              ),
            ),
            _getContentForSelectedButtonBieuDoDuLieu(),
          ],
        )
      ],
    );

  }

  Widget _quanLyCanBoContent(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: screenHeight - 140, // Chiều cao bằng chiều dài còn lại của màn hình trừ đi 140
          width: 220, // Chiều rộng cố định
          color: Colors.white,
          child: Column(
            children: <Widget>[
              ExpansionTile(
                title: Text(
                  'Tài khoản quản lý',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                children: <Widget>[
                  Container(
                    color: _selectedButtonQuanLyCanBoOption == 0
                        ? Color.fromARGB(30, 0, 0, 0) // Màu khi được chọn
                        : Colors.white, // Màu nền của ListTile "Quản lý xã"
                    child: ListTile(
                      title: Text(
                        'Quản lý xã',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: _selectedButtonQuanLyCanBoOption == 0
                              ? Color.fromARGB(255, 9, 6, 168) // Màu khi được chọn
                              : Colors.black, // Màu chữ của "Quản lý xã"
                        ),
                      ),
                      onTap: () {
                        print('object1');
                        // Xử lý khi nhấn vào 'Quản lý xã'
                        setState(() {
                          _selectedButtonQuanLyCanBoOption = 0;
                        });
                      },
                    ),
                  ),
                ],
              ),
              ExpansionTile(
                title: Text(
                  'Tài khoản Cán bộ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                children: <Widget>[
                  Container(
                    color: _selectedButtonQuanLyCanBoOption == 1
                        ? Color.fromARGB(30, 0, 0, 0) // Màu khi được chọn
                        : Colors.white, // Màu nền của ListTile "Tất cả các lĩnh vực"
                    child: ListTile(
                      title: Text(
                        'Tất cả các lĩnh vực',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: _selectedButtonQuanLyCanBoOption == 1
                              ? Color.fromARGB(255, 9, 6, 168) // Màu khi được chọn
                              : Colors.black, // Màu chữ của "Tất cả các lĩnh vực"
                        ),
                      ),
                      onTap: () {
                        print('object2');
                        // Xử lý khi nhấn vào 'Tất cả các lĩnh vực'
                        setState(() {
                          _selectedButtonQuanLyCanBoOption = 1;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: _getContentForSelectedButtonQuanLyCanBoOption(context),
        ),
      ],
    );
  }



  Widget _TatCaLinhVucContent() { // Thêm BuildContext context vào đây
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 570.0, top: 30),
          child: Text(
            'Quản lí cán bộ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 1100),
          child: TextButton(
            onPressed: () {
              // Xử lý
            },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              backgroundColor: Colors.green,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
            ),
            child: const Text(
              '+ Thêm cán bộ',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }


  Widget _getContentForSelectedButtonQuanLyCanBoOption(BuildContext context) {
    switch (_selectedButtonQuanLyCanBoOption) {
      case 0: // Nội dung cho "Quản lý xã"
        return _TatCaLinhVucContent(); // Truyền context vào hàm _TatCaLinhVucContent
      case 1: // Nội dung cho "Tất cả các lĩnh vực"
        return Text('data2');
      default:
        return const Center(
          child: Text("Chọn một mục để hiển thị nội dung"),
        );
    }
  }



  Widget _getContentForSelectedButton(BuildContext context) {
    switch (_selectedButton) {
      case 0: // Nội dung cho "Tổng quan"
        return _tongQuanContent();
      case 1: // Nội dung cho "Biểu đồ dữ liệu"
        return _bieuDoDuLieuContent();
      case 2: // Nội dung cho "Quản lý cán bộ"
        return _quanLyCanBoContent(context);
      default:
        return const Center(
          child: Text("Chọn một mục để hiển thị nội dung"),
        );
    }
  }


  Widget _buildTextButtonBieuDoDuLieu(int index, String text) {
    bool isSelected = _selectedButtonBieuDoDuLieu == index;
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isSelected ? Colors.orange : Colors.white,
            width: 3.0,
          ),
        ),
      ),
      child: TextButton(
        onPressed: () => _selectButtonBieuDoDuLieu(index),
        style: TextButton.styleFrom(
          padding:
          const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
          foregroundColor: isSelected
              ? Colors.blueAccent
              : Color.fromARGB(175, 0, 0, 0), // Màu chữ
          backgroundColor: isSelected
              ? const Color.fromARGB(30, 0, 0, 0)
              : Colors.white, // Màu nền
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            //color: isSelected ? Colors.white : Colors.white70, // Cập nhật màu chữ ở đây nếu cần
          ),
        ),
      ),
    );
  }

  Widget _ChiTieuChungContent() {
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: screenWidth - 220,
            height: 60,
            color: Colors.white,
            child: Row(
              children: [
                _buildTextButtonChiTieuChung(0, "Biểu đồ tổng quan"),
                _buildTextButtonChiTieuChung(1, "Biểu đồ chi tiết"),
                _buildTextButtonChiTieuChung(2, "Quản lý dữ liệu"),
              ],
            ),
          ),
          _getContentForSelectedButtonChiTieuChung(),
        ],
      ),
    );
  }

  Widget _buildTextButtonChiTieuChung(int index, String text) {
    bool isSelected = _selectedButtonChiTieuChung == index;
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isSelected ? Colors.orange : Colors.white,
            width: 3.0,
          ),
        ),
      ),
      child: TextButton(
        onPressed: () => _selectButtonChiTieuChung(index),
        style: TextButton.styleFrom(
          padding:
          const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
          foregroundColor: isSelected
              ? Colors.blueAccent
              : Color.fromARGB(175, 0, 0, 0), // Màu chữ
          backgroundColor: isSelected
              ? const Color.fromARGB(30, 0, 0, 0)
              : Colors.white, // Màu nền
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            //color: isSelected ? Colors.white : Colors.white70, // Cập nhật màu chữ ở đây nếu cần
          ),
        ),
      ),
    );
  }

  Widget _NongLamThuySanContent() {
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: screenWidth - 220,
            height: 60,
            color: Colors.white,
            child: Row(
              children: [
                _buildTextButtonNongLamThuySan(0, "Biểu đồ tổng quan"),
                _buildTextButtonNongLamThuySan(1, "Biểu đồ chi tiết"),
                _buildTextButtonNongLamThuySan(2, "Quản lý dữ liệu"),
              ],
            ),
          ),
          _getContentForSelectedButtonNongLamThuySan(),
        ],
      ),
    );
  }

  Widget _buildTextButtonNongLamThuySan(int index, String text) {
    bool isSelected = _selectedButtonNongLamThuySan == index;
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isSelected ? Colors.orange : Colors.white,
            width: 3.0,
          ),
        ),
      ),
      child: TextButton(
        onPressed: () => _selectButtonNongLamThuySan(index),
        style: TextButton.styleFrom(
          padding:
          const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
          foregroundColor: isSelected
              ? Colors.blueAccent
              : Color.fromARGB(175, 0, 0, 0), // Màu chữ
          backgroundColor: isSelected
              ? const Color.fromARGB(30, 0, 0, 0)
              : Colors.white, // Màu nền
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            //color: isSelected ? Colors.white : Colors.white70, // Cập nhật màu chữ ở đây nếu cần
          ),
        ),
      ),
    );
  }

  Widget _CongNghiepContent() {
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: screenWidth - 220,
            height: 60,
            color: Colors.white,
            child: Row(
              children: [
                _buildTextButtonCongNghiep(0, "Biểu đồ tổng quan"),
                _buildTextButtonCongNghiep(1, "Biểu đồ chi tiết"),
                _buildTextButtonCongNghiep(2, "Quản lý dữ liệu"),
              ],
            ),
          ),
          _getContentForSelectedButtonCongNghiep(),
        ],
      ),
    );
  }

  Widget _buildTextButtonCongNghiep(int index, String text) {
    bool isSelected = _selectedButtonCongNghiep== index;
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isSelected ? Colors.orange : Colors.white,
            width: 3.0,
          ),
        ),
      ),
      child: TextButton(
        onPressed: () => _selectButtonCongNghiep(index),
        style: TextButton.styleFrom(
          padding:
          const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
          foregroundColor: isSelected
              ? Colors.blueAccent
              : Color.fromARGB(175, 0, 0, 0), // Màu chữ
          backgroundColor: isSelected
              ? const Color.fromARGB(30, 0, 0, 0)
              : Colors.white, // Màu nền
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            //color: isSelected ? Colors.white : Colors.white70, // Cập nhật màu chữ ở đây nếu cần
          ),
        ),
      ),
    );
  }

  Widget _DichVuContent() {
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: screenWidth - 220,
            height: 60,
            color: Colors.white,
            child: Row(
              children: [
                _buildTextButtonDichVu(0, "Biểu đồ tổng quan"),
                _buildTextButtonDichVu(1, "Biểu đồ chi tiết"),
                _buildTextButtonDichVu(2, "Quản lý dữ liệu"),
              ],
            ),
          ),
          _getContentForSelectedButtonDichVu(),
        ],
      ),
    );
  }

  Widget _buildTextButtonDichVu(int index, String text) {
    bool isSelected = _selectedButtonDichVu == index;
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isSelected ? Colors.orange : Colors.white,
            width: 3.0,
          ),
        ),
      ),
      child: TextButton(
        onPressed: () => _selectButtonDichVu(index),
        style: TextButton.styleFrom(
          padding:
          const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
          foregroundColor: isSelected
              ? Colors.blueAccent
              : Color.fromARGB(175, 0, 0, 0), // Màu chữ
          backgroundColor: isSelected
              ? const Color.fromARGB(30, 0, 0, 0)
              : Colors.white, // Màu nền
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            //color: isSelected ? Colors.white : Colors.white70, // Cập nhật màu chữ ở đây nếu cần
          ),
        ),
      ),
    );
  }

  Widget _DanCuContent() {
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: screenWidth - 220,
            height: 60,
            color: Colors.white,
            child: Row(
              children: [
                _buildTextButtonDanCu(0, "Biểu đồ tổng quan"),
                _buildTextButtonDanCu(1, "Biểu đồ chi tiết"),
                _buildTextButtonDanCu(2, "Quản lý dữ liệu"),
              ],
            ),
          ),
          _getContentForSelectedButtonDanCu(),
        ],
      ),
    );
  }

  Widget _buildTextButtonDanCu(int index, String text) {
    bool isSelected = _selectedButtonDanCu == index;
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isSelected ? Colors.orange : Colors.white,
            width: 3.0,
          ),
        ),
      ),
      child: TextButton(
        onPressed: () => _selectButtonDanCu(index),
        style: TextButton.styleFrom(
          padding:
          const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
          foregroundColor: isSelected
              ? Colors.blueAccent
              : Color.fromARGB(175, 0, 0, 0), // Màu chữ
          backgroundColor: isSelected
              ? const Color.fromARGB(30, 0, 0, 0)
              : Colors.white, // Màu nền
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            //color: isSelected ? Colors.white : Colors.white70, // Cập nhật màu chữ ở đây nếu cần
          ),
        ),
      ),
    );
  }

  Widget _getContentForSelectedButtonBieuDoDuLieu() {
    switch (_selectedButtonBieuDoDuLieu) {
      case 0:
        return _ChiTieuChungContent();
      case 1:
        return _NongLamThuySanContent();
      case 2:
        return _CongNghiepContent();
      case 3:
        return _DichVuContent();
      case 4:
        return _DanCuContent();
      default:
        return const Center(
          child: Text("Chọn một mục để hiển thị nội dung"),
        );
    }
  }

  Widget _getContentForSelectedButtonChiTieuChung() {
    switch (_selectedButtonChiTieuChung) {
      case 0:
        return Center(
          child: FutureBuilder<List<List<dynamic>>>(
            future: ExcelData2.loadExcelData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("Lỗi khi tải dữ liệu");
              } else if (snapshot.hasData) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      // Widget Text cho tiêu đề biểu đồ
                      child: Text(
                        'Biểu đồ tổng sản phẩm trên địa bàn (GRDP) X.Thuận Lợi qua các năm',
                        style: Theme.of(context).textTheme.headline6, // Phong cách cho tiêu đề có thể tùy chỉnh
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(1),
                      alignment: Alignment.centerLeft,
                      height: MediaQuery.of(context).size.height * 0.55,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: CombinedChartWidget(excelData: snapshot.data!),
                    ),
                  ],
                );
              } else {
                return Text("Không tìm thấy dữ liệu");
              }
            },
          ),
        );
      case 1:
        return Center(
          child: FutureBuilder<List<List<dynamic>>>(
            future: ExcelData2.loadExcelData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("Lỗi khi tải dữ liệu");
              } else if (snapshot.hasData) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      // Widget Text cho tiêu đề biểu đồ
                      child: Text(
                        'Biểu đồ tổng sản phẩm trên địa bàn (GRDP) X.Thuận Lợi qua các năm',
                        style: Theme.of(context).textTheme.headline6, // Phong cách cho tiêu đề có thể tùy chỉnh
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(1),
                      alignment: Alignment.centerLeft,
                      height: MediaQuery.of(context).size.height * 0.55,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: CombinedChartWidget(excelData: snapshot.data!),
                    ),
                  ],
                );
              } else {
                return Text("Không tìm thấy dữ liệu");
              }
            },
          ),
        );
      case 2:
        return Text('Quản lý dữ liệu - chỉ tiêu chung');
      default:
        return const Center(
          child: Text("Chọn một mục để hiển thị nội dung"),
        );
    }
  }


  Widget _getContentForSelectedButtonNongLamThuySan() {
    switch (_selectedButtonNongLamThuySan) {
      case 0:
        return Center(
          child: FutureBuilder<List<List<dynamic>>>(
            future: ExcelData.loadExcelData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("Lỗi khi tải dữ liệu");
              } else if (snapshot.hasData) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      // Widget Text cho tiêu đề biểu đồ
                      child: Text(
                        'Biểu đồ tổng sản phẩm trên địa bàn (GRDP) X.Thuận Lợi qua các năm',
                        style: Theme.of(context).textTheme.headline6, // Phong cách cho tiêu đề có thể tùy chỉnh
                      ),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(1),
                            alignment: Alignment.centerLeft,
                            height: MediaQuery.of(context).size.height * 0.55,
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: CombinedChartWidget(excelData: snapshot.data!),
                          ),
                          Container(
                            padding: EdgeInsets.all(0.5),
                            alignment: Alignment.centerRight,
                            height: MediaQuery.of(context).size.height * 0.55,
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: CombinedChartWidget1(excelData: snapshot.data!),
                          ),
                        ]
                    ),
                  ],

                );
              } else {
                return Text("Không tìm thấy dữ liệu");
              }
            },
          ),
        );
      case 1:
        return Center(
          child: FutureBuilder<List<List<dynamic>>>(
            future: ExcelData.loadExcelData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("Lỗi khi tải dữ liệu");
              } else if (snapshot.hasData) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      // Widget Text cho tiêu đề biểu đồ
                      child: Text(
                        'Biểu đồ tổng sản phẩm trên địa bàn (GRDP) X.Thuận Lợi qua các năm',
                        style: Theme.of(context).textTheme.headline6, // Phong cách cho tiêu đề có thể tùy chỉnh
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(1),
                      alignment: Alignment.centerLeft,
                      height: MediaQuery.of(context).size.height * 0.55,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: CombinedChartWidget(excelData: snapshot.data!),
                    ),
                  ],
                );
              } else {
                return Text("Không tìm thấy dữ liệu");
              }
            },
          ),
        );
      case 2:
        return Center(
          child: FutureBuilder<List<List<dynamic>>>(
            future: ExcelData1.loadExcelData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("Lỗi khi tải dữ liệu");
              } else if (snapshot.hasData) {
                return SingleChildScrollView(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(0.5),
                        alignment: Alignment.centerLeft,
                        height: MediaQuery.of(context).size.height * 0.55,
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: CombinedChartWidget1(excelData: snapshot.data!),
                      ),
                    ],
                  ),
                );
              } else {
                return Text("Không tìm thấy dữ liệu");
              }
            },
          ),
        );
      default:
        return const Center(
          child: Text("Chọn một mục để hiển thị nội dung"),
        );
    }
  }

  Widget _getContentForSelectedButtonCongNghiep() {
    switch (_selectedButtonCongNghiep) {
      case 0:
        return Center(
          child: FutureBuilder<List<List<dynamic>>>(
            future: ExcelData3.loadExcelData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("Lỗi khi tải dữ liệu");
              } else if (snapshot.hasData) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      // Widget Text cho tiêu đề biểu đồ
                      child: Text(
                        'Biểu đồ tổng sản phẩm trên địa bàn (GRDP) X.Thuận Lợi qua các năm',
                        style: Theme.of(context).textTheme.headline6, // Phong cách cho tiêu đề có thể tùy chỉnh
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(1),
                      alignment: Alignment.centerLeft,
                      height: MediaQuery.of(context).size.height * 0.55,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: CombinedChartWidget(excelData: snapshot.data!),
                    ),
                  ],
                );
              } else {
                return Text("Không tìm thấy dữ liệu");
              }
            },
          ),
        );
      case 1:
        return Center(
          child: FutureBuilder<List<List<dynamic>>>(
            future: ExcelData3.loadExcelData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("Lỗi khi tải dữ liệu");
              } else if (snapshot.hasData) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      // Widget Text cho tiêu đề biểu đồ
                      child: Text(
                        'Biểu đồ tổng sản phẩm trên địa bàn (GRDP) X.Thuận Lợi qua các năm',
                        style: Theme.of(context).textTheme.headline6, // Phong cách cho tiêu đề có thể tùy chỉnh
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(1),
                      alignment: Alignment.centerLeft,
                      height: MediaQuery.of(context).size.height * 0.55,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: CombinedChartWidget(excelData: snapshot.data!),
                    ),
                  ],
                );
              } else {
                return Text("Không tìm thấy dữ liệu");
              }
            },
          ),
        );
      case 2:
        return Text('Quản lý dữ liệu - công nghiệp');
      default:
        return const Center(
          child: Text("Chọn một mục để hiển thị nội dung"),
        );
    }
  }

  Widget _getContentForSelectedButtonDichVu() {
    switch (_selectedButtonDichVu) {
      case 0:
        return Center(
          child: FutureBuilder<List<List<dynamic>>>(
            future: ExcelData5.loadExcelData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("Lỗi khi tải dữ liệu");
              } else if (snapshot.hasData) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      // Widget Text cho tiêu đề biểu đồ
                      child: Text(
                        'Biểu đồ thu nhập cá nhân Tỉnh Đồng Nai qua các năm',
                        style: Theme.of(context).textTheme.headline6, // Phong cách cho tiêu đề có thể tùy chỉnh
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(1),
                      alignment: Alignment.centerLeft,
                      height: MediaQuery.of(context).size.height * 0.55,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: CombinedChartWidget(excelData: snapshot.data!),
                    ),
                  ],
                );
              } else {
                return Text("Không tìm thấy dữ liệu");
              }
            },
          ),
        );
      case 1:
        return Center(
          child: FutureBuilder<List<List<dynamic>>>(
            future: ExcelData5.loadExcelData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("Lỗi khi tải dữ liệu");
              } else if (snapshot.hasData) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      // Widget Text cho tiêu đề biểu đồ
                      child: Text(
                        'Biểu đồ thu nhập cá nhân Tỉnh Đồng Nai qua các năm',
                        style: Theme.of(context).textTheme.headline6, // Phong cách cho tiêu đề có thể tùy chỉnh
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(1),
                      alignment: Alignment.centerLeft,
                      height: MediaQuery.of(context).size.height * 0.55,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: CombinedChartWidget(excelData: snapshot.data!),
                    ),
                  ],
                );
              } else {
                return Text("Không tìm thấy dữ liệu");
              }
            },
          ),
        );
      case 2:
        return Text('Quản lý dữ liệu - dịch vụ');
      default:
        return const Center(
          child: Text("Chọn một mục để hiển thị nội dung"),
        );
    }
  }

  Widget _getContentForSelectedButtonDanCu() {
    switch (_selectedButtonDanCu) {
      case 0:
        return Center(
          child: FutureBuilder<List<List<dynamic>>>(
            future: ExcelData4.loadExcelData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("Lỗi khi tải dữ liệu");
              } else if (snapshot.hasData) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      // Widget Text cho tiêu đề biểu đồ
                      child: Text(
                        'Biểu đồ thu nhập cá nhân Tỉnh Đồng Nai qua các năm',
                        style: Theme.of(context).textTheme.headline6, // Phong cách cho tiêu đề có thể tùy chỉnh
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(1),
                      alignment: Alignment.centerLeft,
                      height: MediaQuery.of(context).size.height * 0.55,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: CombinedChartWidget(excelData: snapshot.data!),
                    ),
                  ],
                );
              } else {
                return Text("Không tìm thấy dữ liệu");
              }
            },
          ),
        );
      case 1:
        return Center(
          child: FutureBuilder<List<List<dynamic>>>(
            future: ExcelData4.loadExcelData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("Lỗi khi tải dữ liệu");
              } else if (snapshot.hasData) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      // Widget Text cho tiêu đề biểu đồ
                      child: Text(
                        'Biểu đồ thu nhập cá nhân Tỉnh Đồng Nai qua các năm',
                        style: Theme.of(context).textTheme.headline6, // Phong cách cho tiêu đề có thể tùy chỉnh
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(1),
                      alignment: Alignment.centerLeft,
                      height: MediaQuery.of(context).size.height * 0.55,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: CombinedChartWidget(excelData: snapshot.data!),
                    ),
                  ],
                );
              } else {
                return Text("Không tìm thấy dữ liệu");
              }
            },
          ),
        );
      case 2:
        return Text('Quản lý dữ liệu - dân cư');
      default:
        return const Center(
          child: Text("Chọn một mục để hiển thị nội dung"),
        );
    }
  }

}
class _ChartData {
  _ChartData(this.x, this.y, [this.color]);
  final String x;
  final double y;
  final Color? color;
}