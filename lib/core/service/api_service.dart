import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/shared/environment.dart';
import 'package:pokedex/shared/models/all_pokes_model.dart';
import 'package:pokedex/shared/models/pokemon_model.dart';

class ApiController {
  var env = Environment();

  Future<AllPokesModel?> getAll({
    required BuildContext context,
    int? limit,
    required int page,
  }) async {
    try {
      final Dio dio = Dio();
      dio.options.headers["content-Type"] = "application/json";

      final res = await dio.get(
        "${env.urlBase}/pokemon",
        queryParameters: {
          "offset": (limit ?? 20) * (page - 1),
          "limit": limit ?? 20,
        },
      );

      AllPokesModel? allPokes = AllPokesModel();

      allPokes = AllPokesModel.fromJson(jsonEncode(res.data));

      return allPokes;
    } on DioException catch (e) {
      return null;
    }
  }

  Future<PokemonModel?> getOne({
    required String name,
    required BuildContext context,
  }) async {
    try {
      final Dio dio = Dio();
      dio.options.headers["content-Type"] = "application/json";

      final res = await dio.get(
        "${env.urlBase}/pokemon/$name",
        queryParameters: {},
      );

      PokemonModel pokemon = PokemonModel();

      pokemon = PokemonModel.fromJson(jsonEncode(res.data));

      return pokemon;
    } on DioException catch (e) {
      return null;
    }
  }
}
