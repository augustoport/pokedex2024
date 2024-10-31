import 'package:flutter/material.dart';
import 'package:pokedex/core/service/api_service.dart';
import 'package:pokedex/shared/models/all_pokes_model.dart';
import 'package:pokedex/shared/models/pokemon_model.dart';

class HomeController extends ChangeNotifier {
  final _apiController = ApiController();
  AllPokesModel? allPokesModel = AllPokesModel();
  List<PokemonModel?> pokemons = [];
  bool loading = false;

  void getAll(BuildContext context, int? limit, int page) async {
    try {
      loading = true;
      allPokesModel = AllPokesModel();
      allPokesModel = await _apiController.getAll(
          context: context, limit: limit, page: page);
      allPokesModel?.results?.forEach(
        (element) {
          if (element.name != null) {
            showPokes(element.name!, context);
          }
        },
      );

      loading = false;
      notifyListeners();
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  void showPokes(String name, context) async {
    try {
      pokemons.add(await _apiController.getOne(name: name, context: context));
      notifyListeners();
    } finally {}
  }
}
