import 'package:examen_ordinaria/provider/pokemon_provider.dart';
import 'package:examen_ordinaria/provider/team_provider.dart';
import 'package:examen_ordinaria/screens/pokemon_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PokemonTeamScreen extends StatelessWidget {
  const PokemonTeamScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final stream = Provider.of<FavoritProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Tu equipo pokemon',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: StreamBuilder(
        stream: stream.findAll(),
        initialData: const [],
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData || snapshot.data.isEmpty) {
            return Center(
              child: Text(
                'No tienes pokemons en tu equipo.',
                style: GoogleFonts.poppins(fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              final pokemon = snapshot.data[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Card(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: Image.network(pokemon.imatgeMenuda),
                    title: Text(
                      pokemon.nom,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: () {
                        // Eliminar el Pokémon y mostrar un SnackBar
                        stream.deletePokemon(pokemon);

                        // Mostrar un SnackBar informando que el Pokémon fue eliminado
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${pokemon.nom} ha sido eliminado'),
                            duration: const Duration(seconds: 2),
                            backgroundColor: Colors.red,
                          ),
                        );
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PokemonDetailScreen(
                            pokemon: pokemon,
                          ),
                        ),
                      );
                    },
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
