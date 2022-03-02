class Products {
  String? productName;
  String? productDescription;
  double? price;
  String? id;
  String? timeStamp;

  Products({this.productName, this.productDescription, this.price, this.id, this.timeStamp});

  Products.fromJson(Map<String, dynamic> json) {
    productName = json['product_name'];
    productDescription = json['product_description'];
    price = json['price'];
    id = json['id'];
    timeStamp = json['timeStamp'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['product_name'] = productName;
    data['product_description'] = productDescription;
    data['price'] = price;
    data['id'] = id;
    data['timeStamp'] = timeStamp;
    return data;
  }
}
