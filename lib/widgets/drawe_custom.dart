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
    final textTheme = Theme.of(context).textTheme;

    return bookNamesAsync.when(
      data: (bookNames) {
        final oldTestament =
            bookNames.libros.where((book) => book.book <= 39).toList();
        final newTestament =
            bookNames.libros.where((book) => book.book > 39).toList();

        return Drawer(
          surfaceTintColor: colorScheme.surface,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      Icons.menu_book_rounded,
                      size: 40,
                      color: colorScheme.onPrimaryContainer,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Libros de la Biblia',
                      style: textTheme.titleLarge?.copyWith(
                        color: colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.w600,
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon, size: 20, color: colorScheme.primary),
          const SizedBox(width: 12),
          Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: colorScheme.primary,
              letterSpacing: 1.2,
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
    return Material(
      color: Colors.transparent,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        leading: Container(
          width: 32,
          height: 32,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: colorScheme.primary.withAlpha((0.1 * 255).toInt()),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '${book.book}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: colorScheme.primary,
            ),
          ),
        ),
        title: Text(
          book.bookName,
          style: TextStyle(
            fontSize: 15,
            color: colorScheme.onSurface,
            fontWeight: FontWeight.w500,
          ),
        ),
        minLeadingWidth: 24,
        dense: true,
        visualDensity: const VisualDensity(vertical: -2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        onTap: onTap,
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
