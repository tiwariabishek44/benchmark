import 'dart:async';

import 'package:benchmark/app/config/color.dart';
import 'package:benchmark/app/modules/student_view/homepage.dart/pdf_controller.dart';
import 'package:benchmark/app/widgets/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFScreen extends StatefulWidget {
  PDFScreen({
    Key? key,
  }) : super(key: key);

  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> with WidgetsBindingObserver {
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();

  final pdfcontroller = Get.put(PdfController());
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';
  bool swif = false; // Remove the 'final' keyword

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Note  "),
        actions: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Obx(() => GestureDetector(
                onTap: () {
                  pdfcontroller.enableSwipe.value =
                      !pdfcontroller.enableSwipe.value;
                },
                child: Icon(pdfcontroller.enableSwipe.value
                    ? Icons.lock_open_outlined
                    : Icons.lock_outline))),
          ),
        ],
      ),
      body: Obx(() {
        if (pdfcontroller.isLoading.value) {
          return LoadingScreen();
        } else {
          return Stack(
            children: <Widget>[
              PDFView(
                filePath: pdfcontroller.remotePDFpath.value,
                enableSwipe: pdfcontroller.enableSwipe.value,
                swipeHorizontal: false,
                autoSpacing: false,
                pageFling: false,
                pageSnap: false,
                defaultPage: currentPage!,
                fitPolicy: FitPolicy.BOTH,
                preventLinkNavigation:
                    false, // if set to true the link is handled in flutter
                onRender: (_pages) {
                  setState(() {
                    pages = _pages;
                    isReady = true;
                  });
                },
                onError: (error) {
                  setState(() {
                    errorMessage = error.toString();
                  });
                  print(error.toString());
                },
                onPageError: (page, error) {
                  setState(() {
                    errorMessage = '$page: ${error.toString()}';
                  });
                  print('$page: ${error.toString()}');
                },
                onViewCreated: (PDFViewController pdfViewController) {
                  _controller.complete(pdfViewController);
                },
                onLinkHandler: (String? uri) {
                  print('goto uri: $uri');
                },
                onPageChanged: (int? page, int? total) {
                  print('page change: $page/$total');
                  setState(() {
                    currentPage = page;
                  });
                },
              ),
              errorMessage.isEmpty
                  ? !isReady
                      ? LoadingScreen()
                      : Container()
                  : Center(
                      child: Text(errorMessage),
                    ),
              Positioned(
                top: 16.0,
                right: 1,
                child: Container(
                  child: CustomPageScrollHandle(
                      currentPage: currentPage, totalPages: pages),
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}

class CustomPageScrollHandle extends StatelessWidget {
  final int? currentPage;
  final int? totalPages;

  const CustomPageScrollHandle({Key? key, this.currentPage, this.totalPages})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Text(
        '${currentPage! + 1}/$totalPages',
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
    );
  }
}
