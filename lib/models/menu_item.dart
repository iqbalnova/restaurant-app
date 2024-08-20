import 'package:equatable/equatable.dart';

class MenuItem extends Equatable {
  final String name;

  const MenuItem({required this.name});

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      name: json['name'],
    );
  }

  @override
  List<Object?> get props => [name];
}
