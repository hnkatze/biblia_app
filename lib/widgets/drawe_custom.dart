import 'package:biblia_meno/data/verse_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomDrawer extends ConsumerWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookNamesAsync = ref.watch(getSomesBookFutureProvider);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Libros de la Biblia',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          bookNamesAsync.when(
            data: (books) => ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: books.libros.length,
              itemBuilder: (context, index) {
                final book = books.libros[index];
                return ListTile(
                  title: Text('${book.book}. ${book.bookName}'),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/book',
                      arguments: {
                        'book': book,
                      },
                    );
                  },
                );
              },
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => Center(child: Text('Error: $error')),
          ),
        ],
      ),
    );
  }
}
