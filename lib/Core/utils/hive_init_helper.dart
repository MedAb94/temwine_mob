import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'package:temwin_front_app/Core/Error/register_adapter_error.dart';
import 'package:temwin_front_app/Domain/entities/bnf_entity.dart';
import 'package:temwin_front_app/Domain/entities/offline_entities/items_entity.dart';
import 'package:temwin_front_app/Domain/entities/offline_entities/sales_entity.dart';
import 'package:temwin_front_app/Domain/entities/pos_bnf_data_entity.dart';
import 'package:temwin_front_app/Domain/entities/pos_entity.dart';
import 'package:temwin_front_app/Domain/entities/product_entity.dart';
import 'package:temwin_front_app/Domain/entities/roles_entity.dart';
import 'package:temwin_front_app/Domain/entities/user_data_entity.dart';
import 'package:temwin_front_app/Domain/entities/user_entity.dart';
import 'package:temwin_front_app/Domain/entities/user_token_entity.dart';

initHive() async {
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  // await Hive.initFlutter(appDocumentDirectory.path);
  Hive.init(appDocumentDirectory.path);
}

initAdapters() {
  //Main models
  try {
    Hive.registerAdapter<UserTokenEntity>(UserTokenEntityAdapter());
    Hive.registerAdapter<UserEntity>(UserEntityAdapter());
    Hive.registerAdapter<UserDataEntity>(UserDataEntityAdapter());
    Hive.registerAdapter<PosEntity>(PosEntityAdapter());
    Hive.registerAdapter<RolesEntity>(RolesEntityAdapter());
    Hive.registerAdapter<ProductsEntity>(ProductsEntityAdapter());
    Hive.registerAdapter<PosBnfDataEntity>(PosBnfDataEntityAdapter());
    Hive.registerAdapter<BnfEntity>(BnfEntityAdapter());
    Hive.registerAdapter<ItemsEntity>(ItemsEntityAdapter());
    Hive.registerAdapter<SalesEntity>(SalesEntityAdapter());

    //
    //
  } catch (ex) {
    RegisterAdapterError(ex.toString());
  }
}

class HiveHelper {
  // initHive() async {
  //   final appDocumentDirectory =
  //       await path_provider.getApplicationDocumentsDirectory();
  //   // await Hive.initFlutter(appDocumentDirectory.path);
  //   Hive.init(appDocumentDirectory.path);
  // }

  // initAdapters() {
  //   //Main models
  //   try {
  //     Hive.registerAdapter<UserTokenEntity>(UserTokenEntityAdapter());
  //     Hive.registerAdapter<UserEntity>(UserEntityAdapter());
  //     Hive.registerAdapter<CompaniesEntity>(CompaniesEntityAdapter());
  //   } catch (ex) {
  //     RegisterAdapterError(ex.toString());
  //   }
  // }

  //Object function
  storeData<T>(
      {required T object, required String boxName, String id = ""}) async {
    final box = await Hive.openBox(boxName);
    // await box.clear();
    await box.delete(boxName + id.trim());
    await box.put(boxName + id.trim(), object);
  }

  Future<T?> getData<T>({required String boxName}) async {
    var box = await Hive.openBox(boxName);

    T? object = await box.get(boxName);
    return object;
  }

  Future<List<T>?> getListData<T>(
      {required String boxName, String id = ""}) async {
    var box = await Hive.openBox(boxName);

    final val = await box.get(boxName + id.trim());
    if (val != null) {
      List<T> list = [];
      for (T t in val) {
        list.add(t);
      }

      return list;
    }

    return null;
  }

  clearBox({required String boxName}) async {
    final box = await Hive.openBox(boxName);
    await box.clear();
  }

  clearAllBoxes() async {
    List<String> boxes = [
      "TOKEN",
      "USERDATA",
    ];

    for (var box in boxes) {
      try {
        await clearBox(boxName: box);
        //print("box $box deleted...");
      } catch (e) {
        //print("box $box counldn't be deleted...");
      }
    }
    //await Hive.deleteFromDisk();
  }
}
