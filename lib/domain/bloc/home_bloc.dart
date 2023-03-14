import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'home_bloc.freezed.dart';

part 'home_event.dart';

part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState.initial()) {
    on<TextSubmitted>(_onTextSubmitted);
  }

  void _onTextSubmitted(
    TextSubmitted event,
    Emitter<HomeState> emit,
  ) {
    // TODO
  }
}
