// readexcel.dart
import 'package:flutter/services.dart' show rootBundle;
import 'package:excel/excel.dart';


class ExcelData5 {
  static Future<List<List<dynamic>>> loadExcelData() async {
    final data = await rootBundle.load("assets/dichvutongquan.xlsx");
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);

    var sheet = excel.tables.keys.first;
    var rows = excel.tables[sheet]!.rows;
    return rows.map((e) => e.map((cell) => cell?.value).toList()).toList();
  }
}
