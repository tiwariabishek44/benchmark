// REPOSITORY TO GET THE PHYSICAL ITEMS

import 'package:benchmark/app/config/api_endpoint.dart';
import 'package:benchmark/app/model/api_response/physical_items_response.dart';
import 'package:benchmark/app/services/api_client.dart';

class PhysicalItemRepository {
  Future<ApiResponse<PhysicalItemApiResponse>> getPhysicalItems() async {
    final response = await ApiClient().getApi<PhysicalItemApiResponse>(
      ApiEndpoints.getPhysicalProduct,
      isTokenRequired: false,
      responseType: (json) => PhysicalItemApiResponse.fromJson(json),
    );

    return response;
  }
}
