import 'dart:convert';

import 'package:biblia_meno/data/repository_versos.dart';
import 'package:biblia_meno/models/biblia_model.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final repositoryVersosProvider = Provider<RepositoryVersos>((ref) {
  return RepositoryVersosImpl();
});

class RepositoryVersosImpl extends RepositoryVersos {
  Future<Biblia> _loadBiblia() async {
    final jsonString = await rootBundle.loadString('assets/biblia.json');
    final jsonData = json.decode(jsonString);
    return Biblia.fromJson(jsonData); // Convertir a objeto Biblia
  }

  @override
  Future<Biblia> getSomesBooks() async {
    final biblia = await _loadBiblia();
    return biblia; // Ya viene estructurado correctamente
  }
}
