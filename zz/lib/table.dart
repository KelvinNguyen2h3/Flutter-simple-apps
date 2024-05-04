// table.dart

import 'package:flutter/material.dart';

class CombinedChartWidget1 extends StatelessWidget {
  final List<List<dynamic>> excelData;

  const CombinedChartWidget1({Key? key, required this.excelData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Định nghĩa kiểu viền để tái sử dụng
    final borderStyle = BorderSide(color: Colors.black, width: 1);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Table(
        // Đặt kiểu viền cho bảng
        border: TableBorder.all(color: Colors.black),
        columnWidths: const {
          // Định nghĩa chiều rộng cho các cột (optional)
          0: FixedColumnWidth(120.0),
          1: FixedColumnWidth(100.0),
          2: FixedColumnWidth(100.0),
          3: FixedColumnWidth(100.0),
          4: FixedColumnWidth(100.0),
          5: FixedColumnWidth(80.0),

        },
        children: [
          ..._createTableRows(excelData, borderStyle),
        ],
      ),
    );
  }

  // Tạo các hàng cho bảng, bao gồm cả tiêu đề
  List<TableRow> _createTableRows(List<List<dynamic>> data, BorderSide borderStyle) {
    return List<TableRow>.generate(data.length, (index) {
      // Đối với mỗi ô, chúng ta sẽ tạo một Container với viền và căn chỉnh
      return TableRow(
        children: List<Widget>.generate(data[index].length, (cellIndex) {
          return Container(
            padding: EdgeInsets.all(8), // Padding bên trong mỗi ô
            decoration: BoxDecoration(
              border: Border(
                // Tạo viền cho từng ô, trừ ô góc trên cùng bên phải
                bottom: borderStyle,
                right: cellIndex == data[index].length - 1 ? BorderSide.none : borderStyle,
              ),
            ),
            child: Text(
              data[index][cellIndex].toString(),
              style: TextStyle(
                fontWeight: index == 0 ? FontWeight.bold : FontWeight.normal, // Tiêu đề in đậm
              ),
              textAlign: TextAlign.center, // Căn giữa nội dung ô
            ),
          );
        }),
      );
    });
  }
}
