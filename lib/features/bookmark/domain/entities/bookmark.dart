import 'package:equatable/equatable.dart';

class Bookmark extends Equatable {
  final int id;
  final bool isBookmarked;

  const Bookmark({required this.id, required this.isBookmarked});

  @override
  List<Object?> get props => [id, isBookmarked];
}
