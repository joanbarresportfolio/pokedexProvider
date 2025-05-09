import 'package:examen_ordinaria/converters.dart';
import 'package:floor/floor.dart';

@TypeConverters([StringListConverter, StatsMapConverter])
@entity
class Pokemon {
  @primaryKey
  final int id;
  final String nom;
  final String imatgeGran;
  final String imatgeMenuda;
  final int height;
  final int weight;
  final int baseExperience;

  @TypeConverters([StringListConverter])
  final List<String> types;

  @TypeConverters([StringListConverter])
  final List<String> abilities;

  @TypeConverters([StringListConverter])
  final List<String> moves;

  @TypeConverters([StatsMapConverter])
  final Map<String, int> stats;

  Pokemon({
    required this.id,
    required this.nom,
    required this.imatgeGran,
    required this.imatgeMenuda,
    required this.height,
    required this.weight,
    required this.baseExperience,
    required this.types,
    required this.abilities,
    required this.moves,
    required this.stats,
  });
}
