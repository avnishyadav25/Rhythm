import 'package:freezed_annotation/freezed_annotation.dart';

part 'book.freezed.dart';
part 'book.g.dart';

@freezed
class Book with _$Book {
  const factory Book({
    required String id,
    required String userId,
    required String title,
    String? author,
    String? coverUrl,
    @Default(0) int currentPage,
    @Default(0) int totalPages,
    @Default(0.0) double progressPercentage,
  }) = _Book;

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);
}
