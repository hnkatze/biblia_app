import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
part 'biblia_model.g.dart';





@JsonSerializable()
class Libro {
    String nombre;
    int numero;
    List<Capitulo> capitulos;

    Libro({
        required this.nombre,
        required this.numero,
        required this.capitulos,
    });

    factory Libro.fromJson(Map<String, dynamic> json) => Libro(
        nombre: json["nombre"],
        numero: json["numero"],
        capitulos: List<Capitulo>.from(json["capitulos"].map((x) => Capitulo.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "numero": numero,
        "capitulos": List<dynamic>.from(capitulos.map((x) => x.toJson())),
    };
}
@JsonSerializable()
class Capitulo {
    int capitulo;
    List<Versiculo> versiculos;

    Capitulo({
        required this.capitulo,
        required this.versiculos,
    });

    factory Capitulo.fromJson(Map<String, dynamic> json) => Capitulo(
        capitulo: json["capitulo"],
        versiculos: List<Versiculo>.from(json["versiculos"].map((x) => Versiculo.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "capitulo": capitulo,
        "versiculos": List<dynamic>.from(versiculos.map((x) => x.toJson())),
    };
}
@JsonSerializable()
class Versiculo {
    int versiculo;
    String texto;

    Versiculo({
        required this.versiculo,
        required this.texto,
    });

    factory Versiculo.fromJson(Map<String, dynamic> json) => Versiculo(
        versiculo: json["versiculo"],
        texto: json["texto"],
    );

    Map<String, dynamic> toJson() => {
        "versiculo": versiculo,
        "texto": texto,
    };
}

enum BookName {
    ABDAS,
    AMS,
    CANCIN_DE_CANCIONES,
    COLOSENSES,
    DANIEL,
    DEUTERONOMIO,
    ECCLESIASTS,
    EFESIOS,
    ESDRAS,
    ESTHER,
    EZEQUIEL,
    FILEMN,
    FILIPENSES,
    GLATAS,
    GNESIS,
    HABACUC,
    HAGGEO,
    HEBREOS,
    HECHOS,
    ISAAS,
    JEREMAS,
    JOB,
    JOEL,
    JONS,
    JOSU,
    JUAN,
    JUDAS,
    JUECES,
    LAMENTACIONES,
    LEVTICO,
    LUCAS,
    MALAQUAS,
    MARCOS,
    MATEO,
    MIQUEAS,
    NAHUM,
    NEHEMAS,
    NMEROS,
    OSEAS,
    PROVERBIOS,
    REVELACIN,
    ROMANOS,
    RUT,
    SALMOS,
    SANTIAGO,
    SOFONAS,
    THE_1_CORINTIOS,
    THE_1_CRNICAS,
    THE_1_JUAN,
    THE_1_PEDRO,
    THE_1_REYES,
    THE_1_SAMUEL,
    THE_1_TESALONICENSES,
    THE_1_TIMOTEO,
    THE_2_CORINTIOS,
    THE_2_CRNICAS,
    THE_2_JUAN,
    THE_2_PEDRO,
    THE_2_REYES,
    THE_2_SAMUEL,
    THE_2_TESALONICENSES,
    THE_2_TIMOTEO,
    THE_3_JUAN,
    TITO,
    XODO,
    ZACARAS
}

final bookNameValues = EnumValues({
    "Abdías": BookName.ABDAS,
    "Amós": BookName.AMS,
    "Canción de canciones": BookName.CANCIN_DE_CANCIONES,
    "Colosenses": BookName.COLOSENSES,
    "Daniel": BookName.DANIEL,
    "Deuteronomio": BookName.DEUTERONOMIO,
    "Ecclesiastés": BookName.ECCLESIASTS,
    "Efesios": BookName.EFESIOS,
    "Esdras": BookName.ESDRAS,
    "Esther": BookName.ESTHER,
    "Ezequiel": BookName.EZEQUIEL,
    "Filemón": BookName.FILEMN,
    "Filipenses": BookName.FILIPENSES,
    "Gálatas": BookName.GLATAS,
    "Génesis": BookName.GNESIS,
    "Habacuc": BookName.HABACUC,
    "Haggeo": BookName.HAGGEO,
    "Hebreos": BookName.HEBREOS,
    "Hechos": BookName.HECHOS,
    "Isaías": BookName.ISAAS,
    "Jeremías": BookName.JEREMAS,
    "Job": BookName.JOB,
    "Joel": BookName.JOEL,
    "Jonás": BookName.JONS,
    "Josué": BookName.JOSU,
    "Juan": BookName.JUAN,
    "Judas": BookName.JUDAS,
    "Jueces": BookName.JUECES,
    "Lamentaciones": BookName.LAMENTACIONES,
    "Levítico": BookName.LEVTICO,
    "Lucas": BookName.LUCAS,
    "Malaquías": BookName.MALAQUAS,
    "Marcos": BookName.MARCOS,
    "Mateo": BookName.MATEO,
    "Miqueas": BookName.MIQUEAS,
    "Nahum": BookName.NAHUM,
    "Nehemías": BookName.NEHEMAS,
    "Números": BookName.NMEROS,
    "Oseas": BookName.OSEAS,
    "Proverbios": BookName.PROVERBIOS,
    "Revelación": BookName.REVELACIN,
    "Romanos": BookName.ROMANOS,
    "Rut": BookName.RUT,
    "Salmos": BookName.SALMOS,
    "Santiago": BookName.SANTIAGO,
    "Sofonías": BookName.SOFONAS,
    "1 Corintios": BookName.THE_1_CORINTIOS,
    "1 Crónicas": BookName.THE_1_CRNICAS,
    "1 Juan": BookName.THE_1_JUAN,
    "1 Pedro": BookName.THE_1_PEDRO,
    "1 Reyes": BookName.THE_1_REYES,
    "1 Samuel": BookName.THE_1_SAMUEL,
    "1 Tesalonicenses": BookName.THE_1_TESALONICENSES,
    "1 Timoteo": BookName.THE_1_TIMOTEO,
    "2 Corintios": BookName.THE_2_CORINTIOS,
    "2 Crónicas": BookName.THE_2_CRNICAS,
    "2 Juan": BookName.THE_2_JUAN,
    "2 Pedro": BookName.THE_2_PEDRO,
    "2 Reyes": BookName.THE_2_REYES,
    "2 Samuel": BookName.THE_2_SAMUEL,
    "2 Tesalonicenses": BookName.THE_2_TESALONICENSES,
    "2 Timoteo": BookName.THE_2_TIMOTEO,
    "3 Juan": BookName.THE_3_JUAN,
    "Tito": BookName.TITO,
    "Éxodo": BookName.XODO,
    "Zacarías": BookName.ZACARAS
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
