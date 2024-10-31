import 'package:flutter/material.dart';
import 'package:pokedex/core/bloc/main_bloc.dart';
import 'package:pokedex/views/home/home_page.dart';
import 'package:pokedex/views/splash/splash_page.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late MainBloc bloc;

  @override
  void initState() {
    Future.microtask(() {
      bloc.initialize();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bloc = Provider.of<MainBloc>(context);
    switch (bloc.state) {
      case AppState.SPLASH:
        return const SplashPage();
      case AppState.HOME:
        return const HomePage();
      default:
        return const HomePage();
    }
  }
}
