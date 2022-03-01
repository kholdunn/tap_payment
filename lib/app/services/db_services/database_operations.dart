

import 'dart:async';

import '../log.dart';
import 'shared_preferences.dart';


class DBO {


  deleteAllProducts() {
    SP.delete("productList");
  }

  updateProduct(String value) {
    SP.updateStringList(key: "productList", value: value);
  }

  addProduct(String value){
    SP.addStringList(key: "productList", value: value);
  }

  deleteProduct(String value) {
    SP.deleteFromList(key: "productList", value: value);
  }

  Future<List<String>> getProductList() async {

    Completer<List<String>> c = Completer();
    List<String> value = SP.getData(dataType: DataType.listStr, key: "productList") ?? [];

    c.complete(value);
    return c.future;
  }



  logout(){

    SP.delete("userInfo");

  }

}