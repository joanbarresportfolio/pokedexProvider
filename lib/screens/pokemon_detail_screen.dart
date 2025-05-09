import 'package:flutter/material.dart';
import 'package:examen_ordinaria/model/pokemon.dart';
import 'package:google_fonts/google_fonts.dart';

class PokemonDetailScreen extends StatelessWidget {
  final Pokemon pokemon;

  const PokemonDetailScreen({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Fondo blanco
      appBar: AppBar(
        title: Text(pokemon.nom.toUpperCase()),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Imagen principal
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                pokemon.imatgeGran,
                height: 200,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 20),

            // Nombre
            Text(
              pokemon.nom.toUpperCase(),
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Información general
            Wrap(
              spacing: 20,
              runSpacing: 10,
              alignment: WrapAlignment.center,
              children: [
                InfoTile(title: 'ID', value: '${pokemon.id}'),
                InfoTile(title: 'Altura', value: '${pokemon.height} dm'),
                InfoTile(title: 'Peso', value: '${pokemon.weight} hg'),
                InfoTile(title: 'Exp.', value: '${pokemon.baseExperience}'),
              ],
            ),
            const SizedBox(height: 30),

            // Tipos
            SectionTitle(title: 'Tipos'),
            SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: WrapAlignment.center,
              children: pokemon.types
                  .map((type) => Chip(
                        label: Text(type),
                        backgroundColor:
                            const Color.fromARGB(255, 241, 241, 241),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 30),

            // Habilidades
            SectionTitle(title: 'Habilidades'),
            SizedBox(height: 10),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: WrapAlignment.center,
              children: pokemon.abilities
                  .map((ability) => Chip(
                        label: Text(ability),
                        backgroundColor:
                            const Color.fromARGB(255, 241, 241, 241),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 30),

            // Estadísticas
            SectionTitle(title: 'Estadísticas'),
            SizedBox(height: 10),
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1.7,
              children: pokemon.stats.entries.take(6).map((entry) {
                return StatBox(label: entry.key, value: entry.value.toString());
              }).toList(),
            ),
            const SizedBox(height: 30),

            // Movimientos
            SectionTitle(title: 'Movimientos'),
            SizedBox(height: 10),
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 2,
              children: pokemon.moves.take(6).map((move) {
                return StatBox(label: move, value: '');
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoTile extends StatelessWidget {
  final String title;
  final String value;

  const InfoTile({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Text(title, style: GoogleFonts.poppins(color: Colors.grey)),
      ],
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class StatBox extends StatelessWidget {
  final String label;
  final String value;

  const StatBox({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade100,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label.toUpperCase(),
            style:
                GoogleFonts.poppins(fontWeight: FontWeight.w500, fontSize: 14),
            textAlign: TextAlign.center,
          ),
          if (value.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              value,
              style: GoogleFonts.poppins(
                  fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ]
        ],
      ),
    );
  }
}
