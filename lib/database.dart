// database.dart

import 'dart:async';
import 'package:examen_ordinaria/converters.dart';
import 'package:examen_ordinaria/model/pokemon.dart';
import 'package:examen_ordinaria/model/pokemonDao.dart'; // Asegúrate de importar los conversores
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';

// Aplicamos los conversores personalizados a la base de datos
@TypeConverters([StringListConverter, StatsMapConverter])
@Database(version: 1, entities: [Pokemon])
abstract class AppPokemonsDB extends FloorDatabase {
  PokemonDao get pokemonDao;
}
