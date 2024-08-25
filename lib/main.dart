import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:workmanager/workmanager.dart';

import 'app.dart';
import 'config/notifi_helper.dart';

final GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();

@pragma('vm:entry-point')
void callbackDispatcher() async {
  Workmanager().executeTask((task, inputData) async {
    if (task == 'daily_notification_task') {
      // Fetch the restaurant list
      final restaurantList = await getRestaurantList();
      if (restaurantList != null && restaurantList.restaurants.isNotEmpty) {
        // Select a random restaurant name for the notification title
        final random = Random();
        final randomIndex = random.nextInt(restaurantList.restaurants.length);
        final randomRestaurantName =
            restaurantList.restaurants[randomIndex].name;

        // Send notification
        NotificationService.showNotification(
          title: randomRestaurantName,
          body: 'Check out this restaurant!',
        );
      }
    }
    return Future.value(true);
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Workmanager().initialize(
    callbackDispatcher,
  );

  NotificationService.init();
  tz.initializeTimeZones();

  runApp(MyApp(navigatorKey: globalKey));
}

Future<RestaurantList?> getRestaurantList() async {
  final Dio client =
      Dio(BaseOptions(baseUrl: 'https://restaurant-api.dicoding.dev'));
  try {
    final response = await client.get('/list');

    if (response.statusCode == 200) {
      return RestaurantList.fromJson(response.data);
    } else {
      throw Exception('Failed to load restaurant list: ${response.statusCode}');
    }
  } catch (e) {
    return null;
  }
}

class RestaurantList {
  final List<Restaurant> restaurants;

  RestaurantList({required this.restaurants});

  factory RestaurantList.fromJson(Map<String, dynamic> json) {
    var list = json['restaurants'] as List;
    List<Restaurant> restaurantList =
        list.map((i) => Restaurant.fromJson(i)).toList();
    return RestaurantList(restaurants: restaurantList);
  }
}

class Restaurant {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      pictureId: json['pictureId'],
      city: json['city'],
      rating: json['rating'].toDouble(),
    );
  }
}
