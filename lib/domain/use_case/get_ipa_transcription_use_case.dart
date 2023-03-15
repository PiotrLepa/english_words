import 'package:english_words/domain/model/ipa_transcription/ipa_transcription.dart';
import 'package:english_words/domain/repository/ipa_transcription_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetIpaTranscriptionUseCase {
  final IpaTranscriptionRepository _repository;

  GetIpaTranscriptionUseCase(this._repository);

  Future<IpaTranscription> invoke(String text) =>
      _repository.getIpaTranscription(text);
}
