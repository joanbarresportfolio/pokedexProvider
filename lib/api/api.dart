import 'dart:convert';

import 'package:examen_ordinaria/model/pokemon.dart';
import 'package:http/http.dart' as http;

class PokemonApiService {
  final String baseUrl = "https://pokeapi.co/api/v2/pokemon";

  // Mètode per obtenir el llistat de Pokémon
  Future<List<Pokemon>> fetchPokemonList({int limit = 20}) async {
    final response =
        await http.get(Uri.parse("$baseUrl?offset=0&limit=$limit"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<Pokemon> pokemonList = [];

      for (var item in data['results']) {
        String detailsUrl = item['url'];

        // Obtenir detalls de cada Pokémon
        Pokemon pokemon = await fetchPokemonDetails(detailsUrl);
        pokemonList.add(pokemon);
      }

      return pokemonList;
    } else {
      throw Exception("Error carregant la llista de Pokémon");
    }
  }

  Future<Pokemon> fetchPokemonDetails(String url) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      // Extraer tipos
      List<String> types = List<String>.from(
        data['types'].map((t) => t['type']['name']),
      );

      // Extraer habilidades
      List<String> abilities = List<String>.from(
        data['abilities'].map((a) => a['ability']['name']),
      );

      // Extraer movimientos
      List<String> moves = List<String>.from(
        data['moves'].map((m) => m['move']['name']),
      );

      // Extraer estadísticas
      Map<String, int> stats = {};
      for (var stat in data['stats']) {
        stats[stat['stat']['name']] = stat['base_stat'];
      }

      return Pokemon(
        id: data['id'],
        nom: data['name'],
        imatgeGran:
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${data['id']}.png",
        imatgeMenuda:
            "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${data['id']}.png",
        height: data['height'],
        weight: data['weight'],
        baseExperience: data['base_experience'],
        types: types,
        abilities: abilities,
        moves: moves,
        stats: stats,
      );
    } else {
      throw Exception("Error carregant les dades del Pokémon");
    }
  }
}
