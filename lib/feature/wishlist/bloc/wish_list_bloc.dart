import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'wish_list_event.dart';
part 'wish_list_state.dart';

class WishListBloc extends Bloc<WishListEvent, WishListState> {
  WishListBloc() : super(WishListInitial()) {
    on<WishListEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
