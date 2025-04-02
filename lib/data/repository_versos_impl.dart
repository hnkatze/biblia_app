import 'package:biblia_meno/data/biblia.dart';
import 'package:biblia_meno/data/repository_versos.dart';
import 'package:biblia_meno/models/biblia_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



final repositoryVersosProvider = Provider<RepositoryVersos>((ref) {
  return RepositoryVersosImpl();
});

class RepositoryVersosImpl extends RepositoryVersos {
  
@override
 Future<List<Libro>> getSomesBooks() async {
  return biblia;
 }
 
@override
  Future<String> getRamdomVerse() async {
  final random = biblia.expand((libro) => libro.capitulos.expand((capitulo) => capitulo.versiculos)).toList();
  if (random.isEmpty) {
    return "No verses available";
  }
  final randomVerse = (random..shuffle()).first;
  return randomVerse.texto;
}
 
}
