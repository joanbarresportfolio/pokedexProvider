import 'package:examen_ordinaria/database.dart';
import 'package:examen_ordinaria/model/pokemon.dart';
import 'package:examen_ordinaria/model/pokemonDao.dart';

class FavoritRepository {
  AppPokemonsDB? _database; // Referència a la BD
  PokemonDao? _dao; // Referència al DAO

  FavoritRepository._(); // Constructor privat

  // Instància única del repositori. La podem crear directament
  // en la inicialització
  static final FavoritRepository _instance = FavoritRepository._();

  // Quan se'ns demane el repositori retornem la instància.
  factory FavoritRepository() {
    return _instance;
  }

  // Connexió a la base de dades
  Future<void> connectaDB() async {
    if (_database == null) {
      // Creem la base de dades només si no s'ha creat ja
      _database = await $FloorAppPokemonsDB
          .databaseBuilder('planetes_database.db')
          .build();

      // Creem el DAO
      _dao = _database?.pokemonDao;
    }
  }

  Stream<List<Pokemon>> findAll() {
    return _dao?.findAll() ?? const Stream.empty();
  }

  Future<void> insertPlanet(Pokemon pokemon) {
    return _dao?.insertPokemon(pokemon) ?? Future.value();
  }

  Future<void> deletePlanet(Pokemon pokemon) {
    return _dao?.deletePokemon(pokemon) ?? Future.value();
  }
}
