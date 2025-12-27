import 'package:freezed_annotation/freezed_annotation.dart';

part 'focus_session.freezed.dart';
part 'focus_session.g.dart';

@freezed
class FocusSession with _$FocusSession {
  const factory FocusSession({
    required String id,
    required String userId,
    required DateTime startTime,
    required DateTime endTime,
    required int durationMinutes,
    String? label,
  }) = _FocusSession;

  factory FocusSession.fromJson(Map<String, dynamic> json) => _$FocusSessionFromJson(json);
}
