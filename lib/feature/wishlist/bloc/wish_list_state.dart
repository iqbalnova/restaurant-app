part of 'wish_list_bloc.dart';

sealed class WishListState extends Equatable {
  const WishListState();
  
  @override
  List<Object> get props => [];
}

final class WishListInitial extends WishListState {}
