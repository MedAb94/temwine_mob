import 'package:temwin_front_app/Domain/entities/product_entity.dart';

bool compareMaps(
    Map<ProductsEntity, int>? map1, Map<ProductsEntity, int>? map2) {
  // Check if both maps are null
  if (map1 == null && map2 == null) {
    return true;
  }

  // If only one map is null, they are not equal
  if (map1 == null || map2 == null) {
    return false;
  }

  // Check if maps have the same length
  if (map1.length != map2.length) {
    return false;
  }

  // Compare each key-value pair
  for (var entry in map1.entries) {
    var key = entry.key;
    var value = entry.value;

    if (!map2.containsKey(key) || map2[key] != value) {
      return false;
    }
  }

  return true;
}
