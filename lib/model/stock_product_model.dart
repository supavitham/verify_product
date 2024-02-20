class StockProductModel {
  String? codeProduct;
  int? stock;
  String? area;

  StockProductModel({
    this.codeProduct,
    this.stock,
    this.area,
  });

  factory StockProductModel.fromJson(Map<String, dynamic> json) =>
      StockProductModel(
        codeProduct: json["code_product"],
        stock: json["stock"],
        area: json["area"],
      );

  Map<String, dynamic> toJson() => {
        "code_product": codeProduct,
        "stock": stock,
        "area": area,
      };

  @override
  String toString() {
    return 'StockProductModel{codeProduct: $codeProduct, stock: $stock, area: $area}';
  }
}
