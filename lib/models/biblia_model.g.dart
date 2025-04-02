// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'biblia_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Libro _$LibroFromJson(Map<String, dynamic> json) => Libro(
      nombre: json['nombre'] as String,
      numero: (json['numero'] as num).toInt(),
      capitulos: (json['capitulos'] as List<dynamic>)
          .map((e) => Capitulo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LibroToJson(Libro instance) => <String, dynamic>{
      'nombre': instance.nombre,
      'numero': instance.numero,
      'capitulos': instance.capitulos,
    };

Capitulo _$CapituloFromJson(Map<String, dynamic> json) => Capitulo(
      capitulo: (json['capitulo'] as num).toInt(),
      versiculos: (json['versiculos'] as List<dynamic>)
          .map((e) => Versiculo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CapituloToJson(Capitulo instance) => <String, dynamic>{
      'capitulo': instance.capitulo,
      'versiculos': instance.versiculos,
    };

Versiculo _$VersiculoFromJson(Map<String, dynamic> json) => Versiculo(
      versiculo: (json['versiculo'] as num).toInt(),
      texto: json['texto'] as String,
    );

Map<String, dynamic> _$VersiculoToJson(Versiculo instance) => <String, dynamic>{
      'versiculo': instance.versiculo,
      'texto': instance.texto,
    };
