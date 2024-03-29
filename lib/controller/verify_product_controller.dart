import 'package:flutter/material.dart';
import 'package:verify_product/constant/constant.dart';
import 'package:verify_product/model/check_stock_model.dart';
import 'package:verify_product/model/stock_product_model.dart';
import 'package:collection/collection.dart';

class VerifyProductController extends ChangeNotifier {
  late BuildContext context;

  VerifyProductController(this.context);

  final TextEditingController area = TextEditingController();
  final TextEditingController codeProduct = TextEditingController();
  final TextEditingController number = TextEditingController();
  List<StockProductModel> _stockProductModel = [];
  bool _checkAreaAndCodeProductInStock = false;
  List<CheckStockModel> _keepStockCheck = [];

  void getStockProduct() {
    stockProductModel =
        mockData.map((e) => StockProductModel.fromJson(e)).toList();
  }

  void checkAreaAndCodeProduct() {
    final check = stockProductModel.firstWhereOrNull((e) =>
        (e.area?.toLowerCase() == area.text.toLowerCase().trim() &&
            e.codeProduct?.toLowerCase() ==
                codeProduct.text.toLowerCase().trim()));
    if (check != null) {
      final countCheck = keepStockCheck
          .where((element) =>
              (element.area?.toLowerCase() == check.area?.toLowerCase() &&
                  element.codeProduct?.toLowerCase() ==
                      check.codeProduct?.toLowerCase()))
          .toList();
      if (countCheck.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('เคยบันทึกข้อมูลแล้ว'),
        ));
        if (countCheck.length >= 2) {
          bool equalStock = false;
          if (countCheck.length == 2) {
            equalStock = countCheck[0].stock == countCheck[1].stock;
            if (equalStock) {
              countCheck[0].stockConfirm = countCheck[0].stock;
            }
          } else {
            final resIndexZero = countCheck[0].stock == countCheck[1].stock ||
                countCheck[0].stock == countCheck[2].stock;
            if (!resIndexZero) {
              final resIndexTwo = countCheck[1].stock == countCheck[2].stock;
              if (!resIndexTwo) {
                countCheck[2].stockConfirm = countCheck[2].stock;
              } else {
                countCheck[1].stockConfirm = countCheck[1].stock;
              }
            } else {
              countCheck[0].stockConfirm = countCheck[0].stock;
            }
            equalStock = true;
          }

          if (equalStock) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('ตรวจนำสินค้าจบแล้ว'),
            ));
          } else {
            checkAreaAndCodeProductInStock = true;
          }
        } else {
          checkAreaAndCodeProductInStock = true;
        }
      } else {
        checkAreaAndCodeProductInStock = true;
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('พื้นที่หรือสินค้าข้อมูลไม่ตรงกับฐานข้อมูล'),
      ));
    }
  }

  void keepDataCheck() {
    CheckStockModel newData = CheckStockModel();
    newData.stock = int.parse(number.text);
    newData.area = area.text.trim();
    newData.codeProduct = codeProduct.text.trim();
    final findCountCheck = keepStockCheck.where((e) => (e.area?.toLowerCase() ==
            area.text.toLowerCase().trim() &&
        e.codeProduct?.toLowerCase() == codeProduct.text.toLowerCase().trim()));

    newData.countCheck = findCountCheck.isEmpty ? 1 : findCountCheck.length + 1;
    keepStockCheck.add(newData);
    keepStockCheck = keepStockCheck.sortedBy((e) => e.codeProduct.toString());
    checkAreaAndCodeProductInStock = false;
    area.clear();
    codeProduct.clear();
    number.clear();
    checkKeepStock(newData);
  }

  void checkKeepStock(newData) {
    final countCheck = keepStockCheck
        .where((element) =>
            (element.area?.toLowerCase() == newData.area?.toLowerCase() &&
                element.codeProduct?.toLowerCase() ==
                    newData.codeProduct?.toLowerCase()))
        .toList();
    if (countCheck.isNotEmpty) {
      if (countCheck.length >= 2) {
        bool equalStock = false;
        if (countCheck.length == 2) {
          equalStock = countCheck[0].stock == countCheck[1].stock;
          if (equalStock) {
            countCheck[0].stockConfirm = countCheck[0].stock;
          }
        } else {
          final resIndexZero = countCheck[0].stock == countCheck[1].stock ||
              countCheck[0].stock == countCheck[2].stock;
          if (!resIndexZero) {
            final resIndexTwo = countCheck[1].stock == countCheck[2].stock;
            if (!resIndexTwo) {
              countCheck[2].stockConfirm = countCheck[2].stock;
            } else {
              countCheck[1].stockConfirm = countCheck[1].stock;
            }
          } else {
            countCheck[0].stockConfirm = countCheck[0].stock;
          }
          equalStock = true;
        }

        if (equalStock) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('ตรวจนำสินค้าจบแล้ว'),
          ));
        }
      }
    }
  }

  List<StockProductModel> get stockProductModel => _stockProductModel;

  set stockProductModel(List<StockProductModel> value) {
    _stockProductModel = value;
    notifyListeners();
  }

  bool get checkAreaAndCodeProductInStock => _checkAreaAndCodeProductInStock;

  set checkAreaAndCodeProductInStock(bool value) {
    _checkAreaAndCodeProductInStock = value;
    notifyListeners();
  }

  List<CheckStockModel> get keepStockCheck => _keepStockCheck;

  set keepStockCheck(List<CheckStockModel> value) {
    _keepStockCheck = value;
    notifyListeners();
  }
}
