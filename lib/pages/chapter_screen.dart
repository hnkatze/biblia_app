import 'package:biblia_meno/models/biblia_model.dart';
import 'package:biblia_meno/providers/biblia_provider.dart';
import 'package:biblia_meno/providers/verse_provider.dart';
import 'package:biblia_meno/widgets/reading_mode_screen.dart';
import 'package:biblia_meno/widgets/verse_card.dart';
import 'package:biblia_meno/widgets/verse_search_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChapterScreen extends ConsumerStatefulWidget {
  const ChapterScreen({super.key});

  @override
  ConsumerState<ChapterScreen> createState() => _ChapterScreenState();
}

class _ChapterScreenState extends ConsumerState<ChapterScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Verse> filteredVerses = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_filterVerses);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterVerses() {
    final currentBook = ref.read(oneBookProvider);
    final currentChapter = ref.read(currentChapterProvider);

    final chapter = currentBook.chapters.firstWhere(
      (c) => c.chapter == currentChapter,
      orElse: () => Chapter(chapter: 0, verses: []),
    );

    if (_searchController.text.isEmpty) {
      setState(() {
        filteredVerses = chapter.verses;
        _isSearching = false;
      });
    } else {
      setState(() {
        filteredVerses = chapter.verses
            .where((verse) => verse.text
                .toLowerCase()
                .contains(_searchController.text.toLowerCase()))
            .toList();
        _isSearching = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentBook = ref.watch(oneBookProvider);
    final currentChapter = ref.watch(currentChapterProvider);

    final chapter = currentBook.chapters.firstWhere(
      (c) => c.chapter == currentChapter,
      orElse: () => Chapter(chapter: 0, verses: []),
    );

    final versesToDisplay = _isSearching ? filteredVerses : chapter.verses;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(currentBook.bookName),
            Text(
              'Capítulo $currentChapter',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: const Color.fromARGB(179, 0, 0, 0),
                  ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: VerseSearchDelegate(chapter.verses),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.format_size),
            onPressed: () {
              // Opción para cambiar tamaño de fuente
              _showTextSizeDialog(context);
            },
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final verse = versesToDisplay[index];
                return VerseCard(
                  verse: verse,
                  onTap: () {
                    // Acción al tocar un versículo
                    _showVerseOptions(context, verse);
                  },
                );
              },
              childCount: versesToDisplay.length,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.menu_book),
        onPressed: () {
          // Acción para modo lectura continua
          _openReadingMode(context, chapter.verses);
        },
      ),
    );
  }

  void _showTextSizeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Tamaño de texto'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Slider(
                value: ref.watch(textSizeProvider).toDouble(),
                min: 14,
                max: 24,
                divisions: 5,
                label: ref.watch(textSizeProvider).toString(),
                onChanged: (value) {
                  ref.read(textSizeProvider.notifier).state = value.toInt();
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  void _showVerseOptions(BuildContext context, Verse verse) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.share),
                title: const Text('Compartir versículo'),
                onTap: () {
                  Navigator.pop(context);
                  _shareVerse(verse);
                },
              ),
              ListTile(
                leading: const Icon(Icons.bookmark),
                title: const Text('Guardar en marcadores'),
                onTap: () {
                  Navigator.pop(context);
                  _saveBookmark(verse);
                },
              ),
              ListTile(
                leading: const Icon(Icons.note_add),
                title: const Text('Agregar nota'),
                onTap: () {
                  Navigator.pop(context);
                  _addNoteToVerse(verse);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _openReadingMode(BuildContext context, List<Verse> verses) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReadingModeScreen(verses: verses),
      ),
    );
  }

  // Métodos adicionales para las acciones
  void _shareVerse(Verse verse) {
    // Implementar compartir
  }

  void _saveBookmark(Verse verse) {
    // Implementar guardar marcador
  }

  void _addNoteToVerse(Verse verse) {
    // Implementar agregar nota
  }
}
