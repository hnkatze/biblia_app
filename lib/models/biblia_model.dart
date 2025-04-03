import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'biblia_model.g.dart';

// biblia_model.g.dart

Biblia bibliaFromJson(String str) => Biblia.fromJson(json.decode(str));

String bibliaToJson(Biblia data) => json.encode(data.toJson());

@JsonSerializable()
class Biblia {
  List<Libro> libros;

  Biblia({
    required this.libros,
  });

  factory Biblia.fromJson(Map<String, dynamic> json) => Biblia(
        libros: List<Libro>.from(json["libros"].map((x) => Libro.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "libros": List<dynamic>.from(libros.map((x) => x.toJson())),
      };
}

@JsonSerializable()
class Libro {
  String bookName;
  int book;
  List<Chapter> chapters;

  Libro({
    required this.bookName,
    required this.book,
    required this.chapters,
  });

  factory Libro.fromJson(Map<String, dynamic> json) => Libro(
        bookName: json["book_name"],
        book: json["book"],
        chapters: List<Chapter>.from(
            json["chapters"].map((x) => Chapter.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "book_name": bookName,
        "book": book,
        "chapters": List<dynamic>.from(chapters.map((x) => x.toJson())),
      };
}

@JsonSerializable()
class Chapter {
  int chapter;
  List<Verse> verses;

  Chapter({
    required this.chapter,
    required this.verses,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
        chapter: json["chapter"],
        verses: List<Verse>.from(json["verses"].map((x) => Verse.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "chapter": chapter,
        "verses": List<dynamic>.from(verses.map((x) => x.toJson())),
      };
}

@JsonSerializable()
class Verse {
  int verse;
  String text;

  Verse({
    required this.verse,
    required this.text,
  });

  factory Verse.fromJson(Map<String, dynamic> json) => Verse(
        verse: json["verse"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "verse": verse,
        "text": text,
      };
}
