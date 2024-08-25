part of 'restaurant_bloc.dart';

abstract class RestaurantEvent extends Equatable {
  const RestaurantEvent();

  @override
  List<Object> get props => [];
}

class RefreshGetListRestaurantEvent extends RestaurantEvent {}

class RefreshGetDetailRestaurantEvent extends RestaurantEvent {}

class GetListRestaurantEvent extends RestaurantEvent {}

class GetDetailRestaurantEvent extends RestaurantEvent {
  final String restaurantId;

  const GetDetailRestaurantEvent({required this.restaurantId});

  @override
  List<Object> get props => [restaurantId];
}

class SearchRestaurantEvent extends RestaurantEvent {
  final String query;

  const SearchRestaurantEvent({required this.query});

  @override
  List<Object> get props => [query];
}

class SendReviewEvent extends RestaurantEvent {
  final String restaurantId;
  final String name;
  final String review;

  const SendReviewEvent(
      {required this.restaurantId, required this.name, required this.review});

  @override
  List<Object> get props => [restaurantId, name, review];
}
