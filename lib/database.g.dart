// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppPokemonsDBBuilderContract {
  /// Adds migrations to the builder.
  $AppPokemonsDBBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppPokemonsDBBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppPokemonsDB> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppPokemonsDB {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppPokemonsDBBuilderContract databaseBuilder(String name) =>
      _$AppPokemonsDBBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppPokemonsDBBuilderContract inMemoryDatabaseBuilder() =>
      _$AppPokemonsDBBuilder(null);
}

class _$AppPokemonsDBBuilder implements $AppPokemonsDBBuilderContract {
  _$AppPokemonsDBBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppPokemonsDBBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppPokemonsDBBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppPokemonsDB> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppPokemonsDB();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppPokemonsDB extends AppPokemonsDB {
  _$AppPokemonsDB([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  PokemonDao? _pokemonDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Pokemon` (`id` INTEGER NOT NULL, `nom` TEXT NOT NULL, `imatgeGran` TEXT NOT NULL, `imatgeMenuda` TEXT NOT NULL, `height` INTEGER NOT NULL, `weight` INTEGER NOT NULL, `baseExperience` INTEGER NOT NULL, `types` TEXT NOT NULL, `abilities` TEXT NOT NULL, `moves` TEXT NOT NULL, `stats` TEXT NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  PokemonDao get pokemonDao {
    return _pokemonDaoInstance ??= _$PokemonDao(database, changeListener);
  }
}

class _$PokemonDao extends PokemonDao {
  _$PokemonDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _pokemonInsertionAdapter = InsertionAdapter(
            database,
            'Pokemon',
            (Pokemon item) => <String, Object?>{
                  'id': item.id,
                  'nom': item.nom,
                  'imatgeGran': item.imatgeGran,
                  'imatgeMenuda': item.imatgeMenuda,
                  'height': item.height,
                  'weight': item.weight,
                  'baseExperience': item.baseExperience,
                  'types': _stringListConverter.encode(item.types),
                  'abilities': _stringListConverter.encode(item.abilities),
                  'moves': _stringListConverter.encode(item.moves),
                  'stats': _statsMapConverter.encode(item.stats)
                },
            changeListener),
        _pokemonDeletionAdapter = DeletionAdapter(
            database,
            'Pokemon',
            ['id'],
            (Pokemon item) => <String, Object?>{
                  'id': item.id,
                  'nom': item.nom,
                  'imatgeGran': item.imatgeGran,
                  'imatgeMenuda': item.imatgeMenuda,
                  'height': item.height,
                  'weight': item.weight,
                  'baseExperience': item.baseExperience,
                  'types': _stringListConverter.encode(item.types),
                  'abilities': _stringListConverter.encode(item.abilities),
                  'moves': _stringListConverter.encode(item.moves),
                  'stats': _statsMapConverter.encode(item.stats)
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Pokemon> _pokemonInsertionAdapter;

  final DeletionAdapter<Pokemon> _pokemonDeletionAdapter;

  @override
  Stream<List<Pokemon>> findAll() {
    return _queryAdapter.queryListStream('SELECT * FROM Pokemon',
        mapper: (Map<String, Object?> row) => Pokemon(
            id: row['id'] as int,
            nom: row['nom'] as String,
            imatgeGran: row['imatgeGran'] as String,
            imatgeMenuda: row['imatgeMenuda'] as String,
            height: row['height'] as int,
            weight: row['weight'] as int,
            baseExperience: row['baseExperience'] as int,
            types: _stringListConverter.decode(row['types'] as String),
            abilities: _stringListConverter.decode(row['abilities'] as String),
            moves: _stringListConverter.decode(row['moves'] as String),
            stats: _statsMapConverter.decode(row['stats'] as String)),
        queryableName: 'Pokemon',
        isView: false);
  }

  @override
  Future<void> insertPokemon(Pokemon pokemon) async {
    await _pokemonInsertionAdapter.insert(pokemon, OnConflictStrategy.abort);
  }

  @override
  Future<void> deletePokemon(Pokemon pokemon) async {
    await _pokemonDeletionAdapter.delete(pokemon);
  }
}

// ignore_for_file: unused_element
final _stringListConverter = StringListConverter();
final _statsMapConverter = StatsMapConverter();
