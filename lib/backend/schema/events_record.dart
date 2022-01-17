import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'events_record.g.dart';

abstract class EventsRecord
    implements Built<EventsRecord, EventsRecordBuilder> {
  static Serializer<EventsRecord> get serializer => _$eventsRecordSerializer;

  @nullable
  String get eventName;

  @nullable
  DateTime get eventTime;

  @nullable
  String get eventDescription;

  @nullable
  String get eventPhoto;

  @nullable
  String get eventLocationName;

  @nullable
  LatLng get geopoint;

  @nullable
  LatLng get eventLocation;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(EventsRecordBuilder builder) => builder
    ..eventName = ''
    ..eventDescription = ''
    ..eventPhoto = ''
    ..eventLocationName = '';

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
  String eventName,
  DateTime eventTime,
  String eventDescription,
  String eventPhoto,
  String eventLocationName,
  LatLng geopoint,
  LatLng eventLocation,
}) =>
    serializers.toFirestore(
        EventsRecord.serializer,
        EventsRecord((e) => e
          ..eventName = eventName
          ..eventTime = eventTime
          ..eventDescription = eventDescription
          ..eventPhoto = eventPhoto
          ..eventLocationName = eventLocationName
          ..geopoint = geopoint
          ..eventLocation = eventLocation));
