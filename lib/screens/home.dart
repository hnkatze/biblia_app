import 'package:biblia_meno/models/biblia_model.dart';
import 'package:biblia_meno/widgets/drawe_custom.dart';
import 'package:biblia_meno/widgets/search_verse.dart';
import 'package:biblia_meno/widgets/verse_search_delegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/verse_to_day.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        title: const Text('Biblia Menonita'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: VerseSearchDelegate(ref.read as List<Verse>),
              );
            },
          ),
        ],
      ),
      drawer: const CustomDrawer(),
      body: const Column(
        children: [
          VerseToDay(),
          Expanded(child: SearchVerse()),
        ],
      ),
    );
  }
}
