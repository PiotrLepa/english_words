import 'package:auto_route/annotations.dart';
import 'package:english_words/di/dependency_injection.dart';
import 'package:english_words/domain/bloc/home_bloc.dart';
import 'package:english_words/presentation/extensions.dart';
import 'package:english_words/presentation/home/widgets/home_page.dart';
import 'package:english_words/presentation/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tts/flutter_tts.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late TextEditingController _textEditController;
  late FlutterTts _textToSpeech;

  @override
  void initState() {
    super.initState();
    _textEditController = TextEditingController();
    _textToSpeech = getIt<FlutterTts>();
  }

  @override
  Future<void> dispose() async {
    _textEditController.dispose();
    await _textToSpeech.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.strings.appName),
      ),
      body: BlocConsumer<HomeBloc, HomeState>(
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
              return HomePage(
                savedTexts: state.savedTexts,
                isTranslatingInProgress:
                    state.status == HomeStatus.translationInProgress,
                textEditController: _textEditController,
                onTextSubmitted: (text) {
                  context.read<HomeBloc>().add(HomeEvent.textSubmitted(text));
                },
                onTranscriptionLongPressed: (item) {
                  _textToSpeech.speak(item.originalText);
                },
                onTextDeleted: (item) {
                  context
                      .read<HomeBloc>()
                      .add(HomeEvent.savedTextDeleted(item));
                },
              );
          }
        },
      ),
    );
  }

  void _clearInput() {
    _textEditController.clear();
  }

  void _showTextAlreadySavedErrorSnackBar(BuildContext context) {
    _showErrorSnackBar(context, context.strings.homeTextAlreadySavedError);
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

  void _showSavedTextDeletedSnackBar(BuildContext context) {
    _showSingleSnackBar(
      SnackBar(
        content: Text(context.strings.homeSavedTextDeleted),
        action: SnackBarAction(
          label: context.strings.homeUndoTextDeletion,
          onPressed: () {
            context
                .read<HomeBloc>()
                .add(const HomeEvent.undoSavedTextDeletion());
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
