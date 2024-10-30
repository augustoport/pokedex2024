import 'package:pokedex/core/bloc/base_bloc.dart';

enum AppState { SPLASH, HOME }

class MainBloc extends BaseBloc {
  MainBloc() {
    initState(AppState.SPLASH);
  }

  Future<void> initialize() async {
    Future.delayed(const Duration(seconds: 2), () async {
      changeState(AppState.HOME);
    });
  }
}
