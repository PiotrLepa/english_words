import 'package:english_words/domain/model/saved_text/saved_text.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'modified_text.freezed.dart';

@freezed
class ModifiedText with _$ModifiedText {
  const factory ModifiedText({
    required int index,
    required SavedText text,
  }) = _ModifiedText;
}
