import 'package:get/get.dart';
import 'dart:async';

import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';

class PdfController extends GetxController {
  var enableSwipe = true.obs;
  var remotePDFpath = "".obs;
  var isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    createFileOfPdfUrl().then((file) {
      remotePDFpath.value = file.path;
    });
  }

  Future<File> createFileOfPdfUrl() async {
    isLoading(true);
    Completer<File> completer = Completer();
    print("Start download file from internet!");
    try {
      final url =
          "https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf";
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      print("Download files");
      print("${dir.path}/$filename");
      File file = File("${dir.path}/$filename");

      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
      isLoading(false);
    } catch (e) {
      isLoading(false);
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }
}
