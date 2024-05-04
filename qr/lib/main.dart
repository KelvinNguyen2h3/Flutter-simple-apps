import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:collection/collection.dart';
void main() => runApp(const MyApp());
class Product {
  final String maHang;
  final String tenHang;
  final double giaThanh;
  DateTime thoiGian;
  int soLuong;
  Product({
    required this.maHang,
    required this.tenHang,
    required this.giaThanh,
    required this.thoiGian,
    this.soLuong = 1,
  }); }
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'QR code',
    theme: ThemeData(primarySwatch: Colors.blue),
    home: const MyHomePage(),
    debugShowCheckedModeBanner: false,
  ); }
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState(); }
class _MyHomePageState extends State<MyHomePage> {
  final List<Product> danhSachSanPham = [];
  final List<Product> danhSachXuatHang = [];
  Future<void> _scanQR() async {
    try {
      final result = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Hủy',
        false,
        ScanMode.QR,
      );
      if (result != '-1') {
        _handleScanResult(result);
      }
    } catch (e) {}
  }
  void _handleScanResult(String maHang) {
    final existingProduct = danhSachSanPham.firstWhereOrNull(
          (product) => product.maHang == maHang,
    );
    if (existingProduct != null) {
      _showUpdateQuantityDialog(existingProduct);
    } else {
      _showAddProductDialog(maHang);
    }
  }
  Future<void> _showUpdateQuantityDialog(Product existingProduct) async {
    final soLuongController = TextEditingController();
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nhập số lượng'),
        content: Column(
          children: [
            Text('Tên hàng: ${existingProduct.tenHang}'),
            Text('Giá thành: ${existingProduct.giaThanh}'),
            TextField(
              controller: soLuongController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Số lượng'),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              final soLuong = int.tryParse(soLuongController.text) ?? 0;
              if (soLuong > 0) {
                setState(() {
                  existingProduct.soLuong += soLuong;
                  existingProduct.thoiGian = DateTime.now();
                });
                Navigator.popUntil(context, ModalRoute.withName('/'));
              } else {
                _showInvalidQuantityDialog();
              }
            },
            child: const Text('Xác nhận'),
          ),
        ],
      ),
    );
  }
  Future<void> _showAddProductDialog(String maHang) async {
    final tenHangController = TextEditingController();
    final giaThanhController = TextEditingController();
    final soLuongController = TextEditingController();
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nhập thông tin sản phẩm'),
        content: Column(
          children: [
            TextField(
              controller: tenHangController,
              decoration: const InputDecoration(labelText: 'Tên hàng'),
            ),
            TextField(
              controller: giaThanhController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Giá thành'),
            ),
            TextField(
              controller: soLuongController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Số lượng'),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              if (tenHangController.text.isNotEmpty &&
                  giaThanhController.text.isNotEmpty &&
                  soLuongController.text.isNotEmpty) {
                danhSachSanPham.add(
                  Product(
                    maHang: maHang,
                    tenHang: tenHangController.text,
                    giaThanh: double.parse(giaThanhController.text),
                    thoiGian: DateTime.now(),
                    soLuong: int.parse(soLuongController.text),
                  ),
                );
                Navigator.pop(context);
              }
            },
            child: const Text('Lưu'),
          ),
        ],
      ),
    );
  }
  void _showProductList() {
    if (danhSachSanPham.isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Danh sách sản phẩm trong kho'),
          content: Column(
            children: danhSachSanPham
                .map(
                  (product) => ListTile(
                title: Text(product.tenHang),
                subtitle: Text(
                    'Mã hàng: ${product.maHang}\nGiá thành: ${product.giaThanh} VNĐ\nSố lượng: ${product.soLuong}\nThời gian: ${product.thoiGian}',
                ),
              ),
            )
                .toList(),
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Đóng'),
            ),
          ],
        ),
      );
    } else {
      _showEmptyWarehouseDialog();
    }
  }
  void _showEmptyWarehouseDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Kho hàng trống'),
        content: const Text('Chưa có sản phẩm trong kho.'),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Đóng'),
          ),
        ],
      ),
    );
  }
  void _showExportMethodDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Chọn cách xuất hàng'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _scanQRToExport();
              },
              child: const Text('Xuất hàng bằng QR'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _showExportFromWarehouseDialog();
              },
              child: const Text('Xuất hàng từ kho'),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> _scanQRToExport() async {
    try {
      final result = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Hủy',
        false,
        ScanMode.QR,
      );
      if (result != '-1') {
        _showExportQuantityDialog(
          danhSachSanPham.firstWhereOrNull(
                (product) => product.maHang == result && product.soLuong > 0,
          ),
        );
      } else {
        _showProductNotFoundDialog();
      }
    } catch (e) {
      print('Lỗi khi quét mã QR: $e');
    }
  }
  void _showExportFromWarehouseDialog() {
    if (danhSachSanPham.isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Chọn sản phẩm để xuất từ kho'),
          content: Column(
            children: danhSachSanPham
                .where((product) => product.soLuong > 0)
                .map(
                  (product) => ListTile(
                title: Text(product.tenHang),
                subtitle: Text(
                    'Mã hàng: ${product.maHang}\nGiá thành: ${product.giaThanh}\nSố lượng:${product.soLuong}',
                ),
                onTap: () => _showExportQuantityDialog(product),
              ),
            )
                .toList(),
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Hủy'),
            ),
          ],
        ),
      );
    } else {
      _showEmptyWarehouseDialog();
    }
  }
  void _showExportQuantityDialog(Product? product) {
    if (product != null) {
      final soLuongController = TextEditingController();
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Chọn số lượng xuất'),
          content: TextField(
            controller: soLuongController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Số lượng'),
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Hủy'),
            ),
            ElevatedButton(
              onPressed: () {
                final soLuongXuat = int.tryParse(soLuongController.text) ?? 0;
                if (soLuongXuat > 0 && soLuongXuat <= product.soLuong) {
                  setState(() {
                    danhSachXuatHang.add(
                      Product(
                        maHang: product.maHang,
                        tenHang: product.tenHang,
                        giaThanh: product.giaThanh,
                        thoiGian: DateTime.now(),
                        soLuong: soLuongXuat,
                      ),
                    );
                    product.soLuong -= soLuongXuat;
                  });
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                } else {
                  _showInvalidQuantityDialog();
                }
              },
              child: const Text('Xác nhận'),
            ),
          ],
        ),
      );
    } else {
      _showProductNotFoundDialog();
    }
  }
  void _showProductNotFoundDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Không tìm thấy sản phẩm'),
        content: const Text('Vui lòng kiểm tra lại.'),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Đóng'),
          ),
        ],
      ),
    );
  }
  void _showInvalidQuantityDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Số lượng không hợp lệ'),
        content: const Text('Vui lòng chọn số lượng hợp lệ.'),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Đóng'),
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QUOC TRUNG & NGUYEN KHOA'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _scanQR,
              child: const Text('Nhập hàng'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _showProductList,
              child: const Text('Kiểm tra kho'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _showExportMethodDialog,
              child: const Text('Xuất hàng'),
            ),
          ],
        ),
      ),
    );
  }}