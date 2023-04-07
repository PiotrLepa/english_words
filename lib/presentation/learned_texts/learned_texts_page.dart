import 'package:english_words/di/dependency_injection.dart';
import 'package:english_words/domain/bloc/learned_texts/learned_texts_bloc.dart';
import 'package:english_words/domain/model/saved_text/saved_text.dart';
import 'package:english_words/presentation/common/text_to_speech_constants.dart';
import 'package:english_words/presentation/common/widgets/edit_translation_dialog.dart';
import 'package:english_words/presentation/common/widgets/text_info_bottom_sheet_dialog.dart';
import 'package:english_words/presentation/extensions.dart';
import 'package:english_words/presentation/learned_texts/widgets/learned_texts_content.dart';
import 'package:english_words/presentation/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';

class LearnedTextsPage extends StatefulWidget {
  const LearnedTextsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<LearnedTextsPage> createState() => _LearnedTextsPageState();
}

class _LearnedTextsPageState extends State<LearnedTextsPage> {
  late FlutterTts _textToSpeech;

  @override
  void initState() {
    super.initState();
    _textToSpeech = getIt<FlutterTts>();
  }

  @override
  void dispose() {
    _textToSpeech.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LearnedTextsBloc, LearnedTextsState>(
      listener: (_, newState) {
        switch (newState.status) {
          case LearnedTextsStatus.translationFailure:
            _showTranslationFailureSnackBar(context);
            break;
          case LearnedTextsStatus.textAlreadySaved:
            _showTextAlreadySavedErrorSnackBar(context);
            break;
          case LearnedTextsStatus.textAlreadyLearned:
            _showTextAlreadyLearnedSnackBar(context);
            break;
          case LearnedTextsStatus.textMovedToLearn:
            _showTextMovedToLearnSnackBar(context);
            break;
          case LearnedTextsStatus.textDeleted:
            _showTextDeletedSnackBar(context);
            break;
          case LearnedTextsStatus.selectedTextTranslated:
            _showBottomSheetWithTranslatedText(
              context,
              newState.translatedSelectedText!,
            );
            break;
          default:
            break;
        }
      },
      builder: (context, state) {
        switch (state.status) {
          case LearnedTextsStatus.initialLoading:
            return const Center(child: CircularProgressIndicator());
          default:
            return LearnedTextsContent(
              learnedTexts: state.learnedTexts,
              onTranslationLongPressed: (item) async {
                final editedTranslation = await showEditTranslationDialog(
                  context,
                  item.translations.getAsText(),
                );

                if (context.mounted) {
                  context.read<LearnedTextsBloc>().add(
                      LearnedTextsEvent.translationEdited(
                          item, editedTranslation));
                }
              },
              onTranscriptionPressed: (item) {
                _textToSpeech
                  ..setSpeechRate(TextToSpeechConstants.normalSpeedRate)
                  ..speak(item.originalText);
              },
              onTranscriptionLongPressed: (item) {
                _textToSpeech
                  ..setSpeechRate(TextToSpeechConstants.slowSpeedRate)
                  ..speak(item.originalText);
              },
              onTextMovedToLearn: (item) {
                context
                    .read<LearnedTextsBloc>()
                    .add(LearnedTextsEvent.textMovedToLearn(item));
              },
              onTextDeleted: (item) {
                context
                    .read<LearnedTextsBloc>()
                    .add(LearnedTextsEvent.textDeleted(item));
              },
              onTranslateClicked: (text) {
                context
                    .read<LearnedTextsBloc>()
                    .add(LearnedTextsEvent.translateClicked(text));
              },
              onTranslateAndSaveClicked: (text) {
                context
                    .read<LearnedTextsBloc>()
                    .add(LearnedTextsEvent.translateAndSaveClicked(text));
              },
            );
        }
      },
    );
  }

  void _showTextAlreadySavedErrorSnackBar(BuildContext context) {
    _showErrorSnackBar(context, context.strings.homeTextAlreadySavedError);
  }

  void _showTextAlreadyLearnedSnackBar(BuildContext context) {
    _showErrorSnackBar(context, context.strings.homeTextAlreadyLearnedError);
  }

  void _showTranslationFailureSnackBar(BuildContext context) {
    _showErrorSnackBar(context, context.strings.translationFailureMessage);
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    _showSingleSnackBar(
      context,
      SnackBar(
        content: Text(message),
        backgroundColor: ThemeProvider.of(context).errorColor,
      ),
    );
  }

  void _showTextMovedToLearnSnackBar(BuildContext context) {
    _showSingleSnackBar(
      context,
      SnackBar(
        content: Text(context.strings.learnedTextsTextMovedToLearn),
        action: SnackBarAction(
          label: context.strings.undo,
          onPressed: () {
            context
                .read<LearnedTextsBloc>()
                .add(const LearnedTextsEvent.undoMovingTextToLearn());
          },
        ),
      ),
    );
  }

  void _showTextDeletedSnackBar(BuildContext context) {
    _showSingleSnackBar(
      context,
      SnackBar(
        content: Text(context.strings.homeSavedTextDeleted),
        action: SnackBarAction(
          label: context.strings.undo,
          onPressed: () {
            context
                .read<LearnedTextsBloc>()
                .add(const LearnedTextsEvent.undoDeletingText());
          },
        ),
      ),
    );
  }

  void _showSingleSnackBar(BuildContext context, SnackBar snackBar) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _showBottomSheetWithTranslatedText(
    BuildContext context,
    SavedText text,
  ) {
    showBottomSheetWithTextInfo(
      context: context,
      text: text,
      onTranslationLongPressed: (item) {},
      onTranscriptionPressed: (item) {
        _textToSpeech
          ..setSpeechRate(TextToSpeechConstants.normalSpeedRate)
          ..speak(item.originalText);
      },
      onTranscriptionLongPressed: (item) {
        _textToSpeech
          ..setSpeechRate(TextToSpeechConstants.slowSpeedRate)
          ..speak(item.originalText);
      },
      onTranslateClicked: (text) {
        context
            .read<LearnedTextsBloc>()
            .add(LearnedTextsEvent.translateClicked(text));
      },
      onTranslateAndSaveClicked: (text) {
        context
            .read<LearnedTextsBloc>()
            .add(LearnedTextsEvent.translateAndSaveClicked(text));
      },
    );
  }
}
