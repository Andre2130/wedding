import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'events_record.g.dart';

abstract class EventsRecord
    implements Built<EventsRecord, EventsRecordBuilder> {
  static Serializer<EventsRecord> get serializer => _$eventsRecordSerializer;

  @nullable
  String get name;

  @nullable
  DateTime get time;

  @nullable
  BuiltList<String> get categories;

  @nullable
  DateTime get date;

  @nullable
  String get description;

  @nullable
  BuiltList<String> get photos;

  @nullable
  String get mainImage;

  @nullable
  String get address;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(EventsRecordBuilder builder) => builder
    ..name = ''
    ..categories = ListBuilder()
    ..description = ''
    ..photos = ListBuilder()
    ..mainImage = ''
    ..address = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('events');

  static Stream<EventsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<EventsRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  EventsRecord._();
  factory EventsRecord([void Function(EventsRecordBuilder) updates]) =
      _$EventsRecord;

  static EventsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createEventsRecordData({
  String name,
  DateTime time,
  DateTime date,
  String description,
  String mainImage,
  String address,
}) =>
    serializers.toFirestore(
        EventsRecord.serializer,
        EventsRecord((e) => e
          ..name = name
          ..time = time
          ..categories = null
          ..date = date
          ..description = description
          ..photos = null
          ..mainImage = mainImage
          ..address = address));
