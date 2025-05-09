import 'package:examen_ordinaria/api/api.dart';
import 'package:examen_ordinaria/model/pokemon.dart';
import 'package:flutter/foundation.dart';

class PokemonProvider with ChangeNotifier {
  List<Pokemon> _pokemons = [];

  final _repositoryPokemon = PokemonApiService();

  PokemonProvider() {
    _loadPokemons();
  }
  void _loadPokemons() async {
    _pokemons = await _repositoryPokemon.fetchPokemonList();
    notifyListeners();
  }

  List<Pokemon> get pokemons => _pokemons;
}
