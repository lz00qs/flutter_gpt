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

import 'objectbox/entities/app_config.dart';
import 'objectbox/entities/chat.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 4412893571819619544),
      name: 'AppConfig',
      lastPropertyId: const IdUid(6, 3532339673847648150),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 1971913969785146892),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 193725549359031643),
            name: 'openAiKey',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 3422288503863761176),
            name: 'showTimeStamp',
            type: 1,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 6677291022891467517),
            name: 'showName',
            type: 1,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 2892204470355544442),
            name: 'userName',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 3532339673847648150),
            name: 'botName',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(2, 2237951336271112569),
      name: 'Chat',
      lastPropertyId: const IdUid(4, 965704201464810134),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 4641524981435777084),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 7887566119022192343),
            name: 'name',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 2413186751380218019),
            name: 'timestamp',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 965704201464810134),
            name: 'messagesJson',
            type: 30,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Open an ObjectBox store with the model declared in this file.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
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
      lastEntityId: const IdUid(2, 2237951336271112569),
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
    AppConfig: EntityDefinition<AppConfig>(
        model: _entities[0],
        toOneRelations: (AppConfig object) => [],
        toManyRelations: (AppConfig object) => {},
        getId: (AppConfig object) => object.id,
        setId: (AppConfig object, int id) {
          object.id = id;
        },
        objectToFB: (AppConfig object, fb.Builder fbb) {
          final openAiKeyOffset = fbb.writeString(object.openAiKey);
          final userNameOffset = fbb.writeString(object.userName);
          final botNameOffset = fbb.writeString(object.botName);
          fbb.startTable(7);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, openAiKeyOffset);
          fbb.addBool(2, object.showTimeStamp);
          fbb.addBool(3, object.showName);
          fbb.addOffset(4, userNameOffset);
          fbb.addOffset(5, botNameOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = AppConfig(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              openAiKey: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 6, ''))
            ..showTimeStamp =
                const fb.BoolReader().vTableGet(buffer, rootOffset, 8, false)
            ..showName =
                const fb.BoolReader().vTableGet(buffer, rootOffset, 10, false)
            ..userName = const fb.StringReader(asciiOptimization: true)
                .vTableGet(buffer, rootOffset, 12, '')
            ..botName = const fb.StringReader(asciiOptimization: true)
                .vTableGet(buffer, rootOffset, 14, '');

          return object;
        }),
    Chat: EntityDefinition<Chat>(
        model: _entities[1],
        toOneRelations: (Chat object) => [],
        toManyRelations: (Chat object) => {},
        getId: (Chat object) => object.id,
        setId: (Chat object, int id) {
          object.id = id;
        },
        objectToFB: (Chat object, fb.Builder fbb) {
          final nameOffset = fbb.writeString(object.name);
          final timestampOffset = fbb.writeString(object.timestamp);
          final messagesJsonOffset = fbb.writeList(
              object.messagesJson.map(fbb.writeString).toList(growable: false));
          fbb.startTable(5);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, nameOffset);
          fbb.addOffset(2, timestampOffset);
          fbb.addOffset(3, messagesJsonOffset);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Chat(
              id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0),
              name: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 6, ''),
              timestamp: const fb.StringReader(asciiOptimization: true)
                  .vTableGet(buffer, rootOffset, 8, ''),
              messagesJson: const fb.ListReader<String>(
                      fb.StringReader(asciiOptimization: true),
                      lazy: false)
                  .vTableGet(buffer, rootOffset, 10, []));

          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [AppConfig] entity fields to define ObjectBox queries.
class AppConfig_ {
  /// see [AppConfig.id]
  static final id = QueryIntegerProperty<AppConfig>(_entities[0].properties[0]);

  /// see [AppConfig.openAiKey]
  static final openAiKey =
      QueryStringProperty<AppConfig>(_entities[0].properties[1]);

  /// see [AppConfig.showTimeStamp]
  static final showTimeStamp =
      QueryBooleanProperty<AppConfig>(_entities[0].properties[2]);

  /// see [AppConfig.showName]
  static final showName =
      QueryBooleanProperty<AppConfig>(_entities[0].properties[3]);

  /// see [AppConfig.userName]
  static final userName =
      QueryStringProperty<AppConfig>(_entities[0].properties[4]);

  /// see [AppConfig.botName]
  static final botName =
      QueryStringProperty<AppConfig>(_entities[0].properties[5]);
}

/// [Chat] entity fields to define ObjectBox queries.
class Chat_ {
  /// see [Chat.id]
  static final id = QueryIntegerProperty<Chat>(_entities[1].properties[0]);

  /// see [Chat.name]
  static final name = QueryStringProperty<Chat>(_entities[1].properties[1]);

  /// see [Chat.timestamp]
  static final timestamp =
      QueryStringProperty<Chat>(_entities[1].properties[2]);

  /// see [Chat.messagesJson]
  static final messagesJson =
      QueryStringVectorProperty<Chat>(_entities[1].properties[3]);
}
