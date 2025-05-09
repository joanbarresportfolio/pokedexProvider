import 'package:examen_ordinaria/model/pokemon.dart';
import 'package:examen_ordinaria/repository/team_repository.dart';
import 'package:flutter/foundation.dart';

class FavoritProvider with ChangeNotifier {
  final FavoritRepository _repository = FavoritRepository();
  // Llista de favorits per a la càrrega inicial
  // Ens servirà per emetre la primera notificació de canvi d'estat
  List<Pokemon> _favorits = [];

  FavoritProvider() {
    // En el constructor fem una càrrega dels favorits
    _carregaFavorits();
  }

  Future<void> _carregaFavorits() async {
    // Esperem a tindre una connexió llesta a la BD
    await _repository.connectaDB();

    // Obtenim el primer element de l'Stream que obtenim amb un findall

    final llistaFavorits = await _repository.findAll().first;
    _favorits = llistaFavorits;
    notifyListeners();
  }

  Stream<List<Pokemon>>? findAll() {
    return _repository.findAll();
  }

  Future<void> insertPokemon(Pokemon pokemon) async {
    await _repository.insertPlanet(pokemon);
    notifyListeners();
  }

  Future<void> deletePokemon(Pokemon pokemon) async {
    await _repository.deletePlanet(pokemon);
    notifyListeners();
  }
}
