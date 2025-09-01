import 'package:biblia_meno/models/biblia_model.dart';
import 'package:biblia_meno/providers/biblia_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomDrawer extends ConsumerWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookNamesAsync = ref.watch(bibliaProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return bookNamesAsync.when(
      data: (bookNames) {
        final oldTestament =
            bookNames.libros.where((book) => book.book <= 39).toList();
        final newTestament =
            bookNames.libros.where((book) => book.book > 39).toList();

        return Drawer(
          backgroundColor: colorScheme.surface,
          surfaceTintColor: Colors.transparent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(32),
              bottomRight: Radius.circular(32),
            ),
          ),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      colorScheme.primary,
                      colorScheme.primary.withAlpha(230),
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(20),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.menu_book_rounded,
                        size: 32,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'BIBLIOTECA',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Sagradas Escrituras',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontFamily: 'Georgia',
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _SectionHeader(
                      title: 'Antiguo Testamento',
                      icon: Icons.history_rounded,
                      colorScheme: colorScheme,
                    ),
                    ...oldTestament.map((book) => _BookTile(
                          book: book,
                          colorScheme: colorScheme,
                          onTap: () {
                            ref.read(oneBookProvider.notifier).setBook(book);
                            Navigator.pushNamed(context, '/book');
                          },
                        )),
                    const SizedBox(height: 16),
                    _SectionHeader(
                      title: 'Nuevo Testamento',
                      icon: Icons.new_releases_rounded,
                      colorScheme: colorScheme,
                    ),
                    ...newTestament.map((book) => _BookTile(
                          book: book,
                          colorScheme: colorScheme,
                          onTap: () {
                            ref.read(oneBookProvider.notifier).setBook(book);
                            Navigator.pushNamed(context, '/book');
                          },
                        )),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      loading: () => const _LoadingDrawer(),
      error: (error, stack) => _ErrorDrawer(error: error.toString()),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final IconData icon;
  final ColorScheme colorScheme;

  const _SectionHeader({
    required this.title,
    required this.icon,
    required this.colorScheme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: colorScheme.primary.withAlpha(100),
            width: 3,
          ),
        ),
      ),
      child: Row(
        children: [
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: colorScheme.primary.withAlpha(15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              size: 16,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: colorScheme.primary.withAlpha(200),
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _BookTile extends StatelessWidget {
  final Libro book;
  final ColorScheme colorScheme;
  final VoidCallback onTap;

  const _BookTile({
    required this.book,
    required this.colorScheme,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        colorScheme.primary.withAlpha(25),
                        colorScheme.secondary.withAlpha(15),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: colorScheme.primary.withAlpha(40),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    '${book.book}',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: colorScheme.primary,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    book.bookName,
                    style: TextStyle(
                      fontSize: 14,
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  size: 18,
                  color: colorScheme.onSurface.withAlpha(100),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoadingDrawer extends StatelessWidget {
  const _LoadingDrawer();

  @override
  Widget build(BuildContext context) {
    return const Drawer(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Cargando libros...'),
          ],
        ),
      ),
    );
  }
}

class _ErrorDrawer extends ConsumerWidget {
  final String error;

  const _ErrorDrawer({required this.error});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline_rounded,
                size: 40, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Error al cargar los libros',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              error,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => ref.refresh(bibliaProvider),
              child: const Text('Reintentar'),
            ),
          ],
        ),
      ),
    );
  }
}
