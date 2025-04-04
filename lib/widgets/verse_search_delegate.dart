import 'package:biblia_meno/models/biblia_model.dart';
import 'package:flutter/material.dart';

class VerseSearchDelegate extends SearchDelegate<Verse?> {
  final List<Verse> verses;

  VerseSearchDelegate(this.verses);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        // Solo cierra el buscador, no la pantalla principal
        close(context, null); // Close with no selected verse
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildSearchResults();
  }

  Widget _buildSearchResults() {
    final results = verses
        .where(
            (verse) => verse.text.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final verse = results[index];
        return ListTile(
          title: Text('${verse.verse}. ${verse.text}'),
          onTap: () {
            close(context, verse);
          },
        );
      },
    );
  }
}
