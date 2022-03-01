import 'package:shared_preferences/shared_preferences.dart';

enum Operation {insert, replace, delete}
enum DataType {int,double,bool,string,listStr}

abstract class SP {

  SP._();
  static late SharedPreferences prefs;

  static init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static void delete(String key) {
    prefs.remove(key);
  }

  static dynamic getData({required DataType dataType, required String key}) {

    dynamic value;

    switch (dataType) {
      case DataType.int:
        value = prefs.getInt(key);
        break;
      case DataType.double:
        value = prefs.getDouble(key);
        break;
      case DataType.bool:
        value = prefs.getBool(key);
        break;
      case DataType.string:
        value = prefs.getString(key);
        break;
      case DataType.listStr:
        value = prefs.getStringList(key);
        break;
      default:
        break;
    }

    return value;

  }

  static storeData({required DataType dataType, required String key, required dynamic value}) {

    switch (dataType) {
      case DataType.int:
        prefs.setInt(key, value);
        break;
      case DataType.double:
        prefs.setDouble(key, value);
        break;
      case DataType.bool:
        prefs.setBool(key, value);
        break;
      case DataType.string:
        prefs.setString(key, value);
        break;
      case DataType.listStr:
        prefs.setStringList(key, value);
        break;
      default:
        break;
    }

  }


  static updateStringList({required String key, required String value}) {
    List<String>? stringList = prefs.getStringList(key);
    int index = stringList?.indexWhere((element) => element == value) ?? -1;
    if(index > -1) {
      stringList?[index] = value;
    }
    storeData(dataType: DataType.listStr, key: key, value: stringList);
  }

  static addStringList({required String key, required String value}) {
    List<String> stringList = prefs.getStringList(key) ?? [];
    stringList.add(value);
    storeData(dataType: DataType.listStr, key: key, value: stringList);
  }

  static deleteFromList({required String key, required String value}) {
    List<String>? stringList = prefs.getStringList(key);
    stringList?.removeWhere((element) => element == value);
    storeData(dataType: DataType.listStr, key: key, value: stringList);
  }


}