import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class CombinedChartWidget extends StatelessWidget {
  final List<List<dynamic>> excelData; // Data from Excel

  const CombinedChartWidget({Key? key, required this.excelData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final seriesList = _createDataFromExcel(excelData);

    return charts.BarChart(
      seriesList,
      animate: true,
      barGroupingType: charts.BarGroupingType.stacked,
      behaviors: [
        charts.SeriesLegend(
          position: charts.BehaviorPosition.bottom,
          horizontalFirst: false,
          cellPadding: EdgeInsets.only(right: 4.0, bottom: 4.0),
        ),
      ],
    );
  }

  List<charts.Series<OrdinalSales, String>> _createDataFromExcel(List<List<dynamic>> rawData) {
    List<charts.Series<OrdinalSales, String>> series = [];
    List<String> years = rawData[0].skip(1).map((e) => e.toString()).toList();

    for (var i = 1; i < rawData.length; i++) {
      List<OrdinalSales> salesData = [];
      for (var j = 0; j < years.length; j++) {
        // Extract the integer value from the cell object
        int value = _getIntFromCell(rawData[i][j + 1]);
        salesData.add(OrdinalSales(years[j], value));
      }

      series.add(charts.Series<OrdinalSales, String>(
        id: rawData[i][0].toString(),
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: salesData,
        // ... other series properties ...
      ));
    }

    return series;
  }

  int _getIntFromCell(dynamic cell) {
    // Check the runtime type and extract the integer value accordingly
    if (cell is IntCellValue) {
      return cell.value;
    } else if (cell is double) {
      return cell.toInt();
    } else if (cell is String) {
      return int.tryParse(cell) ?? 0;
    } else {
      return 0; // or throw an exception if you expect every value to be an int
    }
  }
}
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
