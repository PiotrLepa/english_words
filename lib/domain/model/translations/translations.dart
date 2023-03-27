import 'package:freezed_annotation/freezed_annotation.dart';

part 'translations.freezed.dart';

@freezed
class Translations with _$Translations {
  const factory Translations({
    required List<String> translations
  }) = _Translations;
}
