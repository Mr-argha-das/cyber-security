import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {

  // Initialize Hive
  Future<void> init(String boxName) async {
    await Hive.initFlutter();
    await Hive.openBox(boxName);
  }

  // Save data (Map format)
  Future<void> saveData(String key, Map<String, dynamic> data, String boxName) async {
    final box = Hive.box(boxName);
    await box.put(key, data);
  }

  // Get data
  Map<String, dynamic>? getData(String key, String boxName) {
    final box = Hive.box(boxName);
    final data = box.get(key);
    return data != null ? Map<String, dynamic>.from(data) : null;
  }

  // Delete data
  Future<void> deleteData(String key, String boxName) async {
    final box = Hive.box(boxName);
    await box.delete(key);
  }

  // Get all keys
  List<String> getAllKeys(String boxName ) {
    final box = Hive.box(boxName);
    return box.keys.cast<String>().toList();
  }

  // Clear all data
  Future<void> clearAll(String boxName) async {
    final box = Hive.box(boxName);
    await box.clear();
  }
}
