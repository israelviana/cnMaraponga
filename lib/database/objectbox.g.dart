// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again:
// With a Flutter package, run `flutter pub run build_runner build`.
// With a Dart package, run `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import '../models/escala.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 7525113525840066986),
      name: 'Escala',
      lastPropertyId: const IdUid(4, 3979200119023121239),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 5958633621992571362),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 5644878590164432177),
            name: 'voluntario',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 7144672403460232853),
            name: 'data',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 3979200119023121239),
            name: 'hora',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Open an ObjectBox store with the model declared in this file.
Future<Store> openStore(
        {String directory,
        int maxDBSizeInKB,
        int fileMode,
        int maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(1, 7525113525840066986),
      lastIndexId: const IdUid(0, 0),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    Escala: EntityDefinition<Escala>(
        model: _entities[0],
        toOneRelations: (Escala object) => [],
        toManyRelations: (Escala object) => {},
        getId: (Escala object) => object.id,
        setId: (Escala object, int id) {
          object.id = id;
        },
        objectToFB: (Escala object, fb.Builder fbb) {
          final voluntarioOffset = object.voluntario == null
              ? null
              : fbb.writeString(object.voluntario);
          final dataOffset =
              object.data == null ? null : fbb.writeString(object.data);
          final horaOffset =
              object.hora == null ? null : fbb.writeString(object.hora);
          fbb.startTable(5);
          fbb.addInt64(0, object.id ?? 0);
          fbb.addOffset(1, voluntarioOffset);
          fbb.addOffset(2, dataOffset);
          fbb.addOffset(3, horaOffset);
          fbb.finish(fbb.endTable());
          return object.id ?? 0;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Escala(
              voluntario: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 6),
              data: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 8),
              hora: const fb.StringReader(asciiOptimization: true)
                  .vTableGetNullable(buffer, rootOffset, 10))
            ..id =
                const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 4);

          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [Escala] entity fields to define ObjectBox queries.
class Escala_ {
  /// see [Escala.id]
  static final id = QueryIntegerProperty<Escala>(_entities[0].properties[0]);

  /// see [Escala.voluntario]
  static final voluntario =
      QueryStringProperty<Escala>(_entities[0].properties[1]);

  /// see [Escala.data]
  static final data = QueryStringProperty<Escala>(_entities[0].properties[2]);

  /// see [Escala.hora]
  static final hora = QueryStringProperty<Escala>(_entities[0].properties[3]);
}
