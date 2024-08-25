part of 'restaurant_bloc.dart';

abstract class RestaurantState extends Equatable {
  const RestaurantState();

  @override
  List<Object> get props => [];
}

class RestaurantInitial extends RestaurantState {}

final class RestaurantLoading extends RestaurantState {}

final class RestaurantFailed extends RestaurantState {
  final String error;

  const RestaurantFailed({required this.error});

  @override
  List<Object> get props => [error];
}

final class RestaurantListSuccess extends RestaurantState {
  final RestaurantList restaurantList;

  const RestaurantListSuccess({required this.restaurantList});

  @override
  List<Object> get props => [restaurantList];
}

final class RestaurantDetailSuccess extends RestaurantState {
  final RestaurantDetailModel restaurant;

  const RestaurantDetailSuccess({required this.restaurant});

  @override
  List<Object> get props => [restaurant];
}

// Send Review
final class SubmitReviewLoading extends RestaurantState {}

final class SubmitReviewFailed extends RestaurantState {
  final String error;

  const SubmitReviewFailed({required this.error});

  @override
  List<Object> get props => [error];
}

final class SubmitReviewSuccess extends RestaurantState {
  final String message;

  const SubmitReviewSuccess({required this.message});

  @override
  List<Object> get props => [message];
}
