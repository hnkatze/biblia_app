import 'package:biblia_meno/data/verse_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class VerseToDay extends ConsumerStatefulWidget {
  const VerseToDay({super.key});

  @override
  ConsumerState<VerseToDay> createState() => _VerseToDayState();
}

class _VerseToDayState extends ConsumerState<VerseToDay> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(getRamdomVerseFutureProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    final verseState = ref.watch(getRamdomVerseFutureProvider);

    return Center(
      child: verseState.when(
        loading: () => const CircularProgressIndicator(),
        error: (error, stack) => const Text('Error al cargar el versículo.'),
        data: (verse) => verse == null
            ? const Text('No se encontró un versículo.')
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        verse,
                        textAlign: TextAlign.justify,
                        style: const TextStyle(fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
