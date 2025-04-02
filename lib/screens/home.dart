import 'package:biblia_meno/providers/verse_provider.dart';
import 'package:biblia_meno/widgets/drawe_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/verse_to_day.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

void intiState(){

}
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: const Text('Biblia'),
      ),
      drawer: const  CustomDrawer(),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            VerseToDay(),
          ],
        ),
      ),
    );
  }
}
