import 'package:biblia_meno/models/biblia_model.dart';
import 'package:biblia_meno/providers/verse_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VerseCard extends ConsumerWidget {
  final Verse verse;
  final VoidCallback onTap;

  const VerseCard({
    super.key,
    required this.verse,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textSize = ref.watch(textSizeProvider);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: textSize.toDouble(),
                color: Colors.black,
                height: 1.5,
              ),
              children: [
                TextSpan(
                  text: '${verse.verse}. ',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                TextSpan(text: verse.text),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
