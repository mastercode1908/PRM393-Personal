import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import '../models/item_model.dart';

class StorageService {
  static const String _fileName = 'local_database.json';

  // Get the path to the device's document directory
  Future<String> _getFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/$_fileName';
  }

  // Read items from storage or fallback to assets
  Future<List<Item>> readItems() async {
    try {
      final path = await _getFilePath();
      final file = File(path);

      // Check if file exists in device storage (Lab 9.2)
      if (await file.exists()) {
        final contents = await file.readAsString();
        List<dynamic> jsonList = jsonDecode(contents);
        return jsonList.map((json) => Item.fromJson(json)).toList();
      } else {
        // Fallback: Read from assets (Lab 9.1)
        final String assetContent = await rootBundle.loadString('assets/data/initial_data.json');
        List<dynamic> jsonList = jsonDecode(assetContent);
        final initialItems = jsonList.map((json) => Item.fromJson(json)).toList();
        
        // Save the initial data to device storage for future use
        await writeItems(initialItems);
        return initialItems;
      }
    } catch (e) {
      print("Error reading items: $e");
      return [];
    }
  }

  // Write items to storage (Auto-save for Lab 9.2 & 9.3)
  Future<void> writeItems(List<Item> items) async {
    try {
      final path = await _getFilePath();
      final file = File(path);

      final jsonList = items.map((item) => item.toJson()).toList();
      final String jsonString = jsonEncode(jsonList);

      await file.writeAsString(jsonString);
    } catch (e) {
      print("Error writing items: $e");
    }
  }
}
