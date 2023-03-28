import 'package:english_words/di/dependency_injection.dart';
import 'package:english_words/domain/bloc/home/home_bloc.dart';
import 'package:english_words/presentation/common/text_to_speech_constants.dart';
import 'package:english_words/presentation/common/widgets/edit_translation_dialog.dart';
import 'package:english_words/presentation/extensions.dart';
import 'package:english_words/presentation/home/widgets/home_content.dart';
import 'package:english_words/presentation/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController _textEditController;
  late FlutterTts _textToSpeech;

  @override
  void initState() {
    super.initState();
    _textEditController = TextEditingController();
    _textToSpeech = getIt<FlutterTts>();
  }

  @override
  void dispose() {
    _textEditController.dispose();
    _textToSpeech.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (_, newState) {
        switch (newState.status) {
          case HomeStatus.translationSuccessful:
            _clearInput();
            break;
          case HomeStatus.translationFailure:
            _showTranslationFailureSnackBar(context);
            break;
          case HomeStatus.textAlreadySaved:
            _showTextAlreadySavedErrorSnackBar(context);
            break;
          case HomeStatus.textAlreadyLearned:
            _showTextAlreadyLearnedSnackBar(context);
            break;
          case HomeStatus.savedTextLearned:
            _showSavedTextLearnedSnackBar(context);
            break;
          case HomeStatus.savedTextDeleted:
            _showSavedTextDeletedSnackBar(context);
            break;
          default:
            break;
        }
      },
      builder: (context, state) {
        switch (state.status) {
          case HomeStatus.initialLoading:
            return const Center(child: CircularProgressIndicator());
          default:
            return HomeContent(
              textsToLearn: state.textsToLearn,
              isTranslatingInProgress:
                  state.status == HomeStatus.translationInProgress,
              textEditController: _textEditController,
              onTextSubmitted: (text) {
                context.read<HomeBloc>().add(HomeEvent.textSubmitted(text));
              },
              onTranslationLongPressed: (item) async {
                final editedTranslation = await showEditTranslationDialog(
                  context,
                  item.translations.getAsText(),
                );

                if (context.mounted) {
                  context.read<HomeBloc>().add(
                      HomeEvent.translationEdited(item, editedTranslation));
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
              onTextAddedToLearned: (item) {
                context
                    .read<HomeBloc>()
                    .add(HomeEvent.textAddedToLearned(item));
              },
              onTextDeleted: (item) {
                context.read<HomeBloc>().add(HomeEvent.savedTextDeleted(item));
              },
            );
        }
      },
    );
  }

  void _clearInput() {
    _textEditController.clear();
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
      SnackBar(
        content: Text(message),
        backgroundColor: ThemeProvider.of(context).errorColor,
      ),
    );
  }

  void _showSavedTextLearnedSnackBar(BuildContext context) {
    _showSingleSnackBar(
      SnackBar(
        content: Text(context.strings.homeSavedTextLearned),
        action: SnackBarAction(
          label: context.strings.undo,
          onPressed: () {
            context
                .read<HomeBloc>()
                .add(const HomeEvent.undoAddingTextToLearned());
          },
        ),
      ),
    );
  }

  void _showSavedTextDeletedSnackBar(BuildContext context) {
    _showSingleSnackBar(
      SnackBar(
        content: Text(context.strings.homeSavedTextDeleted),
        action: SnackBarAction(
          label: context.strings.undo,
          onPressed: () {
            context
                .read<HomeBloc>()
                .add(const HomeEvent.undoDeletingSavedText());
          },
        ),
      ),
    );
  }

  void _showSingleSnackBar(SnackBar snackBar) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
