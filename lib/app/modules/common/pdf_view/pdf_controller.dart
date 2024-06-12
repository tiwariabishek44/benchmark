import 'dart:developer';
import 'package:benchmark/app/services/http_client.dart';
import 'package:benchmark/app/services/http_client1.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';

class PdfController extends GetxController {
  var enableSwipe = true.obs;
  var remotePDFpath = "".obs;
  var isLoading = false.obs;

  void fetchPdf(String url) async {
    log(" this is the mannual location :::::::$url");
    await createFileOfPdfUrl(url).then((file) {
      if (file != null) {
        remotePDFpath.value = file.path;
      }
    });
  }

  Future<File?> createFileOfPdfUrl(String url) async {
    isLoading(true);
    Completer<File?> completer = Completer();
    try {
      final filename = url.substring(url.lastIndexOf("/") + 1);
      final sanitizedFilename = filename.replaceAll(':', '_');
      

      var response = await pdfHttpClient.get(Uri.parse(url));
      log("This is the response status code: ${response.statusCode}");
      var dir = await getApplicationDocumentsDirectory();
      File file = File("${dir.path}/$sanitizedFilename");

      await file.writeAsBytes(response.bodyBytes, flush: true);

      completer.complete(file);
      isLoading(false);
    } on SocketException catch (_) {
      isLoading(false);
      completer.completeError('No internet connection');
    } catch (e) {
      log(" the eroro is ${e.toString()}");
      isLoading(false);
      completer.completeError('Error parsing asset file!');
    }

    return completer.future;
  }
}
