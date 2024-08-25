import 'dart:developer';
import 'package:dio/dio.dart';

class ApiClient {
  final Dio _dio;

  ApiClient({String? baseUrl})
      : _dio = Dio(
          BaseOptions(
            baseUrl:
                baseUrl ?? 'https://restaurant-api.dicoding.dev', // Base URL
            connectTimeout: const Duration(seconds: 10), // Connection timeout
            receiveTimeout: const Duration(seconds: 10), // Receive timeout
            sendTimeout: const Duration(seconds: 10), // Send timeout
            headers: {
              'Content-Type': 'application/json', // Default headers
              'Accept': 'application/json',
            },
          ),
        ) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          // Request interceptor
          return handler.next(options);
        },
        onResponse: (response, handler) {
          // Response interceptor
          return handler.next(response);
        },
        onError: (DioException error, handler) {
          String errorMessage = "An unexpected error occurred.";

          if (error.type == DioExceptionType.connectionTimeout) {
            errorMessage = "Connection timed out.";
          } else if (error.type == DioExceptionType.receiveTimeout) {
            errorMessage = "Receive timed out.";
          } else if (error.type == DioExceptionType.badResponse) {
            errorMessage =
                "Failed to load data. Status: ${error.response?.statusCode}";
          } else if (error.type == DioExceptionType.connectionError) {
            errorMessage = "No internet connection.";
          }

          // Log the error message
          log(errorMessage);

          handler.reject(
            DioException(
              requestOptions: error.requestOptions,
              error: errorMessage,
              response: error.response,
              type: error.type,
            ),
          );
        },
      ),
    );
  }

  // GET request
  Future<Response> get(String path) async {
    return _dio.get(path);
  }

  // POST request
  Future<Response> post(String path, {Map<String, dynamic>? data}) async {
    return _dio.post(path, data: data);
  }

  // PUT request
  Future<Response> put(String path, {Map<String, dynamic>? data}) async {
    return _dio.put(path, data: data);
  }

  // DELETE request
  Future<Response> delete(String path, {Map<String, dynamic>? data}) async {
    return _dio.delete(path, data: data);
  }

  // PATCH request
  Future<Response> patch(String path, {Map<String, dynamic>? data}) async {
    return _dio.patch(path, data: data);
  }

  // POST request with FormData
  Future<Response> postForm(String path, FormData formData) async {
    return _dio.post(path, data: formData);
  }

  // Add other HTTP methods here (post, put, delete, etc.)
}
