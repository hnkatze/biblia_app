import 'dart:math';

import 'package:biblia_meno/data/repository_versos_impl.dart';
import 'package:biblia_meno/models/search_model.dart';
import 'package:biblia_meno/models/verse_details.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:biblia_meno/models/biblia_model.dart';

// 1. Provider de inicialización
final initializationProvider = FutureProvider<void>((ref) async {
  await ref.read(repositoryVersosProvider).getSomesBooks();
});

// 2. Provider de estado principal
final bibliaProvider =
    StateNotifierProvider<BibliaNotifier, AsyncValue<Biblia>>(
  (ref) => BibliaNotifier(ref),
);

class BibliaNotifier extends StateNotifier<AsyncValue<Biblia>> {
  final Ref ref;

  BibliaNotifier(this.ref) : super(const AsyncValue.loading()) {
    _initialize();
  }

  Future<void> _initialize() async {
    try {
      final biblia = await ref.read(repositoryVersosProvider).getSomesBooks();
      state = AsyncValue.data(biblia);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}

// 3. Provider para versículos aleatorios
final randomVerseProvider = StateProvider<VerseDetail>((ref) {
  final biblia = ref.watch(bibliaProvider).maybeWhen(
        data: (biblia) => biblia,
        orElse: () => Biblia(libros: []),
      );
  return _generateRandomVerse(biblia);
});

VerseDetail _generateRandomVerse(Biblia biblia) {
  if (biblia.libros.isEmpty) {
    return VerseDetail(
      bookName: "Cargando...",
      bookNumber: 0,
      chapter: 0,
      verseNumber: 0,
      text: "Cargando versículo...",
    );
  }

  final random = Random();
  final libro = biblia.libros[random.nextInt(biblia.libros.length)];
  final capitulo = libro.chapters[random.nextInt(libro.chapters.length)];
  final versiculo = capitulo.verses.isNotEmpty
      ? capitulo.verses[random.nextInt(capitulo.verses.length)]
      : Verse(verse: 0, text: "No hay versículos disponibles");

  return VerseDetail(
    bookName: libro.bookName,
    bookNumber: libro.book,
    chapter: capitulo.chapter,
    verseNumber: versiculo.verse,
    text: versiculo.text,
  );
}

// 4. Provider combinado para UI
final appStateProvider = Provider<AsyncValue<void>>((ref) {
  return ref.watch(initializationProvider);
});

class AppState {
  final bool isLoading;
  final Object? error;
  final bool hasData;

  AppState({
    required this.isLoading,
    this.error,
    required this.hasData,
  });
}

// 5. Provider para un solo libro
final oneBookProvider = StateNotifierProvider<OneBookProvider, Libro>(
  (ref) => OneBookProvider(),
);

final currentChapterProvider = StateProvider<int>((ref) => 1);

class OneBookProvider extends StateNotifier<Libro> {
  OneBookProvider() : super(Libro(book: 0, bookName: '', chapters: []));

  void setBook(Libro libro) {
    state = libro;
  }
}

// Provider para el texto de búsqueda
final searchQueryProvider = StateProvider<String>((ref) => '');

// Provider para los resultados filtrados
final searchResultsProvider = FutureProvider<List<SearchResult>>((ref) async {
  final query = ref.watch(searchQueryProvider);
  final biblia = ref.watch(bibliaProvider).maybeWhen(
        data: (biblia) => biblia,
        orElse: () => Biblia(libros: []),
      );

  return _performSearch(query, biblia);
});

Future<List<SearchResult>> _performSearch(String query, Biblia biblia) async {
  if (query.isEmpty) return [];

  final results = <SearchResult>[];
  final searchLower = query.toLowerCase();

  for (final libro in biblia.libros) {
    for (final capitulo in libro.chapters) {
      for (final versiculo in capitulo.verses) {
        if (versiculo.text.toLowerCase().contains(searchLower)) {
          results.add(SearchResult(
            bookName: libro.bookName,
            bookNumber: libro.book,
            chapter: capitulo.chapter,
            verseNumber: versiculo.verse,
            text: versiculo.text,
          ));
        }
      }
    }
  }

  return results;
}
