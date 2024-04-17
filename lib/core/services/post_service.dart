import 'package:demo_rest_api_flutter/core/base/base_service.dart';
import 'package:demo_rest_api_flutter/core/services/network_api_service.dart';
import 'package:http/http.dart' as http;

import '../network/api_end_point.dart';

class PostService extends BaseService{
    Future<http.Response> postsApiResponse() async {
    try {
      final response = await NetworkApiService()
          .getApiResponse(ApiEndPoint.posts, null);
      return response;
    } catch (e) {
      throw Exception(e);
    }
  }
}