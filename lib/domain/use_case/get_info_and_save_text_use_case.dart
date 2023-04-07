import 'package:english_words/domain/model/saved_text/saved_text.dart';
import 'package:english_words/domain/use_case/get_text_info_use_case.dart';
import 'package:english_words/domain/use_case/save_text_use_case.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetInfoAndSaveTextUseCase {
  final GetTextInfoUseCase getTextInfoUseCase;
  final SaveTextUseCase _saveTextUseCase;

  GetInfoAndSaveTextUseCase(
    this.getTextInfoUseCase,
    this._saveTextUseCase,
  );

  Future<SavedText> invoke(String text) =>
      getTextInfoUseCase.invoke(text).then(_saveTextUseCase.invoke);
}
