import 'package:english_words/di/dependency_injection.dart';
import 'package:english_words/domain/bloc/learned_texts/learned_texts_bloc.dart';
import 'package:english_words/domain/model/saved_text/saved_text.dart';
import 'package:english_words/presentation/common/widgets/saved_texts_list_with_header.dart';
import 'package:english_words/presentation/extensions.dart';
import 'package:english_words/presentation/learned_texts/widgets/learned_words_list_placeholder.dart';
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
  Future<void> dispose() async {
    await _textToSpeech.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LearnedTextsBloc, LearnedTextsState>(
      listener: (_, newState) {
        switch (newState.status) {
          case LearnedTextsStatus.textMovedToLearn:
            _showTextMovedToLearnSnackBar(context);
            break;
          case LearnedTextsStatus.textDeleted:
            _showTextDeletedSnackBar(context);
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
            return Column(
              children: [
                const SizedBox(height: 16),
                state.learnedTexts.isEmpty
                    ? const LearnedWordsListPlaceholder()
                    : _buildList(state.learnedTexts),
              ],
            );
        }
      },
    );
  }

  Widget _buildList(List<SavedText> texts) {
    return Expanded(
      child: SavedTextsListWithHeader(
        texts: texts,
        onTranscriptionLongPressed: (item) {
          _textToSpeech.speak(item.originalText);
        },
        onTextAddedToLearned: (item) {
          context
              .read<LearnedTextsBloc>()
              .add(LearnedTextsEvent.textMovedToLearn(item));
        },
        onTextDeleted: (item) {
          context
              .read<LearnedTextsBloc>()
              .add(LearnedTextsEvent.textDeleted(item));
        },
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
}
