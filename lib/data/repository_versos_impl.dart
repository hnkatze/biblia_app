import 'dart:math';
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

  @override
  Future<String> getRamdomVerse() async {
    final biblia = await _loadBiblia();
    final random = Random();

    // Obtener libro aleatorio
    final libro = biblia.libros[random.nextInt(biblia.libros.length)];

    // Obtener capítulo aleatorio
    final capitulo = libro.chapters[random.nextInt(libro.chapters.length)];

    // Obtener versículo aleatorio
    final versiculo = capitulo.verses[random.nextInt(capitulo.verses.length)];

    return versiculo.text;
  }

  @override
  Future<Libro> getOneBook(int bookNumber) async {
    final biblia = await _loadBiblia();
    final libro = biblia.libros.firstWhere((libro) => libro.book == bookNumber);
    return libro;
  }
}
