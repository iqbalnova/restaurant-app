import 'package:equatable/equatable.dart';

class ReceivedNotification extends Equatable {
  final int? id;
  final String? title;
  final String? body;
  final String? payload;

  const ReceivedNotification({
    this.id,
    this.title,
    this.body,
    this.payload,
  });

  @override
  List<Object?> get props => [id, title, body, payload];
}
