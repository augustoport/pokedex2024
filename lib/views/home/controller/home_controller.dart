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
      notifyListeners();
      allPokesModel = await _apiController.getAll(
          context: context, limit: limit, page: page);


      print(allPokesModel);
      loading = false;
      notifyListeners();
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  void showPokes(context) async {
    try {
      loading = true;
      notifyListeners();

      for (var i = 0; i < (allPokesModel?.results?.length ?? 0); i++) {
        PokemonModel? poke = PokemonModel();
        poke = await _apiController.getOne(
            name: allPokesModel!.results![i].name!, context: context);
        pokemons.add(poke);
      }

    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
