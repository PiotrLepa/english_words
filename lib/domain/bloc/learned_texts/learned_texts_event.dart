part of 'learned_texts_bloc.dart';

@freezed
class LearnedTextsEvent with _$LearnedTextsEvent {
  const factory LearnedTextsEvent.screenStarted() = ScreenStarted;

  const factory LearnedTextsEvent.textMovedToLearn(SavedText item) =
      TextMovedToLearn;

  const factory LearnedTextsEvent.undoMovingTextToLearn() =
      UndoMovingTextToLearn;

  const factory LearnedTextsEvent.textDeleted(SavedText item) = TextDeleted;

  const factory LearnedTextsEvent.undoDeletingText() = UndoDeletingText;
}
