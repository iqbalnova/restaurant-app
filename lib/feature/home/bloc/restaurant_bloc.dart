import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:myresto/data/models/restaurant_detail.dart';
import 'package:myresto/data/models/restaurant_list.dart';
import 'package:myresto/data/services/restaurant_services.dart';

part 'restaurant_event.dart';
part 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  final RestaurantServices _services = RestaurantServices();

  RestaurantBloc() : super(RestaurantInitial()) {
    on<GetListRestaurantEvent>((event, emit) async {
      emit(RestaurantLoading());

      try {
        final restaurantList = await _services.getRestaurantList();
        emit(RestaurantListSuccess(restaurantList: restaurantList));
      } catch (e) {
        emit(RestaurantFailed(error: e.toString()));
      }
    });

    on<GetDetailRestaurantEvent>((event, emit) async {
      emit(RestaurantLoading());

      try {
        final restaurantDetail = await _services.getDetailRestaurant(
            restaurantId: event.restaurantId);
        emit(RestaurantDetailSuccess(restaurant: restaurantDetail));
      } catch (e) {
        emit(RestaurantFailed(error: e.toString()));
      }
    });

    on<SearchRestaurantEvent>((event, emit) async {
      emit(RestaurantLoading());

      try {
        final restaurantList =
            await _services.searchRestaurants(query: event.query);
        emit(RestaurantListSuccess(restaurantList: restaurantList));
      } catch (e) {
        emit(RestaurantFailed(error: e.toString()));
      }
    });

    on<SendReviewEvent>((event, emit) async {
      emit(RestaurantLoading());

      try {
        final response = await _services.sendReview(
            restaurantId: event.restaurantId,
            name: event.name,
            review: event.review);
        emit(SubmitReviewSuccess(message: response));
      } catch (e) {
        emit(SubmitReviewFailed(error: e.toString()));
      }
    });
  }
}
