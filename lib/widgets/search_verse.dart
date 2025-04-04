import 'package:biblia_meno/models/search_model.dart';
import 'package:biblia_meno/providers/biblia_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SearchVerse extends ConsumerWidget {
  const SearchVerse({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchResults = ref.watch(searchResultsProvider);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Buscar versículos...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            onChanged: (value) =>
                ref.read(searchQueryProvider.notifier).state = value,
          ),
        ),
        Expanded(
          child: searchResults.when(
            data: (results) => _SearchResultsList(results: results),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => Text('Error: $error'),
          ),
        ),
      ],
    );
  }
}

class _SearchResultsList extends StatelessWidget {
  final List<SearchResult> results;

  const _SearchResultsList({required this.results});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final result = results[index];
        return ListTile(
          title: Text(result.text),
          subtitle: Text(
            '${result.bookName} ${result.chapter}:${result.verseNumber}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                ),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          visualDensity: const VisualDensity(vertical: 2),
        );
      },
    );
  }
}
