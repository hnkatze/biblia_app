// Pantalla de modo lectura
import 'package:biblia_meno/models/biblia_model.dart';
import 'package:flutter/material.dart';

class ReadingModeScreen extends StatelessWidget {
  final List<Verse> verses;

  const ReadingModeScreen({super.key, required this.verses});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modo Lectura'),
      ),
      body: PageView.builder(
        itemCount: verses.length,
        itemBuilder: (context, index) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${verses[index].verse}',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                        fontSize: 40.0),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    verses[index].text,
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
