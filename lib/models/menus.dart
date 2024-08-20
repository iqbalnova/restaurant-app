import 'package:equatable/equatable.dart';
import 'menu_item.dart';

class Menus extends Equatable {
  final List<MenuItem> foods;
  final List<MenuItem> drinks;

  const Menus({
    required this.foods,
    required this.drinks,
  });

  factory Menus.fromJson(Map<String, dynamic> json) {
    return Menus(
      foods: (json['foods'] as List<dynamic>)
          .map((item) => MenuItem.fromJson(item))
          .toList(),
      drinks: (json['drinks'] as List<dynamic>)
          .map((item) => MenuItem.fromJson(item))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [foods, drinks];
}
