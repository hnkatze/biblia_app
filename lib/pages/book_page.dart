import 'package:biblia_meno/models/biblia_model.dart';
import 'package:biblia_meno/providers/biblia_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BookPage extends ConsumerWidget {
  const BookPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Libro book = ref.watch(oneBookProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${book.bookName} (Capítulos)',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
            color: colorScheme.onSurface,
          ),
        ),
        surfaceTintColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
            childAspectRatio: 1.0,
          ),
          itemCount: book.chapters.length,
          itemBuilder: (context, index) {
            final chapterNumber = index + 1;
            final isSelected =
                chapterNumber == ref.watch(currentChapterProvider);

            return Material(
              color: isSelected
                  ? colorScheme.primaryContainer
                  : colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12.0),
              child: InkWell(
                borderRadius: BorderRadius.circular(12.0),
                onTap: () {
                  ref.read(currentChapterProvider.notifier).state =
                      chapterNumber;
                  Navigator.pushNamed(context, '/chapter');
                },
                overlayColor: WidgetStateProperty.all(
                  colorScheme.onSurface.withAlpha((0.1 * 255).toInt()),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    border: isSelected
                        ? Border.all(
                            color: colorScheme.primary,
                            width: 2.0,
                          )
                        : null,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Center(
                    child: Text(
                      '$chapterNumber',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: isSelected
                            ? colorScheme.onPrimaryContainer
                            : colorScheme.onSurface,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
