// import 'package:temwin_front_app/Core/utils/hive_boxes.dart';
// import 'package:temwin_front_app/Core/utils/hive_init_helper.dart';
// import 'package:temwin_front_app/Domain/entities/pos_bnf_data_entity.dart';

 

// abstract class VendorLocalDataSource {
//   Future<PosBnfDataEntity?> getVendorBnfData();

//   Future<void> storeVendorBnfData({required PosBnfDataEntity posBnfData});

//   Future<void> clearVendorBnfData();
// }

// class VendorLocalDataSourceImpl implements VendorLocalDataSource {
//   final HiveHelper hiveHelper;

//   const VendorLocalDataSourceImpl({required this.hiveHelper});

 

//   @override
//   Future<VendorDataEntity?> getVendor() async {
//     try {
//       return await hiveHelper.getData<VendorDataEntity>(
//           boxName: HiveBox.Vendor_DATA_BOX);
//     } catch (e) {
//       return null;
//     }
//   }

//   @override
//   Future<void> storeVendor({required VendorDataEntity VendorEntity}) async {
//     return await hiveHelper.storeData<VendorDataEntity>(
//         object: VendorEntity, boxName: HiveBox.Vendor_DATA_BOX);
//   }
  
//   @override
//   Future<void> clearVendorBnfData() async {
//     return await hiveHelper.clearBox(boxName: HiveBox.Vendor_DATA_BOX);
//   }
  
//   @override
//   Future<PosBnfDataEntity?> getVendorBnfData() {
//     // TODO: implement getVendorBnfData
//     throw UnimplementedError();
//   }
  
//   @override
//   Future<void> storeVendorBnfData({required PosBnfDataEntity posBnfData}) {
//     // TODO: implement storeVendorBnfData
//     throw UnimplementedError();
//   }
// }
