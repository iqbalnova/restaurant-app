import 'package:dio/dio.dart';
import 'package:myresto/data/models/restaurant_detail.dart';

import '../../config/api_client.dart';
import '../models/restaurant_list.dart';

class RestaurantServices {
  final ApiClient _client = ApiClient();

  Future<RestaurantDetailModel> getDetailRestaurant(
      {required String restaurantId}) async {
    try {
      final response = await _client.get('/detail/$restaurantId');

      if (response.statusCode == 200) {
        return RestaurantDetailModel.fromJson(response.data['restaurant']);
      } else {
        throw Exception(
            'Failed to load restaurant details: ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioException) {
        throw e.error!;
      }
      throw Exception(e);
    }
  }

  Future<RestaurantList> getRestaurantList() async {
    try {
      final response = await _client.get('/list');

      if (response.statusCode == 200) {
        // Assuming the JSON response is an array of restaurants
        return RestaurantList.fromJson(response.data);
      } else {
        throw Exception(
            'Failed to load restaurant list: ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioException) {
        throw e.error!;
      }
      throw Exception(e);
    }
  }

  Future<RestaurantList> searchRestaurants({required String query}) async {
    try {
      final response = await _client.get(
        '/search?q=$query',
      );

      if (response.statusCode == 200) {
        return RestaurantList.fromJson(response.data);
      } else {
        throw Exception(
            'Failed to load restaurant list: ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioException) {
        throw e.error!;
      }
      throw Exception(e);
    }
  }

  Future<String> sendReview(
      {required String restaurantId,
      required String name,
      required String review}) async {
    try {
      // Prepare the data to be sent in the POST request
      final data = {
        'id': restaurantId,
        'name': name,
        'review': review,
      };

      // Send POST request with the data
      final response = await _client.post(
        '/review',
        data: data,
      );

      // Check if the response status is 200 (OK)
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Extract and return the success message
        final message = response.data['message'];
        if (message == 'success') {
          return message;
        } else {
          return 'failed';
        }
      } else {
        throw Exception('Failed to send review: ${response.statusCode}');
      }
    } catch (e) {
      if (e is DioException) {
        throw e.error!;
      }
      throw Exception(e); // Handle other exceptions
    }
  }
}
