import 'dart:developer';
import 'package:benchmark/app/model/api_response/mcq_response.dart';
import 'package:benchmark/app/repository/mcq_respository.dart';
import 'package:benchmark/app/services/api_client.dart';
import 'package:benchmark/app/widgets/custom_snackbar.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

class McqController extends GetxController {
  var isMcqLoading = false.obs;
  var isloded = false.obs;

  @override
  void onInit() async {
    super.onInit();
    isloded(false);
    getMcq();
    log("mcq controler initilize");
  }
  //--------------Get physical items------------------

  final getMcqRepository = Get.put(McqRepository());
  final Rx<ApiResponse<McqApiResponse>> mcqResponse =
      ApiResponse<McqApiResponse>.initial().obs;

  Future<void> getMcq() async {
    try {
      isloded(false);

      isMcqLoading(true);
      mcqResponse.value = ApiResponse<McqApiResponse>.loading();
      final itemsResult = await getMcqRepository.getAllMcq();
      if (itemsResult.status == ApiStatus.SUCCESS) {
        mcqResponse.value =
            ApiResponse<McqApiResponse>.completed(itemsResult.response);

        if (mcqResponse.value.response!.data.length != 0) {
          isloded(true);
        }
        isMcqLoading(false);
      } else {
        CustomSnackBar.showFailure('Some Thing went wrong');
        isloded(false);
        isMcqLoading(false);
      }
    } catch (e) {
      CustomSnackBar.showFailure('$e');
      isMcqLoading(false);
    }
  }
}
