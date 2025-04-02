// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../data/verse_service.dart';
// import '../models/biblia_model.dart';

// final verseProvider = StateNotifierProvider<VerseNotifier, VerseState>((ref) {
//   final verseService = ref.read(verseServiceProvider);
//   return VerseNotifier(verseService: verseService);
// });

// final bookNamesProvider = FutureProvider<List<Verse>>((ref) async {
//   final verseService = ref.read(verseServiceProvider);
//   final books = await verseService.getBookNames();
//   return books.map((book) => Verse(
//     bookName: book['name'],
//     book: book['number'],
//   )).toList();
// });

// class VerseNotifier extends StateNotifier<VerseState> {
//   final VerseService verseService;

//   VerseNotifier({required this.verseService})
//       : super(VerseState(verses: [], isLoading: false, error: null));

//   Future<void> loadVerses() async {
//     try {
//       state = state.copyWith(isLoading: true, error: null);
//       final verses = await verseService.getVersos();
//       state = state.copyWith(verses: verses, isLoading: false);
//     } catch (e) {
//       state = state.copyWith(isLoading: false, error: e.toString());
//     }
//   }

//   Future<void> loadBookName() async {
//     try {
//       state = state.copyWith(isLoading: true, error: null);
//       final verses = await verseService.getVersos();
//       state = state.copyWith(verses: verses, isLoading: false);
//     } catch (e) {
//       state = state.copyWith(isLoading: false, error: e.toString());
//     }
//   }

//   Future<void> loadBookNames() async {
//     try {
//       state = state.copyWith(isLoading: true, error: null);
//       final books = await verseService.getBookNames();
//       final verses = books.map((book) => Verse(
//         bookName: book['name'],
//         book: book['number'],
//       )).toList();
//       state = state.copyWith(verses: verses, isLoading: false);
//     } catch (e) {
//       state = state.copyWith(isLoading: false, error: e.toString());
//     }
//   }

//   Future<void> loadVerse(int book, int chapter) async {
//     try {
//       state = state.copyWith(isLoading: true, error: null);
//       final verse = await verseService.getVerso(book, chapter);
//       state = state.copyWith(currentVerse: verse, isLoading: false);
//     } catch (e) {
//       state = state.copyWith(isLoading: false, error: e.toString());
//     }
//   }

//   Future<void> searchVerses(String query) async {
//     try {
//       state = state.copyWith(isLoading: true, error: null);
//       final verses = await verseService.findVerses(query);
//       state = state.copyWith(verses: verses, isLoading: false);
//     } catch (e) {
//       state = state.copyWith(isLoading: false, error: e.toString());
//     }
//   }

//   Future<void> loadRandomVerse() async {
//     try {
//       state = state.copyWith(isLoading: true, error: null);
//       final verse = await verseService.getRandomVerse();
//       state = state.copyWith(currentVerse: verse, isLoading: false);
//     } catch (e) {
//       state = state.copyWith(isLoading: false, error: e.toString());
//     }
//   }
// }
