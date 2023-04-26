import 'package:flutter/material.dart';

class SearchBar extends SearchDelegate<String?> {
  @override
  List<Widget> buildActions(BuildContext context) {
    // Actions pour la barre de recherche
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
    // Retourner un bouton pour revenir en arrière
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Afficher les résultats de la recherche
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Suggestions pendant que l'utilisateur tape
    return Container();
  }
}
