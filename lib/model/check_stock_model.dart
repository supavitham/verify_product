class CheckStockModel {
  String? codeProduct;
  int? stock;
  String? area;
  int? countCheck;
  int? stockConfirm;

  CheckStockModel({
    this.codeProduct,
    this.stock,
    this.area,
    this.countCheck,
    this.stockConfirm,
  });

  @override
  String toString() {
    return 'CheckStockModel{codeProduct: $codeProduct, stock: $stock, area: $area, countCheck: $countCheck, stockConfirm: $stockConfirm}';
  }
}
