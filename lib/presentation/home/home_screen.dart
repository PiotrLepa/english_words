import 'package:english_words/domain/bloc/home_bloc.dart';
import 'package:english_words/presentation/extensions.dart';
import 'package:english_words/presentation/home/widgets/home_page.dart';
import 'package:english_words/presentation/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _textEditController = TextEditingController();

  @override
  void dispose() {
    _textEditController.dispose();
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
          newState.maybeMap(
            translationSuccessful: (_) => _clearInput(),
            textAlreadySaved: (_) => _showTextAlreadySavedErrorSnackBar(context),
            translationFailure: (_) => _showTranslationFailureSnackBar(context),
            orElse: () {},
          );
        },
        builder: (context, state) {
          return HomePage(
            savedTexts: state.savedTexts,
            isTranslatingInProgress: state.isTranslatingInProgress,
            textEditController: _textEditController,
            onTextSubmitted: (text) {
              context.read<HomeBloc>().add(HomeEvent.textSubmitted(text));
            },
          );
        },
      ),
    );
  }

  void _showTextAlreadySavedErrorSnackBar(BuildContext context) {
    _showErrorSnackBar(context, context.strings.homeTextAlreadySavedError);
  }

  void _showTranslationFailureSnackBar(BuildContext context) {
    _showErrorSnackBar(context, context.strings.translationFailureMessage);
  }

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: ThemeProvider.of(context).errorColor,
      ),
    );
  }

  void _clearInput() {
    _textEditController.clear();
  }
}
