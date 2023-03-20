import 'package:english_words/data/model/translation/translation_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'translations_response.freezed.dart';

part 'translations_response.g.dart';

@freezed
class TranslationsResponse with _$TranslationsResponse {
  const factory TranslationsResponse({
    required List<TranslationResponse> translations,
  }) = _TranslationsResponse;

  factory TranslationsResponse.fromJson(Map<String, dynamic> json) =>
      _$TranslationsResponseFromJson(json);
  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    return super.toJson();
  }
}
