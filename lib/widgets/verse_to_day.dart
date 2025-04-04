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

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 3,
        color: colorScheme.surfaceContainerHigh,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: colorScheme.outlineVariant.withOpacity(0.3),
            width: 1,
          ),
        ),
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
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(Icons.format_quote_rounded,
                  color: colorScheme.primary.withAlpha((0.5 * 255).toInt()),
                  size: 32),
              const Spacer(),
              Text(
                'Versículo del día',
                style: textTheme.titleMedium?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            '${verse.bookName} ${verse.chapter}:${verse.verseNumber}',
            style: textTheme.titleSmall?.copyWith(
              color: colorScheme.onSurface.withAlpha((0.8 * 255).toInt()),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            verse.text,
            textAlign: TextAlign.center,
            style: textTheme.bodyLarge?.copyWith(
              fontSize: 20,
              fontStyle: FontStyle.italic,
              height: 1.4,
              letterSpacing: 0.3,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 24),
          Icon(
            Icons.format_quote_rounded,
            color: colorScheme.primary.withAlpha((0.5 * 255).toInt()),
            size: 32,
            textDirection: TextDirection.rtl,
          ),
          const SizedBox(height: 16),
          FilledButton.tonalIcon(
            onPressed: () => ref.refresh(randomVerseProvider),
            icon: const Icon(Icons.refresh_rounded),
            label: const Text('Nuevo versículo'),
          ),
        ],
      ),
    );
  }
}
