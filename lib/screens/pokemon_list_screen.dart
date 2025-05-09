import 'package:examen_ordinaria/model/pokemon.dart';
import 'package:examen_ordinaria/provider/pokemon_provider.dart';
import 'package:examen_ordinaria/provider/team_provider.dart';
import 'package:examen_ordinaria/screens/pokemon_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class PokemonListScreen extends StatefulWidget {
  const PokemonListScreen({super.key});

  @override
  State<PokemonListScreen> createState() => _PokemonListScreenState();
}

class _PokemonListScreenState extends State<PokemonListScreen> {
  // Para controlar el índice del ítem que está siendo "hovered"
  int? _hoveredIndex;

  @override
  Widget build(BuildContext context) {
    var pokemonList = Provider.of<PokemonProvider>(context).pokemons;
    var teamProvider = Provider.of<FavoritProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Pokedex',
          style: GoogleFonts.poppins(),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: StreamBuilder<List<Pokemon>>(
        stream: teamProvider.findAll(),
        builder: (context, snapshot) {
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: pokemonList.length,
            itemBuilder: (BuildContext context, int index) {
              final pokemon = pokemonList[index];
              final isHovered = _hoveredIndex == index;

              return MouseRegion(
                onEnter: (_) => setState(() => _hoveredIndex = index),
                onExit: (_) => setState(() => _hoveredIndex = null),
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    teamProvider.insertPokemon(pokemon);

                    // Mostrar un SnackBar cuando se añade un Pokémon al equipo
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${pokemon.nom} se ha añadido al equipo'),
                        duration: const Duration(seconds: 2),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  onDoubleTap: () => teamProvider.deletePokemon(pokemon),
                  child: Card(
                    color: isHovered
                        ? const Color(0xFFF0F0F0)
                        : const Color.fromARGB(255, 255, 255, 255),
                    elevation: isHovered ? 4 : 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      leading: Image.network(
                        pokemon.imatgeMenuda,
                        width: 50,
                        height: 50,
                      ),
                      title: Text(
                        pokemon.nom.toUpperCase(),
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.arrow_forward_ios),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PokemonDetailScreen(pokemon: pokemon),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
