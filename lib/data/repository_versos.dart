

import 'package:biblia_meno/models/biblia_model.dart';

abstract class RepositoryVersos {
 Future<List<Libro>> getSomesBooks();
 Future<String> getRamdomVerse();
}
