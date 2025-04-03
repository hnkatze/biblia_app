import 'package:biblia_meno/models/biblia_model.dart';

abstract class RepositoryVersos {
  Future<Biblia> getSomesBooks();
  Future<String> getRamdomVerse();
  Future<Libro> getOneBook(int bookNumber);
}
