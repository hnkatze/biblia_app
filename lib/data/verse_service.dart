import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/biblia_model.dart';
import 'repository_versos_impl.dart';

// Define the verseServiceProvider
final verseServiceProvider = Provider<VerseService>((ref) {
  final repository = RepositoryVersosImpl();
  return VerseService(repositoryVersosImpl: repository);
});

final getSomesBookFutureProvider = FutureProvider<Biblia>((ref) async {
  final verseService = ref.read(verseServiceProvider);
  return await verseService.getSomesBooks();
});

class VerseService {
  final RepositoryVersosImpl repositoryVersosImpl;

  VerseService({required this.repositoryVersosImpl});

  Future<Biblia> getSomesBooks() async {
    return await repositoryVersosImpl.getSomesBooks();
  }
}
