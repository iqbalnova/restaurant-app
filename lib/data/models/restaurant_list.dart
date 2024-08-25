import 'package:equatable/equatable.dart';

import 'restaurant.dart';

class RestaurantList extends Equatable {
  final List<Restaurant> restaurants;

  const RestaurantList({required this.restaurants});

  factory RestaurantList.fromJson(Map<String, dynamic> json) {
    return RestaurantList(
      restaurants: (json['restaurants'] as List<dynamic>)
          .map((item) => Restaurant.fromJson(item))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [restaurants];
}
