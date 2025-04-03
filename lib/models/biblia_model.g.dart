// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'biblia_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Biblia _$BibliaFromJson(Map<String, dynamic> json) => Biblia(
      libros: (json['libros'] as List<dynamic>)
          .map((e) => Libro.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BibliaToJson(Biblia instance) => <String, dynamic>{
      'libros': instance.libros,
    };

Libro _$LibroFromJson(Map<String, dynamic> json) => Libro(
      bookName: json['bookName'] as String,
      book: (json['book'] as num).toInt(),
      chapters: (json['chapters'] as List<dynamic>)
          .map((e) => Chapter.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LibroToJson(Libro instance) => <String, dynamic>{
      'bookName': instance.bookName,
      'book': instance.book,
      'chapters': instance.chapters,
    };

Chapter _$ChapterFromJson(Map<String, dynamic> json) => Chapter(
      chapter: (json['chapter'] as num).toInt(),
      verses: (json['verses'] as List<dynamic>)
          .map((e) => Verse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChapterToJson(Chapter instance) => <String, dynamic>{
      'chapter': instance.chapter,
      'verses': instance.verses,
    };

Verse _$VerseFromJson(Map<String, dynamic> json) => Verse(
      verse: (json['verse'] as num).toInt(),
      text: json['text'] as String,
    );

Map<String, dynamic> _$VerseToJson(Verse instance) => <String, dynamic>{
      'verse': instance.verse,
      'text': instance.text,
    };
