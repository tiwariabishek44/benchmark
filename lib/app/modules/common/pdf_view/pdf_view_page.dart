import 'dart:async';
import 'dart:developer';

import 'package:benchmark/app/config/color.dart';
import 'package:benchmark/app/modules/common/pdf_view/pdf_controller.dart';
import 'package:benchmark/app/widgets/downloading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PDFScreen extends StatefulWidget {
  final String pdfUrl;
  final String title;
  PDFScreen({Key? key, required this.pdfUrl, required this.title})
      : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w700),
        ),
        backgroundColor: AppColors.backgroundColor,
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Obx(() => GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          "${pdfcontroller.enableSwipe.value ? " The page is lock" : "The page is unlock"}"),
                      duration: Duration(seconds: 2),
                    ),
                  );
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
          errorMessage = '';
          return DownloadingScreen();
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
                },
                onPageError: (page, error) {
                  setState(() {
                    errorMessage = '$page: ${error.toString()}';
                  });
                  log('$page: ${error.toString()}');
                },
                onViewCreated: (PDFViewController pdfViewController) {
                  _controller.complete(pdfViewController);
                },
                onLinkHandler: (String? uri) {
                  log('goto uri: $uri');
                },
                onPageChanged: (int? page, int? total) {
                  // log('page change: $page/$total');
                  setState(() {
                    currentPage = page;
                  });
                },
              ),
              errorMessage.isEmpty
                  ? !isReady
                      ? DownloadingScreen()
                      : Container()
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            color: AppColors.mainColor,
                            size: 48.0,
                          ),
                          SizedBox(height: 16.0),
                          Text(
                            'Error While Loading PDF',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: AppColors.mainColor,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            'Something Went Wrong, Please Check Your Internet Connection.',
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 16.0),
                          ElevatedButton(
                            onPressed: () {
                              pdfcontroller
                                  .createFileOfPdfUrl(widget.pdfUrl)
                                  .then((file) {
                                pdfcontroller.remotePDFpath.value = file.path;
                              });
                              // Add a function to retry or handle the error
                            },
                            child: Text(
                              'Retry',
                              style:
                                  TextStyle(color: AppColors.backgroundColor),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: AppColors
                                  .mainColor, // Customize the button color
                            ),
                          ),
                        ],
                      ),
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
