// lib/model/planeta_dao.dart

import 'package:examen_ordinaria/model/pokemon.dart';
import 'package:floor/floor.dart';

@dao
abstract class PokemonDao {
  @Query('SELECT * FROM Pokemon')
  Stream<List<Pokemon>> findAll();

  @insert
  Future<void> insertPokemon(Pokemon pokemon);

  @delete
  Future<void> deletePokemon(Pokemon pokemon);
}
