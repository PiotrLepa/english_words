import 'dart:developer';

import 'package:english_words/domain/model/text_info/text_info.dart';
import 'package:english_words/domain/use_case/get_text_info_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'home_bloc.freezed.dart';

part 'home_event.dart';

part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetTextInfoUseCase _getTextInfoUseCase;

  TextInfo? _recentlyDeletedText;
  int? _recentlyDeletedTextIndex;

  HomeBloc(this._getTextInfoUseCase)
      : super(const HomeState.loading(
          savedTexts: [
            TextInfo(
              originalText: 'test 1',
              translations: [
                Translation(detectedSourceLanguage: 'en', text: 'test 1'),
                Translation(detectedSourceLanguage: 'en', text: 'abc'),
                Translation(detectedSourceLanguage: 'en', text: 'de'),
                Translation(detectedSourceLanguage: 'en', text: 'test 1'),
                Translation(detectedSourceLanguage: 'en', text: 'abc'),
                Translation(detectedSourceLanguage: 'en', text: 'de'),
                Translation(detectedSourceLanguage: 'en', text: 'test 1'),
                Translation(detectedSourceLanguage: 'en', text: 'abc'),
                Translation(detectedSourceLanguage: 'en', text: 'de'),
              ],
              ipaTranscription: IpaTranscription(dialect: 'am', words: [
                WordIpaTranscription(isSuccessful: true, text: 'test 1'),
                WordIpaTranscription(isSuccessful: true, text: 'test 1'),
                WordIpaTranscription(isSuccessful: false, text: 'test 1'),
                WordIpaTranscription(isSuccessful: false, text: 'test 1'),
                WordIpaTranscription(isSuccessful: false, text: 'test 1'),
                WordIpaTranscription(isSuccessful: true, text: 'test 1'),
                WordIpaTranscription(isSuccessful: true, text: 'test 1'),
                WordIpaTranscription(isSuccessful: true, text: 'test 1'),
              ]),
            ),
            TextInfo(
              originalText: 'test 2',
              translations: [
                Translation(detectedSourceLanguage: 'en', text: 'test 2')
              ],
              ipaTranscription: IpaTranscription(dialect: 'am', words: [
                WordIpaTranscription(isSuccessful: true, text: 'test 2')
              ]),
            ),
            TextInfo(
              originalText: 'test 3',
              translations: [
                Translation(detectedSourceLanguage: 'en', text: 'test 3')
              ],
              ipaTranscription: IpaTranscription(dialect: 'am', words: [
                WordIpaTranscription(isSuccessful: true, text: 'test 3')
              ]),
            ),
            TextInfo(
              originalText: 'test 4',
              translations: [
                Translation(detectedSourceLanguage: 'en', text: 'test 4')
              ],
              ipaTranscription: IpaTranscription(dialect: 'am', words: [
                WordIpaTranscription(isSuccessful: true, text: 'test 4')
              ]),
            ),
            TextInfo(
              originalText: 'test 5',
              translations: [
                Translation(detectedSourceLanguage: 'en', text: 'test 5')
              ],
              ipaTranscription: IpaTranscription(dialect: 'am', words: [
                WordIpaTranscription(isSuccessful: true, text: 'test 5')
              ]),
            ),
            TextInfo(
              originalText: 'test 6',
              translations: [
                Translation(detectedSourceLanguage: 'en', text: 'test 6')
              ],
              ipaTranscription: IpaTranscription(dialect: 'am', words: [
                WordIpaTranscription(isSuccessful: true, text: 'test 6')
              ]),
            ),
            TextInfo(
              originalText: 'test 7',
              translations: [
                Translation(detectedSourceLanguage: 'en', text: 'test 7')
              ],
              ipaTranscription: IpaTranscription(dialect: 'am', words: [
                WordIpaTranscription(isSuccessful: true, text: 'test 7')
              ]),
            ),
            TextInfo(
              originalText: 'test 8',
              translations: [
                Translation(detectedSourceLanguage: 'en', text: 'test 8')
              ],
              ipaTranscription: IpaTranscription(dialect: 'am', words: [
                WordIpaTranscription(isSuccessful: true, text: 'test 8')
              ]),
            ),
            TextInfo(
              originalText: 'test 1',
              translations: [
                Translation(detectedSourceLanguage: 'en', text: 'test 1')
              ],
              ipaTranscription: IpaTranscription(dialect: 'am', words: [
                WordIpaTranscription(isSuccessful: true, text: 'test 1')
              ]),
            ),
            TextInfo(
              originalText: 'test 2',
              translations: [
                Translation(detectedSourceLanguage: 'en', text: 'test 2')
              ],
              ipaTranscription: IpaTranscription(dialect: 'am', words: [
                WordIpaTranscription(isSuccessful: true, text: 'test 2')
              ]),
            ),
            TextInfo(
              originalText: 'test 3',
              translations: [
                Translation(detectedSourceLanguage: 'en', text: 'test 3')
              ],
              ipaTranscription: IpaTranscription(dialect: 'am', words: [
                WordIpaTranscription(isSuccessful: true, text: 'test 3')
              ]),
            ),
            TextInfo(
              originalText: 'test 4',
              translations: [
                Translation(detectedSourceLanguage: 'en', text: 'test 4')
              ],
              ipaTranscription: IpaTranscription(dialect: 'am', words: [
                WordIpaTranscription(isSuccessful: true, text: 'test 4')
              ]),
            ),
            TextInfo(
              originalText: 'test 5',
              translations: [
                Translation(detectedSourceLanguage: 'en', text: 'test 5')
              ],
              ipaTranscription: IpaTranscription(dialect: 'am', words: [
                WordIpaTranscription(isSuccessful: true, text: 'test 5')
              ]),
            ),
            TextInfo(
              originalText: 'test 6',
              translations: [
                Translation(detectedSourceLanguage: 'en', text: 'test 6')
              ],
              ipaTranscription: IpaTranscription(dialect: 'am', words: [
                WordIpaTranscription(isSuccessful: true, text: 'test 6')
              ]),
            ),
            TextInfo(
              originalText: 'test 7',
              translations: [
                Translation(detectedSourceLanguage: 'en', text: 'test 7')
              ],
              ipaTranscription: IpaTranscription(dialect: 'am', words: [
                WordIpaTranscription(isSuccessful: true, text: 'test 7')
              ]),
            ),
            TextInfo(
              originalText: 'test 8',
              translations: [
                Translation(detectedSourceLanguage: 'en', text: 'test 8')
              ],
              ipaTranscription: IpaTranscription(dialect: 'am', words: [
                WordIpaTranscription(isSuccessful: true, text: 'test 8')
              ]),
            ),
            TextInfo(
              originalText: 'test 1',
              translations: [
                Translation(detectedSourceLanguage: 'en', text: 'test 1')
              ],
              ipaTranscription: IpaTranscription(dialect: 'am', words: [
                WordIpaTranscription(isSuccessful: true, text: 'test 1')
              ]),
            ),
            TextInfo(
              originalText: 'test 2',
              translations: [
                Translation(detectedSourceLanguage: 'en', text: 'test 2')
              ],
              ipaTranscription: IpaTranscription(dialect: 'am', words: [
                WordIpaTranscription(isSuccessful: true, text: 'test 2')
              ]),
            ),
            TextInfo(
              originalText: 'test 3',
              translations: [
                Translation(detectedSourceLanguage: 'en', text: 'test 3')
              ],
              ipaTranscription: IpaTranscription(dialect: 'am', words: [
                WordIpaTranscription(isSuccessful: true, text: 'test 3')
              ]),
            ),
            TextInfo(
              originalText: 'test 4',
              translations: [
                Translation(detectedSourceLanguage: 'en', text: 'test 4')
              ],
              ipaTranscription: IpaTranscription(dialect: 'am', words: [
                WordIpaTranscription(isSuccessful: true, text: 'test 4')
              ]),
            ),
            TextInfo(
              originalText: 'test 5',
              translations: [
                Translation(detectedSourceLanguage: 'en', text: 'test 5')
              ],
              ipaTranscription: IpaTranscription(dialect: 'am', words: [
                WordIpaTranscription(isSuccessful: true, text: 'test 5')
              ]),
            ),
            TextInfo(
              originalText: 'test 6',
              translations: [
                Translation(detectedSourceLanguage: 'en', text: 'test 6')
              ],
              ipaTranscription: IpaTranscription(dialect: 'am', words: [
                WordIpaTranscription(isSuccessful: true, text: 'test 6')
              ]),
            ),
            TextInfo(
              originalText: 'test 7',
              translations: [
                Translation(detectedSourceLanguage: 'en', text: 'test 7')
              ],
              ipaTranscription: IpaTranscription(dialect: 'am', words: [
                WordIpaTranscription(isSuccessful: true, text: 'test 7')
              ]),
            ),
            TextInfo(
              originalText: 'test 8',
              translations: [
                Translation(detectedSourceLanguage: 'en', text: 'test 8')
              ],
              ipaTranscription: IpaTranscription(dialect: 'am', words: [
                WordIpaTranscription(isSuccessful: true, text: 'test 8')
              ]),
            ),
          ],
          isTranslatingInProgress: false,
        )) {
    on<TextSubmitted>(_onTextSubmitted);
    on<SavedTextDeletedEvent>(_onSavedTextDeleted);
    on<UndoSavedTextDeletion>(_onUndoSavedTextDeletion);
  }

  Future<void> _onTextSubmitted(
    TextSubmitted event,
    Emitter<HomeState> emit,
  ) async {
    final trimmedText = event.text.trim();
    if (trimmedText.isEmpty || state.isTranslatingInProgress) return;
    if (_isTextAlreadySaved(trimmedText)) {
      emit(HomeState.textAlreadySaved(
        isTranslatingInProgress: false,
        savedTexts: state.savedTexts,
      ));
      return;
    }

    emit(HomeState.loading(
      isTranslatingInProgress: true,
      savedTexts: state.savedTexts,
    ));
    await _getTextInfoUseCase.invoke(trimmedText).then((textInfo) {
      emit(HomeState.translationSuccessful(
        isTranslatingInProgress: false,
        savedTexts: [textInfo, ...state.savedTexts],
      ));
    }).catchError((error, stackTrace) {
      emit(HomeState.translationFailure(
        isTranslatingInProgress: false,
        savedTexts: state.savedTexts,
      ));
      log(
        'getting text info failed',
        error: error,
        stackTrace: stackTrace,
      );
    });
  }

  bool _isTextAlreadySaved(String text) =>
      state.savedTexts.any((element) => element.originalText == text);

  Future<void> _onSavedTextDeleted(
    SavedTextDeletedEvent event,
    Emitter<HomeState> emit,
  ) async {
    _recentlyDeletedText = event.item;
    _recentlyDeletedTextIndex = state.savedTexts.indexOf(event.item);

    emit(HomeState.savedTextDeleted(
      isTranslatingInProgress: false,
      savedTexts:
          state.savedTexts.where((element) => element != event.item).toList(),
    ));
  }

  Future<void> _onUndoSavedTextDeletion(
    UndoSavedTextDeletion event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeState.loading( // TODO new state?
      isTranslatingInProgress: false,
      savedTexts: state.savedTexts.toList()
        ..insert(_recentlyDeletedTextIndex!, _recentlyDeletedText!),
    ));
    _recentlyDeletedText = null;
    _recentlyDeletedTextIndex = null;
  }
}
