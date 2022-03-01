class Products {
  String? productName;
  String? productDescription;
  double? price;
  String? id;

  Products({this.productName, this.productDescription, this.price, this.id});

  Products.fromJson(Map<String, dynamic> json) {
    productName = json['product_name'];
    productDescription = json['product_description'];
    price = json['price'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['product_name'] = productName;
    data['product_description'] = productDescription;
    data['price'] = price;
    data['id'] = id;
    return data;
  }
}
