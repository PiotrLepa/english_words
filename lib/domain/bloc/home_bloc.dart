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

  HomeBloc(this._getTextInfoUseCase) : super(HomeState.initial()) {
    on<TextSubmitted>(_onTextSubmitted);
  }

  Future<void> _onTextSubmitted(TextSubmitted event,
      Emitter<HomeState> emit,) async {
    await _getTextInfoUseCase.invoke(event.text).then((textInfo) {
      final savedTexts = state.savedTexts ?? [];
      savedTexts.add(textInfo);
      emit(state.copyWith(savedTexts: savedTexts));
      }).catchError((error, stackTrace) {
      log(
        'translating failed: $error',
        error: error,
        stackTrace: stackTrace,
      );
    });
  }
}
