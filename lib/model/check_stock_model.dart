class CheckStockModel {
  String? codeProduct;
  int? stock;
  String? area;
  int? countCheck;

  CheckStockModel({
    this.codeProduct,
    this.stock,
    this.area,
    this.countCheck,
  });

  @override
  String toString() {
    return 'CheckStockModel{codeProduct: $codeProduct, stock: $stock, area: $area, countCheck: $countCheck}';
  }
}
