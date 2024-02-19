import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:benchmark/app/model/recent_viewes_model.dart';

class RecentViewsController extends GetxController {
  final box = GetStorage();

  // Using RxList for reactive list
  RxList<RecentViewModel> items = <RecentViewModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Retrieve stored items from GetStorage
    List<dynamic>? storedItems = box.read('item');
    items = storedItems
            ?.map((item) => RecentViewModel.fromMap(item))
            .toList()
            .obs ??
        <RecentViewModel>[].obs;
  }

  bool isItemRepeated(RecentViewModel newItem) {
    // Check if a similar item already exists in the list
    return items.any((item) =>
        item.stream == newItem.stream && item.noteName == newItem.noteName);
  }

  void addItem(String stream, String noteName, String link) {
    RecentViewModel newItem = RecentViewModel(
        stream: stream.toString(),
        noteName: noteName.toString(),
        pdfLink: link);

    // Check if the item is repeated
    if (!isItemRepeated(newItem)) {
      // Add item to the top of the stack
      items.insert(0, newItem);

      // Limit the storage capacity to 4 items
      if (items.length > 4) {
        // Remove the bottom item
        items.removeLast();
      }

      // Convert the list of model instances to a list of maps
      List<Map<String, dynamic>> itemsMapList =
          items.map((item) => item.toMap()).toList();

      // Update storage
      box.write('item', itemsMapList);
    }
  }

  void clearList() {
    // Clear the list and update storage
    items.clear();
    box.remove('item');
  }
}
