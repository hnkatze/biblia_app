import 'package:biblia_meno/models/verse_details.dart';
import 'package:biblia_meno/providers/biblia_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VerseToDay extends ConsumerWidget {
  const VerseToDay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final verseState = ref.watch(randomVerseProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.fromLTRB(20, 12, 20, 8),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colorScheme.primary.withAlpha(8),
            colorScheme.secondary.withAlpha(5),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: colorScheme.primary.withAlpha(30),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withAlpha(10),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(24),
        child: _VerseContent(verse: verseState),
      ),
    );
  }
}

class _VerseContent extends ConsumerWidget {
  final VerseDetail verse;

  const _VerseContent({required this.verse});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            decoration: BoxDecoration(
              color: colorScheme.primary.withAlpha(12),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: colorScheme.primary.withAlpha(40),
                width: 1,
              ),
            ),
            child: Text(
              'MEDITACIÓN DIARIA',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 2,
                color: colorScheme.primary,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: 40,
            height: 3,
            decoration: BoxDecoration(
              color: colorScheme.secondary.withAlpha(100),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            verse.text,
            textAlign: TextAlign.center,
            style: textTheme.bodyLarge?.copyWith(
              fontSize: 18,
              height: 1.8,
              letterSpacing: 0.2,
              color: colorScheme.onSurface,
              fontFamily: 'Georgia',
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: 40,
            height: 3,
            decoration: BoxDecoration(
              color: colorScheme.secondary.withAlpha(100),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.menu_book_rounded,
                size: 16,
                color: colorScheme.primary.withAlpha(150),
              ),
              const SizedBox(width: 8),
              Text(
                '${verse.bookName} ${verse.chapter}:${verse.verseNumber}',
                style: textTheme.titleSmall?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () => ref.refresh(randomVerseProvider),
                icon: Icon(
                  Icons.auto_awesome_rounded,
                  size: 18,
                  color: colorScheme.primary,
                ),
                label: Text(
                  'Nuevo versículo',
                  style: TextStyle(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                      color: colorScheme.primary.withAlpha(50),
                      width: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
