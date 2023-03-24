import 'package:english_words/domain/model/saved_text/saved_text.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'deleted_text.freezed.dart';

@freezed
class DeletedText with _$DeletedText {
  const factory DeletedText({
    required int index,
    required SavedText text,
  }) = _DeletedText;
}
