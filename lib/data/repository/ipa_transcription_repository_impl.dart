import 'package:english_words/data/converter/ipa_transcription_converter.dart';
import 'package:english_words/data/service/ipa_transcription/ipa_transcription_service.dart';
import 'package:english_words/domain/model/ipa_transcription/ipa_transcription.dart';
import 'package:english_words/domain/repository/ipa_transcription_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IpaTranscriptionRepository)
class IpaTranscriptionRepositoryImpl extends IpaTranscriptionRepository {
  final IpaTranscriptionService _service;
  final IpaTranscriptionConverter _ipaTranscriptionConverter;

  IpaTranscriptionRepositoryImpl(
    this._service,
    this._ipaTranscriptionConverter,
  );

  @override
  Future<IpaTranscription> getIpaTranscription(String text) => _service
      .getIpaTranscription(text)
      .then(_ipaTranscriptionConverter.toDomain);
}
