import 'dart:developer';

import 'package:benchmark/app/model/api_response/mannual_response_model.dart';
import 'package:benchmark/app/model/api_response/mcq_response.dart';
import 'package:benchmark/app/repository/ger_course_repository.dart';
import 'package:benchmark/app/repository/get_all_mannual_repository.dart';
import 'package:benchmark/app/services/api_client.dart';
import 'package:get/get.dart';

class MannualController extends GetxController {
  var isLoading = false.obs;
  var mannualLoaded = false.obs;

  final GetAllMannualRepository mannualRepository = GetAllMannualRepository();

  final Rx<ApiResponse<MannualResponseModel>> mannualResponse =
      ApiResponse<MannualResponseModel>.initial().obs;
  Future<void> fetchAllMannuals(String subjectid) async {
    try {
      log("--fetching the notes");
      mannualLoaded(false);
      isLoading(true);

      mannualResponse.value = ApiResponse<MannualResponseModel>.loading();
      final courseResult = await mannualRepository.getAllMannual(subjectid);
      if (courseResult.status == ApiStatus.SUCCESS) {
        mannualResponse.value =
            ApiResponse<MannualResponseModel>.completed(courseResult.response);
        if (mannualResponse.value.response!.data!.length != 0) {
          mannualLoaded(true);
        }

        log(" :::::::::::::::::: total mannual are :::::: ${mannualResponse.value.response!.data!.length}");
        isLoading(false);
      } else {
        mannualResponse.value = ApiResponse<MannualResponseModel>.error(
            courseResult.message ?? 'Some thing went wrong');
        isLoading(false);
      }
    } catch (e) {
      isLoading(false);

      log('Error while getting data: $e');
    } finally {
      isLoading(false);
    }
  }
}
