Map<String, String> convertMap(Map<String, dynamic> originalMap) {
  Map<String, String> convertedMap = {};

  originalMap.forEach((key, value) {
    // Check if the value is not null before converting to String
    if (value != null) {
      convertedMap[key] = value.toString();
    } else {
      // Handle null values if needed, for example, set them to an empty string
      convertedMap[key] = '';
    }
  });

  return convertedMap;
}
