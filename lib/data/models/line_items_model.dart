class LineItemModel {
  LineItemModel({
    required this.productId,
    required this.quantity,
    required this.subtotal,
    required this.subtotalTax,
    required this.total,
    required this.totalTax,
  });
  late final int productId;
  late final int quantity;
  late final String subtotal;
  late final String subtotalTax;
  late final String total;
  late final String totalTax;

  LineItemModel.fromJson(Map<String, dynamic> json){
    productId = json['product_id']as int;
    quantity = json['quantity']as int;
    subtotal = json['subtotal']as String;
    subtotalTax = json['subtotal_tax']as String;
    total = json['total']as String;
    totalTax = json['total_tax']as String;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['product_id'] = productId;
    _data['quantity'] = quantity;
    _data['subtotal'] = subtotal;
    _data['subtotal_tax'] = subtotalTax;
    _data['total'] = total;
    _data['total_tax'] = totalTax;
    return _data;
  }
}
