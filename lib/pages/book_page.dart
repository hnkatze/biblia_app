import 'package:flutter/material.dart';

class BookPage extends StatelessWidget {
  const BookPage({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as Map;
    final bookNumber = arguments['bookNumber'];
    final bookName = arguments['bookName'];

    return Scaffold(
      appBar: AppBar(
        title: Text(bookName),
      ),
      body: Center(
        child: Text('Mostrando capítulos o versos del libro $bookName ($bookNumber)'),
      ),
    );
  }
}
