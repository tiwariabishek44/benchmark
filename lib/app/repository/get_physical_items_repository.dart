import 'package:benchmark/app/config/api_endpoint.dart';
import 'package:benchmark/app/model/api_response/physical_items_response.dart';
import 'package:benchmark/app/model/api_response/student_purchase_course_response.dart';
import 'package:benchmark/app/services/api_client.dart';

class GetPhysicalItemsRepository {
  Future<ApiResponse<PhysicalItemsResponse>> getPhysicalItems() async {
    final response = await ApiClient().getApi<PhysicalItemsResponse>(
      ApiEndpoints.getPhsicalItems,
      isTokenRequired: false,
      responseType: (json) => PhysicalItemsResponse.fromJson(json),
    );

    return response;
  }
}
