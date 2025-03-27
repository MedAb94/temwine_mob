import 'package:temwin_front_app/Core/utils/hive_boxes.dart';
import 'package:temwin_front_app/Core/utils/hive_init_helper.dart';
import 'package:temwin_front_app/Domain/entities/product_entity.dart';

import 'package:temwin_front_app/Domain/entities/user_data_entity.dart';

abstract class UserLocalDataSource {
  Future<UserDataEntity?> getUser();

  Future<void> storeUser({required UserDataEntity userEntity});

  //{required Map<int, num> storedSalesItems})

  Future<UserDataEntity?> updateUserProductsUsedQuota(
      {required Map<int, num> storedSalesItems});

  Future<void> clearUser();
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final HiveHelper hiveHelper;

  const UserLocalDataSourceImpl({required this.hiveHelper});

  @override
  Future<void> clearUser() async {
    return await hiveHelper.clearBox(boxName: HiveBox.USER_DATA_BOX);
  }

  @override
  Future<UserDataEntity?> getUser() async {
    try {
      return await hiveHelper.getData<UserDataEntity>(
          boxName: HiveBox.USER_DATA_BOX);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> storeUser({required UserDataEntity userEntity}) async {
    return await hiveHelper.storeData<UserDataEntity>(
        object: userEntity, boxName: HiveBox.USER_DATA_BOX);
  }

  @override
  Future<UserDataEntity?> updateUserProductsUsedQuota(
      {required Map<int, num> storedSalesItems}) async {
    UserDataEntity? userDataEntity = await hiveHelper.getData<UserDataEntity>(
        boxName: HiveBox.USER_DATA_BOX);

    if (userDataEntity == null) return null;

    List<ProductsEntity>? oldProducts = userDataEntity.products;

    if (oldProducts == null) return null;

    List<ProductsEntity>? newProducts = [];

    for (var p in oldProducts) {
      if (storedSalesItems.keys.contains(p.id)) {
        p = p.copyWith(usedQuota: (p.usedQuota ?? 0) + storedSalesItems[p.id]!);
      }
      newProducts.add(p);
    }

    userDataEntity = userDataEntity.copyWith(products: newProducts);

    return userDataEntity;
  }
}
