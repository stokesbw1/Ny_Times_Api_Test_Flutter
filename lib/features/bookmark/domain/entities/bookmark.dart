import 'package:equatable/equatable.dart';

class Bookmark extends Equatable {
  final int id;

  const Bookmark({required this.id});

  @override
  List<Object?> get props => [id];
}
